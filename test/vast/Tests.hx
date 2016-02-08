package vast;

import haxe.xml.Fast;
import Std;
import Std;
import haxe.ds.StringMap;
import vast.TestTypes.AdTestType;
import vast.TestTypes.CreativeLinearTestType;
import bs.tools.Trace;
import haxe.Json;
import bs.model.vast.ad.creatives.Click;
import bs.model.vast.ad.creatives.nonlinears.NonLinearAds;
import bs.model.VastError;
import bs.model.vast.Vast;
import bs.vast.VASTClient;
import massive.munit.Assert;
import massive.munit.async.AsyncFactory;
import bs.model.vast.ad.creatives.linear.Icon;
import bs.model.vast.ad.creatives.linear.MediaFile;
import bs.model.vast.ad.creatives.nonlinears.NonLinear;
import bs.model.vast.ad.creatives.linear.Linear;
import bs.model.vast.ad.creatives.companion.Companion;
import bs.model.vast.ad.creatives.CreativeDetails;
import bs.model.vast.ad.creatives.Creative;
import bs.model.vast.ad.Impression;
import bs.model.vast.ad.Ad;



class Tests
{
	var data:Vast;
	var name:String;
	var asyncHandler:Dynamic;

	public function new() {}

	@Before
	public function setup():Void {
		name = Type.getClassName(Type.getClass(this));
		log('START');
	}

	@After
	public function tearDown():Void {
		log('STOP');
	}

	function log(data:Dynamic):Void {
#if js
		js.Browser.console.log(data);
#end
//		trace(Json.stringify(data, null, '  '));
		trace(data);
	}

	public function vast(factory:AsyncFactory, url:String):Void {
		asyncHandler = factory.createHandler(this, testStart, 6000);
		VASTClient.getVast(url, parseVAST, getVastError);
	}

	function parseVAST(data:Xml):Void {
		VASTClient.parseVast(data, onVastParseSuccess, parseVastError);
	}

	function onVastParseSuccess(data:Vast):Void {
		this.data = data;
		//trace(Json.stringify(data, null, '  '));
#if js
		js.Browser.console.log(data);
#end
		asyncHandler();
	}

	function getVastError(data:VastErrorEvent, ?additionalInfo:String = null):Void {
		log('ERROR getVast ' + data.code + ' ' + data.description + ' / ' + additionalInfo);
		//Assert.fail('ERROR getVast ' + data.code + ' ' + data.description + ' / ' + additionalInfo);
	}
	function parseVastError(data:VastErrorEvent, ?additionalInfo:String = null):Void {
		log('ERROR parseVast ' + data.code + ' ' + data.description + ' / ' + additionalInfo);
		//Assert.fail('ERROR parseVast ' + data.code + ' ' + data.description + ' / ' + additionalInfo);
	}

	public function testStart():Void {

		Assert.isNotNull(data.version);
		Assert.isNotNull(data.ads);
		if (data.ads.length < 1 )
			Assert.fail('VAST ads.length < 1');

		if (data.version == VastVersion.v_1_0) {
			checkAdsV1(data.ads);
			log('TEST ' + VastVersion.v_1_0);
		}
		else if (data.version == VastVersion.v_2_0) {
			checkAdsV2(data.ads);
			log('TEST ' + VastVersion.v_2_0);
		}
		else if (data.version == VastVersion.v_3_0) {
			checkAdsV3(data.ads);
			log('TEST ' + VastVersion.v_3_0);
		}
	}

	function checkAdsV1(ads:Array<Ad>):Void {
		for(ad in ads) {
			Assert.isNotNull(ad.system);
			Assert.isNotNull(ad.title);
		}
	}

	function checkAdsV2(ads:Array<Ad>):Void {
		for(ad in ads) {
			Assert.isNotNull(ad.id);
			Assert.isNotNull(ad.system);
			Assert.isNotNull(ad.title);
			Assert.isNotNull(ad.impressions);
			checkAdImpresions(ad.impressions);
			Assert.isNotNull(ad.creatives);
			checkAdCreatives(ad.creatives);
		}
	}

	function checkAdsV3(ads:Array<Ad>):Void {

		for(ad in ads) {
			Assert.isNotNull(ad.id);
			Assert.isNotNull(ad.sequence);
			Assert.isNotNaN(ad.sequence);
			Assert.areNotEqual(0, ad.sequence);
			Assert.isNotNull(ad.system);
			Assert.isNotNull(ad.title);
			Assert.isNotNull(ad.impressions);

//			if (ad.impressions.length < 1 )
//				Assert.fail('VAST Ad impressions.length < 1');
			checkAdImpresions(ad.impressions);

			Assert.isNotNull(ad.creatives);
//			if (ad.creatives.length < 1 )
//				Assert.fail('VAST Ad creatives.length < 1');
			checkAdCreatives(ad.creatives);
		}
	}










	public function checkMap(name:String, map:Dynamic, input:Dynamic):Void {
		Assert.isNotNull(input);
		Assert.isNotNull(map);
		var keys = Reflect.fields(map);
		for (key in keys) {
			trace('$name.$key');
			if (Reflect.hasField(input, key)) {
				checkMapItem('$name.$key', Reflect.field(map, key), Reflect.field(input, key));
			} else {
				Assert.isFalse(Reflect.hasField(input, key));
				Assert.isNull(Reflect.field(input, key));
				//trace('[OK][NULL] $name.$key');
			}
		}
	}
	function checkMapItem(name:String, ?map:Dynamic=null , ?input:Dynamic=null):Void {
		if (Std.is(map, Array) ) {
			Assert.isNotNull(map);
			Assert.isNotNull(input);
			Assert.areEqual(map.length,input.length);
			for (idx in 0...map.length)
				checkMapItem('$name.[$idx]', map[idx], input[idx]);
		} else
		if (Std.is(map,String)) {
			Assert.isNotNull(map);
			Assert.isNotNull(input);
			Assert.areEqual(map, input);
		} else
		if (Std.is(map, Fast)) {
			Assert.isNotNull(map);
			Assert.isNotNull(input);
			Assert.areEqual(map.toString(), input.toString());
		} else
		if (Std.is(map,Float)) {
			Assert.isNotNaN(Std.parseFloat(map));
			Assert.isNotNaN(Std.parseFloat(input));
			Assert.areEqual(map, input);
		} else
		if (Reflect.isObject(map)) {
			Assert.isNotNull(map);
			Assert.isNotNull(input);
				checkMap(name, map, input);
		}
		else {
			Assert.isNotNull(map);
			Assert.isNotNull(input);
			Assert.areEqual(map, input);
		}

	}









	function checkAdImpresions(impressions:Array<Impression>):Void {
		for(imp in impressions) {
			Assert.isNotNull(imp);
			Assert.isNotNull(imp.url);
		}
	}

	function checkAdCreatives(creatives:Array<Creative>):Void {
		for(cre in creatives) {
			Assert.isNotNull(cre);
			Assert.isNotNull(cre.details);
			for(detail in cre.details) {
				Assert.isNotNull(detail);
				switch(Type.getClassName(Type.getClass(detail))) {
					case "bs.model.vast.ad.creatives.companion.Companion":
						checkAdCreativeCompanion(cast detail);
					case "bs.model.vast.ad.creatives.linear.Linear":
						checkAdCreativeLinear(cast detail);
					case "bs.model.vast.ad.creatives.nonlinears.NonLinear":
						checkAdCreativeNonLinear(cast detail);
					default : null;
				}
			}
		}
	}

	function checkAdCreativeCompanion(comp:Companion):Void {
		Assert.isNotNaN(comp.width);
		Assert.isNotNaN(comp.height);
	}

	function checkAdCreativeNonLinear(nlin:NonLinear):Void {
		Assert.isNotNaN(nlin.width);
		Assert.isNotNaN(nlin.height);
	}

	function checkAdCreativeLinear(lin:Linear):Void {
		Assert.isNotNaN(lin.duration);

		Assert.isNotNull(lin.mediaFiles);
		if (lin.mediaFiles != null)
			checkAdCreativeLinearMediaFiles(lin.mediaFiles);

		if (lin.icons != null)
			checkAdCreativeLinearIcons(lin.icons);
	}

	function checkAdCreativeLinearMediaFiles(mediaFiles:Array<MediaFile>):Void {
		for(mf in mediaFiles) {
			Assert.isNotNull(mf.delivery);
			Assert.isNotNull(mf.type);
			Assert.isNotNaN(mf.width);
			Assert.isNotNaN(mf.height);
		}
	}

	function checkAdCreativeLinearIcons(icons:Array<Icon>):Void {
		for(ico in icons) {
			Assert.isNotNull(ico.program);
			Assert.isNotNaN(ico.width);
			Assert.isNotNaN(ico.height);
			Assert.isNotNaN(ico.xPosition);
			Assert.isNotNaN(ico.yPosition);
		}
	}


	public function comparObject(map:Dynamic, data:Dynamic, ?title:String = null):Void
	{
		Assert.isNotNull(map);
		Assert.isNotNull(data);
		for (key in Reflect.fields(map)){
			if (title != null)
				trace('$title.$key :[${Reflect.field(data , key)}]==[${Reflect.field(map, key)}]');
			if (Reflect.hasField(data , key)) {
				var dataItem = Reflect.field(data , key);
				var mapItem = Reflect.field(map , key);
					var dataItemType = Type.getClassName(Type.getClass(dataItem));
					if (dataItemType == 'Int' || dataItemType == 'Float')
						Assert.isNotNaN(dataItem);
					else
						Assert.isNotNull(dataItem);
					Assert.areEqual(dataItem, mapItem);
			}
			else
				Assert.isFalse(Reflect.hasField(data , key));
		}
	}
////////////////////////////
	public function checkAd(ad:Ad, adMap:AdTestType):Void {
//							id:String, system:String, title:String, impressions:Array<String>, creativesLength:Int,
//							optional:AdOptional):Void {
//required
		Assert.isNotNull(ad.id);
		Assert.areEqual(adMap.id, ad.id);
		trace('\t ad.id - ok');

		Assert.isNotNull(ad.system);
		Assert.areEqual(adMap.system, ad.system.name);
		trace('\t ad.system.name - ok');

		Assert.isNotNull(ad.title);
		Assert.areEqual(adMap.title, ad.title);
		trace('\t ad.title - ok');

		Assert.isNotNull(ad.impressions);
		Assert.areEqual(adMap.impressions.length, ad.impressions.length);
		for (idx in 0...adMap.impressions.length)
			comparObject(adMap.impressions[idx],ad.impressions[idx], '\t ad.impressions');
		trace('\t ad.impressions - ok');

		Assert.isNotNull(ad.creatives);
		Assert.areEqual(adMap.creatives.length, ad.creatives.length);
		trace('\t ad.creatives.length - ok');


//optional
		if (adMap.ids != null) {
			Assert.isNotNull(ad.ids);
			Assert.areEqual(adMap.ids.length, ad.ids.length);
			for (idx in 0...adMap.ids.length) {
				Assert.isNotNull(ad.ids[idx]);
				Assert.areEqual(adMap.ids[idx], ad.ids[idx]);
			}
		}
		else Assert.isNull(ad.ids);
		trace('\t ad.ids - ok');

		if (adMap.description != null) {
			Assert.isNotNull(ad.description);
			Assert.areEqual(adMap.description, ad.description);
		}
		else Assert.isNull(ad.description);
		trace('\t ad.description - ok');

		if (adMap.errors != null) {
			Assert.isNotNull(ad.errors);
			Assert.areEqual(ad.errors.length, ad.errors.length);
			for (idx in 0...adMap.errors.length) {
				Assert.isNotNull(ad.errors[idx]);
				Assert.areEqual(adMap.errors[idx], ad.errors[idx].url);
			}
		}
		else Assert.isNull(ad.errors);
		trace('\t ad.errors - ok');

		if (adMap.advertiser != null) {
			Assert.isNotNull(ad.advertiser);
			Assert.areEqual(adMap.advertiser, ad.advertiser);
		}
		else Assert.isNull(ad.advertiser);
		trace('\t ad.advertiser - ok');

		if (adMap.survey != null) {
			Assert.isNotNull(ad.survey);
			Assert.areEqual(adMap.survey, ad.survey);
		}
		else Assert.isNull(ad.survey);
		trace('\t ad.survey - ok');

		if (adMap.sequence != null) {
			Assert.isNotNaN(ad.sequence);
			Assert.areEqual(adMap.sequence, ad.sequence);
		}
		else Assert.isNaN(ad.sequence);
		trace('\t ad.sequence - ok');

		if (adMap.extensions != null) {
			Assert.isNotNull(ad.extensions);
			Assert.areEqual(adMap.extensions.length, ad.extensions.length);
			for (idx in 0...adMap.extensions.length) {
				Assert.isNotNull(ad.extensions[idx]);
				Assert.areEqual(adMap.extensions[idx], ad.extensions[idx]);
			}
		}
		else Assert.isNull(ad.extensions);
		trace('\t ad.extensions - ok');

		if (adMap.pricing != null) {
			Assert.isNotNull(ad.pricing);
			//TODO:
			//Assert.areEqual(pricing.length, ad.pricing.);
			//for (idx in 0...pricing.length) {
			//	Assert.isNotNull(ad.pricing[idx]);
				//Assert.areEqual(pricing[idx], ad.pricing[idx]);
			//}
			trace('\t ad.pricing - TODO');
		}
		else Assert.isNull(ad.pricing);
		trace('\t ad.pricing - ok');
	}



	public function checkCreative(creative:Creative, detailsLength:Int, ?adID:String = null,
								  ?adIDsMap:Array<Dynamic> = null, ?id:String=null, ?sequence:Int=null,
								  ?apiFramework:String = null):Void {

//		Assert.isNotNull(creative);
//
//		if (creativeMap.adID != null) {
//			Assert.isNotNull(creative.adID);
//			Assert.areEqual(creativeMap.adID, creative.adID);
//		} else Assert.isNull(creative.adID);
//		trace('\t ad.creative.adID - ok');
//
//		Assert.isNotNull(creative.details);
//		if (creativeMap.detailsLength  > 0)
//			Assert.areEqual(creativeMap.detailsLength, creative.details.length);
//
//		checkadIDs(creative, creativeMap.adIDsMap);
//		trace('\t ad.creative.details - ok');
//
//		if (creativeMap.id != null) {
//			Assert.isNotNull(creative.id);
//			Assert.areEqual(creativeMap.id, creative.id);
//		} else Assert.isNull(creative.id);
//		trace('\t ad.creative.id - ok');
//
//		if (creativeMap.sequence != null) {
//			Assert.isNotNull(creative.sequence);
//			Assert.areEqual(creativeMap.sequence, creative.sequence);
//		} else Assert.isNull(creative.sequence);
//		trace('\t ad.creative.sequence - ok');
//
//		if (creativeMap.apiFramework != null) {
//			Assert.isNotNull(creative.apiFramework);
//			Assert.areEqual(creativeMap.apiFramework, creative.apiFramework);
//		} else Assert.isNull(creative.apiFramework);
//		trace('\t ad.creative.apiFramework - ok');
	}

	public function checkadIDs(creative:Creative, ?adIDsMap:Array<Dynamic> = null):Void {
		if (adIDsMap != null) {
			Assert.isNotNull(creative.adIDs);
			Assert.areEqual(adIDsMap.length, creative.adIDs.length);
			for (idx in 0...adIDsMap.length) {
				Assert.isNotNull(creative.adIDs[idx]);
				Assert.areEqual(adIDsMap[idx], creative.adIDs[idx]);
			}
		} else Assert.isNull(creative.adIDs);
	}

	public function checkLinear(detail:Dynamic, duration:Int, mediaFileMap:MediaFile,
						 ?trackingEventsMap:Array<Dynamic> = null, ?videoClicksMap:Array<Dynamic> = null,
						 ?iconsMap:Array<Dynamic> = null):Void
	{
		Assert.isNotNull(detail);
		Assert.isType(detail, Linear);
		var linear:Linear = cast detail;
		Assert.isNotNull(linear);
		trace('\t ad.creative.linear - ok');

		Assert.isNotNull(linear.duration);
		Assert.areEqual(duration, linear.duration);
		trace('\t ad.creative.linear.duration - ok');

		checkMediaFile(detail, mediaFileMap);

		if (trackingEventsMap != null)
			checkTrackingEventsMap(linear, trackingEventsMap);
		trace('\t ad.creative.linear.TrackingEvents - ok');
		if (videoClicksMap != null)
			checkVideoClicksMap(linear, videoClicksMap);
		trace('\t ad.creative.linear.VideoClicks - ok  .');

	}

	public function checkNonLinearAds(details:Dynamic, nonLinearMap:Array<Dynamic>,
											 ?trackingEventsMap:Array<Dynamic> = null):Void
	{
		Assert.isNotNull(details);
		Assert.isType(details, NonLinearAds);
		checkTrackingEventsMap(details, trackingEventsMap);
		var nonLinearAds:NonLinearAds = cast details;
		Assert.isNotNull(nonLinearAds.nonLinear);
		trace('\t ad.creative.nonLinearAds - ok');

		Assert.isNotNull(nonLinearAds.nonLinear);
		Assert.areEqual(nonLinearMap.length, nonLinearAds.nonLinear.length);
		trace('\t ad.creative.nonLinearAds.nonLinear.length - ok');
		for (idx in 0...nonLinearMap.length) {
			Assert.isNotNull(nonLinearAds.nonLinear[idx]);
			//TODO:
			//Assert.areEqual(nonLinearMap[idx].t, nonLinearAds.nonLinear[idx].type);
			//Assert.areEqual(nonLinearMap[idx].u, nonLinearAds.nonLinear[idx].url);
			trace('\t ad.creative.nonLinearAds.nonLinear[$idx] - TODO');
		}

	}

	public function checkCompanion(detail:Dynamic, width:Int, height:Int, resourcesMap:Array<Dynamic>,
								   ?trackingEventsMap:Array<Dynamic> = null,
								   ?videoClicksMap:Array<Dynamic>=null, ?id:String=null):Void
	{
		Assert.isNotNull(detail);
		Assert.isType(detail, Companion);
		var companion:Companion = cast detail;
		Assert.isNotNull(companion);
		trace('\t ad.creative.companion - ok');

		//require
		Assert.areEqual(width, companion.width);
		trace('\t ad.creative.companion.width - ok');

		Assert.areEqual(height, companion.height);
		trace('\t ad.creative.companion.height - ok');

		//optional
		/**
		id: an optional identifier for the creative
		• assetWidth: the pixel width of the creative
		• assetHeight: the pixel height of the creative
		• expandedWidth: the maximum pixel width of the creative in its expanded state
		• expandedHeight: the maximum pixel height of the creative in its expanded state
		• apiFramework: the API necessary to communicate with the creative if available
		• adSlotID: used to identify desired placement on a publisher’s page; values to be used should be
		discussed between publishers and advertisers
		• required: a value of either “all,” “any,” or “none” identifying whether (and how many) of the
		companion creative should be displayed with the ad (see section 2.3.3.4 for details)
		*/
		if (id != null) {
			Assert.isNotNull(companion.id);
			Assert.areEqual(id, companion.id);
		} else Assert.isNull(companion.id);
		trace('\t ad.creative.companion.id - ok');

		Assert.isNotNull(companion.resources);
		Assert.areEqual(resourcesMap.length, companion.resources.length);
		trace('\t ad.creative.companion.resources.length - ok');

		for (idx in 0...resourcesMap.length)
		{
			Assert.isNotNull(companion.resources[idx]);
			Assert.areEqual(resourcesMap[idx].t, companion.resources[idx].type);
			Assert.areEqual(resourcesMap[idx].c, companion.resources[idx].creativeType);
			Assert.areEqual(resourcesMap[idx].u, companion.resources[idx].url);
		}
		trace('\t ad.creative.companion.resources - ok');

		checkTrackingEventsMap(detail, trackingEventsMap);
		trace('\t ad.creative.companion.trackingEvents - ok');
		checkVideoClicksMap(detail, videoClicksMap, true);
		trace('\t ad.creative.companion.videoClicks - ok');
	}




	public function checkVideoClicksMap(detail:Dynamic, ?videoClicksMap:Array<Dynamic>=null, ?isCompanion = false):Void
	{
		var clicks:Array<Click> = cast Reflect.field(detail, isCompanion ? 'clicks' : 'videoClicks');
		if (videoClicksMap != null) {
			Assert.isNotNull(clicks);
			Assert.areEqual(videoClicksMap.length, clicks.length);
			for (idx in 0...videoClicksMap.length) {
				Assert.isNotNull(clicks[idx]);
				Assert.areEqual(videoClicksMap[idx].t, clicks[idx].type);
				Assert.areEqual(videoClicksMap[idx].u, clicks[idx].url);
			}
		}else
			Assert.isNull(clicks);
	}

	public function checkTrackingEventsMap(detail:Dynamic, ?trackingEventsMap:Array<Dynamic> = null):Void
	{
		if (trackingEventsMap != null) {
			Assert.isNotNull(detail.trackingEvents);
			Assert.areEqual(trackingEventsMap.length, detail.trackingEvents.length);
			for (idx in 0...trackingEventsMap.length) {
				Assert.isNotNull(detail.trackingEvents[idx]);
				Assert.areEqual(trackingEventsMap[idx].e, detail.trackingEvents[idx].event);
				Assert.areEqual(trackingEventsMap[idx].u, detail.trackingEvents[idx].url);
			}
		} else
			Assert.isNull(detail.trackingEvents);
	}

	public function checkMediaFile(linear:Linear, mfMap:MediaFile):Void
	{
		Assert.isNotNull(linear.mediaFiles);
		Assert.areEqual(1, linear.mediaFiles.length);
		trace('\t ad.creative.linear.mediaFiles.length - ok');

		Assert.isNotNull(linear.mediaFiles[0]);
		var mf:MediaFile = linear.mediaFiles[0];

		Assert.areEqual(mfMap.delivery, mf.delivery);
		trace('\t ad.creative.linear.mediaFiles.delivery - ok');
		Assert.areEqual(mfMap.width, mf.width);
		trace('\t ad.creative.linear.mediaFiles.width - ok');
		Assert.areEqual(mfMap.height, mf.height);
		trace('\t ad.creative.linear.mediaFiles.height - ok');
		Assert.areEqual(mfMap.type, mf.type);
		trace('\t ad.creative.linear.mediaFiles.type - ok');
		Assert.areEqual(mfMap.url, mf.url);
		trace('\t ad.creative.linear.mediaFiles.url - ok');
		//optional
		if (mfMap.apiFramework != null)
			Assert.areEqual(mfMap.apiFramework, mf.apiFramework);
		else Assert.isNull(mf.apiFramework);
		trace('\t ad.creative.linear.mediaFiles.apiFramework - ok');

		if (mfMap.id != null)
			Assert.areEqual(mfMap.id, mf.id);
		else Assert.isNull(mf.id);
		trace('\t ad.creative.linear.mediaFiles.id - ok');

		if (mfMap.bitrate != null)
			Assert.areEqual(mfMap.bitrate, mf.bitrate);
		else Assert.isNull(mf.bitrate);
		trace('\t ad.creative.linear.mediaFiles.bitrate - ok');

		if (mfMap.minBitrate != null)
			Assert.areEqual(mfMap.minBitrate, mf.minBitrate);
		else Assert.isNull(mf.minBitrate);
		trace('\t ad.creative.linear.mediaFiles.minBitrate - ok');

		if (mfMap.maxBitrate != null)
			Assert.areEqual(mfMap.maxBitrate, mf.maxBitrate);
		else Assert.isNull(mf.maxBitrate);
		trace('\t ad.creative.linear.mediaFiles.maxBitrate - ok');

		if (mfMap.scalable != null)
			Assert.areEqual(mfMap.scalable, mf.scalable);
		else Assert.isNull(mf.scalable);
		trace('\t ad.creative.linear.mediaFiles.scalable - ok');

		if (mfMap.maintainAspectRatio != null)
			Assert.areEqual(mfMap.maintainAspectRatio, mf.maintainAspectRatio);
		else Assert.isNull(mf.maintainAspectRatio);
		trace('\t ad.creative.linear.mediaFiles.maintainAspectRatio - ok');

		if (mfMap.codec != null)
			Assert.areEqual(mfMap.codec, mf.codec);
		else Assert.isNull(mf.codec);
		trace('\t ad.creative.linear.mediaFiles.codec - ok');

	}

}