package vast;

import bs.model.vast.ad.creatives.Resource.ResourceType;
import bs.model.vast.ad.creatives.MIMEType;
import bs.model.vast.ad.creatives.linear.MediaFile;
import bs.model.vast.ad.creatives.linear.MediaFile.DeliveryType;
import bs.model.vast.ad.creatives.Click.ClickType;
import bs.model.vast.ad.creatives.CreativeDetails;
import bs.model.vast.ad.creatives.Tracking.TrackingEvent;
import bs.model.vast.ad.creatives.Creative;
import bs.model.vast.ad.Ad;
import massive.munit.Assert;
import massive.munit.async.AsyncFactory;

class Vast2WrapperMergeTest extends Tests
{
	public function new() { super(); }

	@AsyncTest
	public function test(factory:AsyncFactory):Void {
		super.vast(factory,'web/examples/vast2/vastWrapper1.xml');
	}

	override public function testStart():Void {
		super.testStart();
		/////////////////////////////////
		Assert.areEqual(1, data.ads.length);

		var impressions = ['http://myTrackingURL/impression','http://myTrackingURL/wrapper/impression','http://myTrackingURL/wrapper/impression'];
		var ids = ['wrapper1', 'wrapper2','inLine'];
		var errors = ['http://myErrorURL/error'];
		checkAd(data.ads[0], 'inLine', 'VAST TEST', 'VAST InLine', impressions, 3, ids, 'VAST TEST', errors);

		//CREATIVE 1/3 - LINEAR
		var adIDs:Array<String> = ['inLine.creative1.Linear','wrapper2.creative1.Linear','wrapper1.creative1.Linear'];
		checkCreative(data.ads[0].creatives[0], 1, 'inLine.creative1.Linear' ,adIDs);

		var trackingEventsMap = [
			{e:TrackingEvent.CREATIVE_VIEW,u:'http://inline/Linear/tracking/creative1/1'},
			{e:TrackingEvent.CREATIVE_VIEW,u:'http:///wrapper2/Linear/tracking/creative1/1'},
			{e:TrackingEvent.CREATIVE_VIEW,u:'http://wrapper1/Linear/tracking/creative1/1'}
		];
		var videoClicksMap = [
			{t:ClickType.CLICK_THROUGH,u:'http://inline/Linear/videoClick/creative1/clickThrough'},
			{t:ClickType.CLICK_THROUGH,u:'http://wrapper1/Linear/videoClick/creative1/clickThrough'},
			{t:ClickType.CLICK_TRACKING,u:'http://inline/Linear/videoClick/creative1/clickTracking'},
			{t:ClickType.CLICK_TRACKING,u:'http://wrapper1/Linear/videoClick/creative1/clickTracking'}
		];
		var mediaFileMap:MediaFile = new MediaFile(DeliveryType.PROGRESSIVE);
			mediaFileMap.type = MIMEType.VIDEO_X_FLV;
			mediaFileMap.bitrate = 500;
			mediaFileMap.width = 400;
			mediaFileMap.height = 300;
			mediaFileMap.scalable = true;
			mediaFileMap.maintainAspectRatio = true;
			mediaFileMap.url = 'http://cdnp.tremormedia.com/video/acudeo/Carrot_400x300_500kb.flv';
		super.checkLinear(data.ads[0].creatives[0].details[0], 30, mediaFileMap, trackingEventsMap, videoClicksMap);

		//CREATIVE 2/3 - CompanionAds
		super.checkCreative(data.ads[0].creatives[1], 2, 'inLine.creative2.CompanionAds');
		var resourcesMap = [
			{t:ResourceType.STATIC_RESOURCE, c:MIMEType.IMAGE_JPEG, u:'http://demo.tremormedia.com/proddev/vast/Blistex1.jpg'}
		];
		trackingEventsMap = [
			{e:TrackingEvent.CREATIVE_VIEW,u:'http://myTrackingURL/firstCompanionCreativeView'}
		];
		videoClicksMap = [
			{t:ClickType.COMPANION_CLICK_THROUGH,u:'http://www.tremormedia.com'}
		];
		super.checkCompanion(data.ads[0].creatives[1].details[0], 300, 250, resourcesMap, trackingEventsMap, videoClicksMap);

		var resourcesMap = [
			{t:ResourceType.STATIC_RESOURCE, c:MIMEType.IMAGE_JPEG, u:'http://demo.tremormedia.com/proddev/vast/728x90_banner1.jpg'}
		];
		videoClicksMap = [
			{t:ClickType.COMPANION_CLICK_THROUGH,u:'http://www.tremormedia.com'}
		];
		super.checkCompanion(data.ads[0].creatives[1].details[1], 728, 90, resourcesMap, null, videoClicksMap);

		//CREATIVE 2/3 - NonLinearAds
		super.checkCreative(data.ads[0].creatives[2], 0, 'wrapper1.creative2.NonLinearAds');
		var nonLinearMap = [];
		var trackingEventsMap = [
			{e:TrackingEvent.CREATIVE_VIEW,u:'http://NonLinearAds/tracking/wrapper1/creative2/1'}
		];
		super.checkNonLinearAds(data.ads[0].creatives[2].details, nonLinearMap, trackingEventsMap);
	}

}