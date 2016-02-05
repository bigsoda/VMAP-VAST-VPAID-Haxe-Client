package vast;

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

	public function vast(factory:AsyncFactory, url:String):Void {
		asyncHandler = factory.createHandler(this, testStart, 6000);
		VASTClient.getVast(url, parseVAST, getVastError);
	}

	function parseVAST(data:Xml):Void {
		VASTClient.parseVast(data, onVastParseSuccess, parseVastError);
	}

	function onVastParseSuccess(data:Vast):Void {
		this.data = data;
		log(data);
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

	function log(data:Dynamic):Void {
		#if js
		js.Browser.console.log(name, data);
		#end
		trace(Json.stringify(data, null, '  '));
	}

	public function testStart():Void {
		log('TEST');
		Assert.isNotNull(data.version);
		Assert.isNotNull(data.ads);
		if (data.ads.length < 1 )
			Assert.fail('VAST ads.length < 1');

		if (data.version == VastVersion.v_1_0) {
			checkAdsV1(data.ads);
		}
		else if (data.version == VastVersion.v_2_0) {
			checkAdsV2(data.ads);
		}
		else if (data.version == VastVersion.v_3_0) {
			checkAdsV3(data.ads);
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

		//Assert.isNotNull(lin.mediaFiles);
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



////////////////////////////
	public function checkAd(ad:Ad, id:String, system:String, title:String, impressions:Array<String>, creativesLength:Int,
							?ids:Array<String>=null, ?description:String=null, ?errors:Array<String>=null,
							?advertiser:String=null,?survey:String=null, ?sequence:Int=null,
							?extensions:Array<String>=null,?pricing:Array<Dynamic>=null):Void {
//required
		Assert.isNotNull(ad.id);
		Assert.areEqual(id, ad.id);

		Assert.isNotNull(ad.system);
		Assert.areEqual(system, ad.system.name);

		Assert.isNotNull(ad.title);
		Assert.areEqual(title, ad.title);

		Assert.isNotNull(ad.impressions);
		Assert.areEqual(impressions.length, ad.impressions.length);

		for (idx in 0...impressions.length) {
			Assert.isNotNull(ad.impressions[idx]);
			Assert.areEqual(impressions[idx], ad.impressions[idx].url);
		}

		Assert.isNotNull(ad.creatives);
		Assert.areEqual(creativesLength, ad.creatives.length);

//optional
		if (ids != null) {
			Assert.isNotNull(ad.ids);
			Assert.areEqual(ids.length, ad.ids.length);
			for (idx in 0...ids.length) {
				Assert.isNotNull(ad.ids[idx]);
				Assert.areEqual(ids[idx], ad.ids[idx]);
			}
		}
		else Assert.isNull(ad.ids);

		if (description != null) {
			Assert.isNotNull(ad.description);
			Assert.areEqual(description, ad.description);
		}
		else Assert.isNull(ad.description);

		if (errors != null) {
			Assert.isNotNull(ad.errors);
			Assert.areEqual(1, ad.errors.length);
			Assert.areEqual('http://myErrorURL/error', ad.errors[0].url);
		}
		else Assert.isNull(ad.errors);

		if (advertiser != null) {
			Assert.isNotNull(ad.advertiser);
			Assert.areEqual(advertiser, ad.advertiser);
		}
		else Assert.isNull(ad.advertiser);

		if (survey != null) {
			Assert.isNotNull(ad.survey);
			Assert.areEqual(advertiser, ad.survey);
		}
		else Assert.isNull(ad.survey);

		if (sequence != null) {
			Assert.isNotNaN(ad.sequence);
			Assert.areEqual(sequence, ad.sequence);
		}
		else Assert.isNaN(ad.sequence);


		if (extensions != null) {
			Assert.isNotNull(ad.extensions);
			Assert.areEqual(extensions.length, ad.extensions.length);
			for (idx in 0...extensions.length) {
				Assert.isNotNull(ad.extensions[idx]);
				Assert.areEqual(extensions[idx], ad.extensions[idx]);
			}
		}
		else Assert.isNull(ad.extensions);

		if (pricing != null) {
			Assert.isNotNull(ad.pricing);
			//TODO:
			//Assert.areEqual(pricing.length, ad.pricing.);
			//for (idx in 0...pricing.length) {
			//	Assert.isNotNull(ad.pricing[idx]);
				//Assert.areEqual(pricing[idx], ad.pricing[idx]);
			//}
		}
		else Assert.isNull(ad.pricing);
	}



	public function checkCreative(creative:Creative, detailsLength:Int, ?adID:String = null,
								  ?adIDsMap:Array<Dynamic> = null, ?id:String=null, ?sequence:Int=null,
								  ?apiFramework:String = null):Void {
		Assert.isNotNull(creative);
		if (adID != null) {
			Assert.isNotNull(creative.adID);
			Assert.areEqual(adID, creative.adID);
		} else Assert.isNull(creative.adID);

		Assert.isNotNull(creative.details);
		if (detailsLength > 0)
			Assert.areEqual(detailsLength, creative.details.length);

		checkadIDs(creative, adIDsMap);

		if (id != null) {
			Assert.isNotNull(creative.id);
			Assert.areEqual(id, creative.id);
		} else Assert.isNull(creative.id);

		if (sequence != null) {
			Assert.isNotNull(creative.sequence);
			Assert.areEqual(sequence, creative.sequence);
		} else Assert.isNull(creative.sequence);

		if (apiFramework != null) {
			Assert.isNotNull(creative.apiFramework);
			Assert.areEqual(apiFramework, creative.apiFramework);
		} else Assert.isNull(creative.apiFramework);
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

		Assert.isNotNull(linear.duration);
		Assert.areEqual(duration, linear.duration);

		if (trackingEventsMap != null)
			checkTrackingEventsMap(linear, trackingEventsMap);
		if (videoClicksMap != null)
			checkVideoClicksMap(linear, videoClicksMap);

	}

	public function checkNonLinearAds(details:Dynamic, nonLinearMap:Array<Dynamic>,
											 ?trackingEventsMap:Array<Dynamic> = null):Void
	{
		Assert.isNotNull(details);
		Assert.isType(details, NonLinearAds);
		checkTrackingEventsMap(details, trackingEventsMap);
		var nonLinearAds:NonLinearAds = cast details;

		Assert.isNotNull(nonLinearAds.nonLinear);
		Assert.areEqual(nonLinearMap.length, nonLinearAds.nonLinear.length);
		for (idx in 0...nonLinearMap.length) {
			Assert.isNotNull(nonLinearAds.nonLinear[idx]);
			//TODO:
			//Assert.areEqual(nonLinearMap[idx].t, nonLinearAds.nonLinear[idx].type);
			//Assert.areEqual(nonLinearMap[idx].u, nonLinearAds.nonLinear[idx].url);
		}
	}

	public function checkCompanion(detail:Dynamic, width:Int, height:Int, resourcesMap:Array<Dynamic>,
								   ?trackingEventsMap:Array<Dynamic> = null,
								   ?videoClicksMap:Array<Dynamic>=null):Void
	{
		Assert.isNotNull(detail);
		Assert.isType(detail, Companion);
		var companion:Companion = cast detail;
		Assert.isNotNull(companion);
		Assert.areEqual(width, companion.width);
		Assert.areEqual(height, companion.height);
		Assert.isNotNull(companion.resources);
		Assert.areEqual(resourcesMap.length, companion.resources.length);

		for (idx in 0...resourcesMap.length)
		{
			Assert.isNotNull(companion.resources[idx]);
			Assert.areEqual(resourcesMap[idx].t, companion.resources[idx].type);
			Assert.areEqual(resourcesMap[idx].c, companion.resources[idx].creativeType);
			Assert.areEqual(resourcesMap[idx].u, companion.resources[idx].url);
		}

		checkTrackingEventsMap(detail, trackingEventsMap);
		checkVideoClicksMap(detail, videoClicksMap, true);
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
		Assert.isNotNull(linear.mediaFiles[0]);
		var mf:MediaFile = linear.mediaFiles[0];
		Assert.areEqual(mfMap.delivery, mf.delivery);
		Assert.areEqual(mfMap.width, mf.width);
		Assert.areEqual(mfMap.height, mf.height);
		Assert.areEqual(mfMap.type, mf.type);
		Assert.areEqual(mfMap.url, mf.url);
		//optional
		if (mfMap.apiFramework != null)
			Assert.areEqual(mfMap.apiFramework, mf.apiFramework);
		if (mfMap.id != null)
			Assert.areEqual(mfMap.id, mf.id);
		if (mfMap.bitrate != null)
			Assert.areEqual(mfMap.bitrate, mf.bitrate);
		if (mfMap.minBitrate != null)
			Assert.areEqual(mfMap.minBitrate, mf.minBitrate);
		if (mfMap.maxBitrate != null)
			Assert.areEqual(mfMap.maxBitrate, mf.maxBitrate);
		if (mfMap.scalable != null)
			Assert.areEqual(mfMap.scalable, mf.scalable);
		if (mfMap.maintainAspectRatio != null)
			Assert.areEqual(mfMap.maintainAspectRatio, mf.maintainAspectRatio);
		if (mfMap.codec != null)
			Assert.areEqual(mfMap.codec, mf.codec);
	}

}