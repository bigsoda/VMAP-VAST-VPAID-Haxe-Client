package bs.parser;
import haxe.ds.StringMap;
import bs.tools.Delimiter;
import bs.model.HttpError;
import bs.model.VastError;
import bs.tools.Trace;
import haxe.Constraints.Function;
import haxe.xml.Fast;
import js.html.XMLDocument;
import js.html.XMLHttpRequest;
import js.html.XMLSerializer;
/**
 * ...
 * @author Piotr Skolysz <piotr.skolysz@bigsoda.pl>
 */
class Wrapper
{
	//TODO marge campanions in creatives
	
	/**
	 * Maximum number of chain wrapper.
	 */
	public static var maxWrapperChain = 5;
	
	static var currentWrapperChain:Map<String,Int> = new Map<String,Int>();
	static var orginalVast:Xml;
	static var success:Xml->Void;
	static var error:VastErrorEvent->Null<String>->Void;
	static var warn:Dynamic->Void;

	public function new() 
	{
		
	}
	/**
	 * Check if there are any tag wrappers in vast.
	 * @param vast VAST Xml with or without wrappers
	 * @return VAST Xml without wrappers
	 */
	public static function check(vast:Xml, onSuccess:Xml->Void, onError:VastErrorEvent->Null<String>->Void, onWarn:Dynamic->Void):Void
	{
		orginalVast = vast;
		success = onSuccess;
		error = onError;
		warn = onWarn;
		checkForWrappers(vast);

		// added ids attribute to Ad tag for collecting Ad ids
		for (ad in orginalVast.firstElement().elementsNamed('Ad'))
			ad.set('ids', ad.get('id'));
	}
	
	
	static function checkForWrappers(xml:Xml):Void
	{
		var isWrapper:Bool = false;
		
		for (ad in xml.firstElement().elementsNamed("Ad")) {
			if (ad.firstElement().nodeName == "Wrapper") {
				isWrapper = true;
				if (wrapperGetMaxChain(ad)) {
					warn(VastError.CODE_302);
					continue;
				}
				
				loadXML(ad.firstElement().elementsNamed("VASTAdTagURI").next().firstChild().nodeValue);
				break;
			}
		}
		if (!isWrapper) success(orginalVast);
	}
	
	static private function wrapperGetMaxChain(ad:Xml):Bool
	{
		if(!ad.exists("bs-uid"))
			generateAdUid(ad);
		
		if (!currentWrapperChain.exists(ad.get("bs-uid")))
			currentWrapperChain.set(ad.get("bs-uid"), 1);
		else 
			currentWrapperChain.set(ad.get("bs-uid"), currentWrapperChain.get(ad.get("bs-uid")) + 1);
		
		return currentWrapperChain.get(ad.get("bs-uid")) == (maxWrapperChain+1);
	}
	
	static private function generateAdUid(ad:Xml) 
	{
		var chars =  "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
		var uid = "";
		
		for (i in 0...50) {
			uid += chars.charAt(Math.floor(Math.random() * (chars.length - 1)));
		}
		
		uid += "."+ Date.now().getTime();
		ad.set("bs-uid", uid);
	}
	
	static function loadXML(url:String):Void
	{
		var req:XMLHttpRequest = new XMLHttpRequest();
		req.onerror = function():Void {
			//Trace.info("error: " + req.status);
		}
		
		req.onloadend = function():Void	{
			if (req.status == 200) 
				mergeVast(Xml.parse(req.response));
			else {
				mergeVast(Xml.parse("<VAST/>"));
				//Trace.info("loadXML - 2");
			}
		}; 
		req.open('GET', url);
		req.send();
	}
	
	static private function mergeVast(wrapper:Xml):Void
	{
		var orginalWrapper = Xml.parse("");
		var fastWrapper = new Fast(wrapper.firstElement());

		if (!fastWrapper.hasNode.Ad || (!fastWrapper.node.Ad.hasNode.Wrapper && !fastWrapper.node.Ad.hasNode.InLine)) {
			removeWrapperTag();
			checkForWrappers(orginalVast);
			warn(VastError.CODE_303);
			//Trace.log("mergeVast - IF");
			return;
		}

		for (ad in orginalVast.firstElement().elementsNamed("Ad")) {
			if (ad.firstElement().nodeName == "Wrapper") {

				// added ids attribute to Ad tag for collecting Ad ids
				ad.set('ids', ad.get('ids') + Delimiter.array + fastWrapper.node.Ad.att.id);

				// set closest to InLine Ad id
				if (fastWrapper.hasNode.Ad && fastWrapper.node.Ad.has.id)
					ad.set('id', fastWrapper.node.Ad.att.id);

				orginalWrapper = ad.firstElement();
				//removed orginal wrapper
				ad.removeChild(orginalWrapper);
				//add loaded wraper in place on removed wrapper
				ad.addChild(wrapper.firstElement().firstElement().firstElement());
				//add removed wrapper taggs to new wprapper
				addOldTags(ad, orginalWrapper);
				break;
			}
		}
		
		checkForWrappers(orginalVast);
	}
	
	static private function removeWrapperTag():Void
	{
		var orginalAd = Xml.parse("");
		for (ad in orginalVast.firstElement().elementsNamed("Ad")) {
			if (ad.firstElement().nodeName == "Wrapper") {
				orginalAd = Xml.parse(ad.toString());
				ad.removeChild(ad.firstElement());
				var inLine = Xml.createElement("InLine");
				ad.addChild(inLine);
				for (element in orginalAd.firstElement().firstElement().elements()) {	
					if (element.nodeName == "VASTAdTagURI") continue;
					ad.firstElement().addChild(element);
				}
				break;
			}
		}
	}
	
	static private function addOldTags(ad:Xml, orginalWrapper:Xml):Void 
	{
		log('__>_____________________________');
		adImpressions(ad, orginalWrapper);
		addErrors(ad, orginalWrapper);
		var adFast = new Fast(ad.firstElement());
		var wrapperFast = new Fast(orginalWrapper);
		addCreatives(adFast, wrapperFast);
		addExtensions(adFast, wrapperFast);
		log(adFast.x.toString());
		log('__<_____________________________');
	}
	
	static private function adImpressions(ad:Xml, wrapper:Xml)
	{
		for (impression in wrapper.elementsNamed("Impression")) {
			ad.firstElement().addChild(impression);
		}
	}
	
	static private function addErrors(ad:Xml, wrapper:Xml)
	{
		for (error in wrapper.elementsNamed("Error")) {
			ad.firstElement().addChild(error);
		}
	}

	static private function addExtensions(adFast:Fast, wrapperFast:Fast) {
		if (wrapperFast.hasNode.Extensions)
			if (!adFast.hasNode.Extensions)
				adFast.x.addChild(wrapperFast.node.Extensions.x);
			else
				for (ext in wrapperFast.node.Extensions.elements)
					adFast.node.Extensions.x.addChild(ext.x);
	}

	static private function addCreatives(adFast:Fast, wrapperFast:Fast) {
		if (wrapperFast.hasNode.Creatives) {
			if (!adFast.hasNode.Creatives) {
				adFast.x.addChild(wrapperFast.node.Creatives.x);
			} else {
				var wrapperCreativesData = searchCreativesInWrapper(wrapperFast.node.Creatives);
				var adCreativesFast = adFast.node.Creatives;
				for (wrapperCreative in wrapperCreativesData) {
					if (wrapperCreative.name != 'CompanionAds') {
						for (adCreativeFast in adCreativesFast.nodes.Creative)
							for (adCreativesNamed in adCreativeFast.x.elementsNamed(wrapperCreative.name))
								mergeWrapperCreatives(adCreativesNamed, wrapperCreative);
						if (!wrapperCreative.used)
							addNewWrapperCreatives(adCreativesFast.x, wrapperCreative);
					}
					else {
						/**http://www.iab.com/wp-content/uploads/2015/06/VASTv3_0.pdf
						* page 53 - 2.4.1.7 Wrapper Conflict Management and Precedence
						*
						* When Companion creative are included directly in the Wrapper response, conflict may occur.
						* In a VAST Ad, whether served with multiple Wrappers or in one Inline response, all creative
						* offered is intended to be part of the same creative concept, and the video player should
						* attempt to display all creative presented in the response (or in a chain of responses).
						* However, when conflict occurs, the video player should favor creative offered closest to the
						* Inline response.
						* (What 'conflict' means ?)
						*/
						//TODO: is this ok "favor creative offered closest to the Inline response"
						var adHasCompanionAds = false;
						for (adCreativeFast in adCreativesFast.nodes.Creative)
							if (!adHasCompanionAds) adHasCompanionAds = adCreativeFast.hasNode.CompanionAds; else break;
						if (!adHasCompanionAds)
							addNewWrapperCreatives(adCreativesFast.x, wrapperCreative);
					}
				}
			}
		}
	}

	static private function searchCreativesInWrapper(wrapperCreatives:Fast):Array<CreativeData>
	{
//		log(' > - search in wrapper');
		var creatives:Array<CreativeData> = [];
		for (creative in wrapperCreatives.nodes.Creative) {
			var cNode = creative.x.firstElement();

			var cData:CreativeData = {
				used:false,
				name:cNode.nodeName,
				data:[],
				attributes:new StringMap<String>()
			};

			for (attName in creative.x.attributes())
				cData.attributes.set(attName, creative.x.get(attName));

			for (cNodeElement in cNode.elements())
			{
				var cDataNode = {
					name:cNodeElement.nodeName,
					data:cNodeElement.elements(),
					attributes:new StringMap<String>()
				};

				for (attName in cNodeElement.attributes())
					cDataNode.attributes.set(attName, cNodeElement.get(attName));

				if (cDataNode.data.hasNext())
					cData.data.push(cDataNode);
			}
			if (cData.data.length > 0)
				creatives.push(cData);
		}
//		log(creatives);
//		log(' < - search in wrapper');
		return creatives;
	}

	static private function mergeWrapperCreatives(adCreatives:Xml, creativeData:CreativeData):Void
	{
		creativeData.used = true;
		if (creativeData.attributes.exists('AdIDs')) {
			adCreatives.parent.set('AdIDs',
				adCreatives.parent.get('AdID')
				+ Delimiter.array
				+ creativeData.attributes.get('AdIDs'));
		}
		else if (creativeData.attributes.exists('AdID')) {
			if (adCreatives.parent.exists('AdIDs'))
				adCreatives.parent.set('AdIDs',
				adCreatives.parent.get('AdIDs')
				+ Delimiter.array
				+ creativeData.attributes.get('AdID'));
			else
				adCreatives.parent.set('AdIDs',
				adCreatives.parent.get('AdID')
				+ Delimiter.array
				+ creativeData.attributes.get('AdID'));
		}

		for (creativeDataNode in creativeData.data) {
			var elementsFoundedByName = adCreatives.elementsNamed(creativeDataNode.name);
			if (!elementsFoundedByName.hasNext()) {
				adCreatives.addChild(Xml.createElement(creativeDataNode.name));
				elementsFoundedByName = adCreatives.elementsNamed(creativeDataNode.name);
			}

			for (elementsNamed in elementsFoundedByName)
				for (addNode in creativeDataNode.data)
					elementsNamed.addChild(addNode);
		}
	}

	static private function addNewWrapperCreatives(adCreatives:Xml, creativeData:CreativeData):Void
	{
		creativeData.used = true;
		var newCreativeXml = Xml.createElement('Creative');

		for (attName in creativeData.attributes.keys())
			newCreativeXml.set(attName, creativeData.attributes.get(attName));

		var newCreativeTypeXml = Xml.createElement(creativeData.name);
		for (creativeDataNode in creativeData.data) {
			var newCreativeNodeXml = Xml.createElement(creativeDataNode.name);

			for (attName in creativeDataNode.attributes.keys())
				newCreativeNodeXml.set(attName, creativeDataNode.attributes.get(attName));

			for (creativeDataNodeElement in creativeDataNode.data)
				newCreativeNodeXml.addChild(creativeDataNodeElement);

			newCreativeTypeXml.addChild(newCreativeNodeXml);
		}
		newCreativeXml.addChild(newCreativeTypeXml);

		adCreatives.addChild(newCreativeXml);
	}

	static function log(data:Dynamic):Void
	{
//		#if js
//		js.Browser.console.info(data);
//		#end
		//trace(data);
	}
}

typedef CreativeData = {
	var used:Bool;
	var name:String;
	var attributes:StringMap<String>;
	var data:Array<CreativeDataNode>;
}

typedef CreativeDataNode = {
	var name:String;
	var attributes:StringMap<String>;
	var data:Iterator<Xml>;
}



/*
				//SEARCH IN WRAPPER
				var wCreatives:Array<Dynamic> = [];
				for (wCreative in wrapperFast.node.Creatives.elements) {
					var wFirstElement = new Fast(wCreative.x.firstElement());

					var cre = {};
					//SEARCH FOR LINEAR/NON_LINEAR_ADS
					if (wFirstElement.name == 'Linear' || wFirstElement.name == 'NonLinearAds') {
						// SEARCH FOR 'TrackingEvents'
						if (wFirstElement.hasNode.TrackingEvents) {
							var te:Array<Xml> = [];
							for (wte in wFirstElement.node.TrackingEvents.elements)
								te.push(wte.x);
//							log('TrackingEvents: ' + te);
							if (te.length > 0) {
								if (!Reflect.hasField(cre, 'name'))
									Reflect.setField(cre, 'name', wFirstElement.name);
								Reflect.setField(cre, 'trackingEvents', te);
							}
						}
					}
					//SEARCH FOR LINEAR
					if (wFirstElement.name == 'Linear') {
						// SEARCH FOR 'VideoClicks'
						if (wFirstElement.hasNode.VideoClicks) {
							var vc:Array<Xml> = [];
							for (wte in wFirstElement.node.VideoClicks.elements)
								vc.push(wte.x);
//							log('VideoClicks: ' + vc);
							if (vc.length > 0) {
								if (!Reflect.hasField(cre, 'name'))
									Reflect.setField(cre, 'name', wFirstElement.name);
								Reflect.setField(cre, 'videoClicks', vc);
							}
						}
						// SEARCH FOR 'Icons'
						if (wFirstElement.hasNode.Icons) {
							var ic:Array<Xml> = [];
							for (wte in wFirstElement.node.Icons.elements)
								ic.push(wte.x);
//							log('Icons: ' + ic);
							if (ic.length > 0) {
								if (!Reflect.hasField(cre, 'name'))
									Reflect.setField(cre, 'name', wFirstElement.name);
								Reflect.setField(cre, 'icons', ic);
							}
						}
					}
					//SEARCH FOR NON_LINEAR_ADS
					if (wFirstElement.name == 'NonLinearAds') {
						// SEARCH FOR 'NonLinear'
						if (wFirstElement.hasNode.NonLinear) {
							var nl:Array<Xml> = [];
							for (wte in wFirstElement.node.NonLinear.elements)
								nl.push(wte.x);
//							log('NonLinear: ' + nl);
							if (nl.length > 0) {
								if (!Reflect.hasField(cre, 'name'))
									Reflect.setField(cre, 'name', wFirstElement.name);
								Reflect.setField(cre, 'nonLinear', nl);
							}
						}
					}
					//TODO:
					//SEARCH FOR COMPANION_ADS
					if (wFirstElement.name == 'CompanionAds') {
						// SEARCH FOR 'Companion'
						var cp:Array<Xml> = [];
						for (comp in wFirstElement.elements)
							cp.push(comp.x);
						if (cp.length > 0) {
							if (!Reflect.hasField(cre, 'name'))
								Reflect.setField(cre, 'name', wFirstElement.name);
							Reflect.setField(cre, 'companion', cp);
						}
					}
					if (Reflect.hasField(cre, 'name'))
						wCreatives.push(cre);

				}

				//// ADD TO ORIGINAL
				for (wCreative in wCreatives) {
					for (adCreative in adFast.node.Creatives.nodes.Creative) {
						if (adCreative.x.elementsNamed(wCreative.name).hasNext()) {

							log('ADD TO EXISTING: ' + wCreative.name);

							for (adCreativeFirst in adCreative.x.elementsNamed(wCreative.name)) {
								var adCreativeFirstFast = new Fast(adCreativeFirst);

								// MERGE 'TrackingEvents'
								addToExistingCreative(adCreativeFirstFast,'TrackingEvents', wCreative);
//								if (Reflect.hasField(wCreative, 'trackingEvents')) {
//									if (!adCreativeFirstFast.hasNode.TrackingEvents)
//										adCreativeFirstFast.x.addChild(Xml.parse('<TrackingEvents/>'));
//									for (idx in 0...wCreative.trackingEvents.length)
//										adCreativeFirstFast.node.TrackingEvents.x.addChild(wCreative.trackingEvents[idx]);
//								}
								// MERGE 'videoClicks'
								if (Reflect.hasField(wCreative,'videoClicks')) {
									if (!adCreativeFirstFast.hasNode.VideoClicks)
										adCreativeFirstFast.x.addChild(Xml.parse('<VideoClicks/>'));
									for (idx in 0...wCreative.videoClicks.length)
										adCreativeFirstFast.node.VideoClicks.x.addChild(wCreative.videoClicks[idx]);
								}
								// MERGE 'icons'
								if (Reflect.hasField(wCreative,'icons')) {
									if (!adCreativeFirstFast.hasNode.Icons)
										adCreativeFirstFast.x.addChild(Xml.parse('<Icons/>'));
									for (idx in 0...wCreative.icons.length)
										adCreativeFirstFast.node.Icons.x.addChild(wCreative.icons[idx]);
								}
								// MERGE 'NonLinear'
								if (Reflect.hasField(wCreative,'nonLinear')) {
									if (!adCreativeFirstFast.hasNode.NonLinear)
										adCreativeFirstFast.x.addChild(Xml.parse('<NonLinear/>'));
									for (idx in 0...wCreative.nonLinear.length)
										adCreativeFirstFast.node.NonLinear.x.addChild(wCreative.nonLinear[idx]);
								}
								// MERGE 'Companion'
								if (Reflect.hasField(wCreative,'companion')) {
									if (!adCreativeFirstFast.hasNode.Companion)
										adCreativeFirstFast.x.addChild(Xml.parse('<Companion/>'));
									for (idx in 0...wCreative.companion.length)
										adCreativeFirstFast.node.Companion.x.addChild(wCreative.companion[idx]);
								}
							}

						} else {
							log('ADD NEW: ' + wCreative.name);
							addNewCreative(adFast, 'companion', wCreative);
						}
					}
				}
			*/

//	static private function addToExistingCreative(adFast:Fast, name:String, creativeData:Dynamic):Void {
//
//
//		if (Reflect.hasField(creativeData, 'trackingEvents')) {
//			if (!adFast.hasNode.TrackingEvents)
//				adFast.x.addChild(Xml.parse('<TrackingEvents/>'));
//			for (idx in 0...creativeData.trackingEvents.length)
//				adFast.node.TrackingEvents.x.addChild(creativeData.trackingEvents[idx]);
//		}
//
//
//	}
//
//	static private function addNewCreative(adFast:Fast, name:String, creativeData:Dynamic):Void {
//		if (Reflect.hasField(creativeData, name)) {
//			var newCreative = Xml.parse('<Creative><${creativeData.name}/></Creative>');
//			var data:Array<Xml> = Reflect.field(creativeData, name);
//			for (idx in 0...data.length)
//				newCreative.firstElement().addChild(data[idx]);
//
//			adFast.node.Creatives.x.addChild(newCreative);
//		}
//	}

/*
	static private function addCreatives(adFast:Fast, wrapperFast:Fast) {
		var adHasCreatives = ad.firstElement().elementsNamed("Creatives").hasNext();
		var wrapperHasCreatives = wrapper.elementsNamed("Creatives").hasNext();
		//Trace.logColor("adHasCreatives: " + adHasCreatives +", wrapperHasCreatives: " + wrapperHasCreatives);

		if (!adHasCreatives && wrapperHasCreatives) {
			ad.firstElement().addChild(wrapper.elementsNamed("Creatives").next());
		}

		if (adHasCreatives && wrapperHasCreatives) {
			for (creative in wrapper.elementsNamed("Creatives").next().elementsNamed("Creative")) {
				//Linear Tracking
				//Trace.xmlFromString(ad.firstElement().elementsNamed("Creatives").next().elementsNamed("Creative").next().toString());
				//ad.firstElement().elementsNamed("Creatives").next().addChild(creative);

				for (tracking in creative.elementsNamed("Linear").next().elementsNamed("TrackingEvents").next().elementsNamed("Tracking")) {
					//TODO Ad doesn't have Tracking event
					//trace(tracking.toString());

//					if (!creative.elementsNamed("Linear").hasNext() || !creative.elementsNamed("Linear").next().elementsNamed("TrackingEvents").hasNext())
//						break;

					//var f:Fast = new Fast(ad.firstElement().elementsNamed("Creatives").next().elementsNamed("Creative").next().elementsNamed("Linear").next());
					//Trace.logColor("fast: " + f.hasNode.TrackingEvents);
					//Trace.logColor(ad.firstElement().elementsNamed("Creatives").next().elementsNamed("Creative").next().elementsNamed("Linear").next().elementsNamed("TrackingEvents").hasNext());

					if(ad.firstElement().elementsNamed("Creatives").next().elementsNamed("Creative").next().elementsNamed("Linear").next().elementsNamed("TrackingEvents").hasNext()) {
						ad.firstElement().elementsNamed("Creatives").next().elementsNamed("Creative").next().elementsNamed("Linear").next().elementsNamed("TrackingEvents").next().addChild(tracking);
					} else {
						//Trace.logColor("ADD TRACKING EVENTS");
						ad.firstElement().elementsNamed("Creatives").next().elementsNamed("Creative").next().elementsNamed("Linear").next().addChild(Xml.parse("<TrackingEvents></TrackingEvents>"));
						//ad.firstElement().elementsNamed("Creatives").next().elementsNamed("Creative").next().elementsNamed("Linear").next().elementsNamed("TrackingEvents").next().addChild(tracking);
					}

				}
				//Trace.xmlFromString(ad.firstElement().elementsNamed("Creatives").next().elementsNamed("Creative").next().toString());

				//Linear Video clicks
				//for (videoClick in creative.elementsNamed("Linear").next().elementsNamed("VideoClicks").next().elements())	{
					//ad.firstElement().elementsNamed("Creatives").next().elementsNamed("Creative").next().elementsNamed("Linear").next().elementsNamed("VideoClicks").next().addChild(videoClick);
				//}

			}
		}
	}


	/*
	static function newXMLHttpRequest(): XMLHttpRequest
	{
		if (requestFactory) {
			return Type.createInstance(requestFactory, []);
		}
		return new XMLHttpRequest();
	}
	*/
