package vast;

import bs.model.vast.ad.creatives.companion.Companion;
import bs.model.vast.ad.creatives.Tracking.TrackingEvent;
import bs.model.vast.ad.creatives.Click.ClickType;
import bs.model.vast.ad.creatives.MIMEType;
import bs.model.vast.ad.creatives.Resource.ResourceType;
import bs.model.vast.ad.creatives.nonlinears.NonLinearAds;
import bs.model.vast.ad.creatives.Creative;
import bs.model.vast.ad.Ad;
import massive.munit.Assert;
import massive.munit.async.AsyncFactory;

class Vast2WrapperNonLinear1Test extends Tests
{
	public function new() { super(); }

	@AsyncTest
	public function test(factory:AsyncFactory):Void {
		super.vast(factory,'web/examples/vast2/vast_wrapper_nonlinear_1.xml');
	}
	override public function testStart():Void {
		super.testStart();
		/////////////////////////////////
		Assert.areEqual(1, data.ads.length);
		var ad:Ad = data.ads[0];
		Assert.isNotNull(ad.id);
		Assert.areEqual('602678', ad.id);

		Assert.isNotNull(ad.ids);
		Assert.areEqual(2, ad.ids.length);
		Assert.areEqual('602867', ad.ids[0]);
		Assert.areEqual('602678', ad.ids[1]);

		Assert.isNotNull(ad.system);
		Assert.areEqual('Acudeo Compatible', ad.system.name);
		Assert.isNotNull(ad.title);
		Assert.areEqual('NonLinear Test Campaign 1', ad.title);
		Assert.isNotNull(ad.description);
		Assert.areEqual('NonLinear Test Campaign 1', ad.description);
		Assert.isNotNull(ad.survey);
		Assert.areEqual('http://mySurveyURL/survey', ad.survey);
		Assert.isNull(ad.sequence);
		Assert.isNotNull(ad.errors);
		Assert.areEqual(2, ad.errors.length);
		Assert.areEqual('http://myErrorURL/error', ad.errors[0].url);
		Assert.areEqual('http://myErrorURL/wrapper/error', ad.errors[1].url);

		Assert.isNotNull(ad.impressions);
		Assert.areEqual(2, ad.impressions.length);
		Assert.areEqual('http://myTrackingURL/impression', ad.impressions[0].url);
		Assert.areEqual('http://myTrackingURL/wrapper/impression', ad.impressions[1].url);
		Assert.isNotNull(ad.creatives);
		Assert.areEqual(2, ad.creatives.length);

		var creative:Creative = ad.creatives[0];
		Assert.isNotNull(creative);
		Assert.isNotNull(creative.adID);
		Assert.areEqual('602678-NonLinear', creative.adID);
		Assert.isNotNull(creative.adIDs);
		Assert.areEqual('602678-NonLinear', creative.adIDs[0]);
		Assert.areEqual('602867-NonLinearTracking', creative.adIDs[1]);

		Assert.isType(creative.details, NonLinearAds);
		var nonlinearAds:NonLinearAds = cast creative.details;
		Assert.isNotNull(nonlinearAds);
		Assert.isNotNull(nonlinearAds.trackingEvents);
		Assert.areEqual(10, nonlinearAds.trackingEvents.length);

		var trackingEvents = [
			TrackingEvent.CREATIVE_VIEW,
			TrackingEvent.EXPAND,
			TrackingEvent.COLLAPSE,
			TrackingEvent.ACCEPT_INVITATION_NONLINEAR,
			TrackingEvent.CLOSE_NONLINEAR,
			TrackingEvent.CREATIVE_VIEW,
			TrackingEvent.EXPAND,
			TrackingEvent.COLLAPSE,
			TrackingEvent.ACCEPT_INVITATION_NONLINEAR,
			TrackingEvent.CLOSE_NONLINEAR
		];
		for (idx in 0...nonlinearAds.trackingEvents.length) {
			Assert.isNotNull(nonlinearAds.trackingEvents[idx]);
			Assert.areEqual(trackingEvents[idx], nonlinearAds.trackingEvents[idx].event);
		}

		Assert.isNotNull(nonlinearAds.nonLinear);
		Assert.areEqual(2, nonlinearAds.nonLinear.length);

		var nonlinear = nonlinearAds.nonLinear[0];
		Assert.areEqual(300, nonlinear.width);
		Assert.areEqual(50, nonlinear.height);
		Assert.areEqual(15, nonlinear.minSuggestedDuration);
		Assert.areEqual(1, nonlinear.resources.length);
		Assert.isNotNull(nonlinear.resources[0]);
		Assert.areEqual(ResourceType.STATIC_RESOURCE, nonlinear.resources[0].type);
		Assert.areEqual(MIMEType.IMAGE_JPEG, nonlinear.resources[0].creativeType);
		Assert.areEqual("http://demo.tremormedia.com/proddev/vast/50x300_static.jpg", nonlinear.resources[0].url);
		Assert.areEqual(1, nonlinear.clicks.length);
		Assert.isNotNull(nonlinear.clicks[0]);
		Assert.areEqual(ClickType.NON_LINEAR_CLICK_THROUGH, nonlinear.clicks[0].type);
		Assert.areEqual("http://demo.tremormedia.com/qa/qa_page/index.html", nonlinear.clicks[0].url);

		nonlinear = nonlinearAds.nonLinear[1];
		Assert.areEqual(450, nonlinear.width);
		Assert.areEqual(50, nonlinear.height);
		Assert.areEqual(20, nonlinear.minSuggestedDuration);
		Assert.areEqual(1, nonlinear.resources.length);
		Assert.isNotNull(nonlinear.resources[0]);
		Assert.areEqual(ResourceType.STATIC_RESOURCE, nonlinear.resources[0].type);
		Assert.areEqual(MIMEType.IMAGE_JPEG, nonlinear.resources[0].creativeType);
		Assert.areEqual("http://demo.tremormedia.com/proddev/vast/50x450_static.jpg", nonlinear.resources[0].url);
		Assert.isNotNull(nonlinear.clicks);
		Assert.areEqual(1, nonlinear.clicks.length);
		Assert.isNotNull(nonlinear.clicks[0]);
		Assert.areEqual(ClickType.NON_LINEAR_CLICK_THROUGH, nonlinear.clicks[0].type);
		Assert.areEqual("http://demo.tremormedia.com/qa/qa_page/index.html", nonlinear.clicks[0].url);

		creative = ad.creatives[1];
		Assert.isNotNull(creative);
		Assert.isNotNull(creative.adID);
		Assert.areEqual('602678-Companion', creative.adID);

		Assert.isNotNull(creative.details);
		Assert.areEqual(2, creative.details.length);

		Assert.isNotNull(creative.details[0]);
		Assert.isType(creative.details[0], Companion);
		var companion:Companion = cast creative.details[0];
		Assert.isNotNull(companion);
		Assert.areEqual(300, companion.width);
		Assert.areEqual(250, companion.height);
		Assert.isNotNull(companion.resources);
		Assert.areEqual(1, companion.resources.length);
		Assert.isNotNull(companion.resources[0]);
		Assert.areEqual(ResourceType.STATIC_RESOURCE, companion.resources[0].type);
		Assert.areEqual(MIMEType.APPLICATION_X_SHOCKWAVE_FLASH, companion.resources[0].creativeType);
		Assert.areEqual("http://demo.tremormedia.com/proddev/vast/300x250_companion_1.swf", companion.resources[0].url);
		Assert.isNotNull(companion.clicks);
		Assert.areEqual(1, companion.clicks.length);
		Assert.isNotNull(companion.clicks[0]);
		Assert.areEqual(ClickType.COMPANION_CLICK_THROUGH, companion.clicks[0].type);
		Assert.areEqual("http://www.tremormedia.com", companion.clicks[0].url);

		Assert.isType(creative.details[1], Companion);
		companion = cast creative.details[1];
		Assert.isNotNull(companion);
		Assert.areEqual(728, companion.width);
		Assert.areEqual(90, companion.height);
		Assert.isNotNull(companion.resources);
		Assert.areEqual(1, companion.resources.length);
		Assert.isNotNull(companion.resources[0]);
		Assert.areEqual(ResourceType.STATIC_RESOURCE, companion.resources[0].type);
		Assert.areEqual(MIMEType.IMAGE_JPEG, companion.resources[0].creativeType);
		Assert.areEqual("http://demo.tremormedia.com/proddev/vast/728x90_banner1.jpg", companion.resources[0].url);
		Assert.isNotNull(companion.trackingEvents);
		Assert.areEqual(1, companion.trackingEvents.length);
		Assert.areEqual(TrackingEvent.CREATIVE_VIEW, companion.trackingEvents[0].event);
		Assert.areEqual("http://myTrackingURL/secondCompanion", companion.trackingEvents[0].url);
		Assert.isNotNull(companion.clicks);
		Assert.areEqual(1, companion.clicks.length);
		Assert.isNotNull(companion.clicks[0]);
		Assert.areEqual(ClickType.COMPANION_CLICK_THROUGH, companion.clicks[0].type);
		Assert.areEqual("http://www.tremormedia.com", companion.clicks[0].url);

		/////////////////////////////////
	}
}