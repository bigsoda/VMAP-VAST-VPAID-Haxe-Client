package vast;

import bs.model.vast.ad.creatives.Creative;
import bs.model.vast.ad.Ad;
import massive.munit.Assert;
import massive.munit.async.AsyncFactory;

class Vast2WrapperNonLinear2Test extends Tests
{
	public function new() { super(); }

	@AsyncTest
	public function test(factory:AsyncFactory):Void {
		super.vast(factory,'web/examples/vast2/vast_wrapper_nonlinear_2.xml');
	}

	override public function testStart():Void {
		super.testStart();
		/////////////////////////////////
		Assert.areEqual(1, data.ads.length);
		var ad:Ad = data.ads[0];
		Assert.isNotNull(ad.id);
		Assert.areEqual('602678', ad.id);
		Assert.isNotNull(ad.system);
		Assert.areEqual('Acudeo Compatible', ad.system.name);
		Assert.isNotNull(ad.title);
		Assert.areEqual('NonLinear Test Campaign 1', ad.title);
		Assert.isNotNull(ad.survey);
		Assert.areEqual('http://mySurveyURL/survey', ad.survey);
		Assert.isNull(ad.sequence);
		Assert.isNotNull(ad.errors);
		Assert.areEqual(1, ad.errors.length);
		Assert.isNotNull(ad.impressions);
		Assert.areEqual(2, ad.impressions.length);

		Assert.isNotNull(ad.creatives);
		/*
		Assert.areEqual(2, ad.creatives.length);
		var creative:Creative = ad.creatives[0];
		Assert.isNotNull(creative);
		Assert.isNotNull(creative.adID);
		Assert.areEqual('602678-NonLinear', creative.adID);
		Assert.isNotNull(creative.details);
		Assert.areEqual(1, creative.details.length);
		Assert.isNotNull(creative.details[0]);
		*/
//		Assert.isType(creative.details[0], Linear);
//		var linear:Linear = cast creative.details[0];
//		Assert.isNotNull(linear.duration);
//		Assert.areEqual(15, linear.duration);
//		Assert.isNotNull(linear.trackingEvents);
//		Assert.areEqual(22, linear.trackingEvents.length);
//		var trackingEvents = [
//			TrackingEvent.START,
//			TrackingEvent.FIRST_QUARTILE,
//			TrackingEvent.MIDPOINT,
//			TrackingEvent.THIRD_QUARTILE,
//			TrackingEvent.COMPLETE,
//			TrackingEvent.ACCEPT_INVITATION_NONLINEAR,
//			TrackingEvent.PAUSE,
//			TrackingEvent.RESUME,
//			TrackingEvent.MIDPOINT,
//			TrackingEvent.COMPLETE,
//			TrackingEvent.START,
//			TrackingEvent.FIRST_QUARTILE,
//			TrackingEvent.CLOSE_NONLINEAR,
//			TrackingEvent.THIRD_QUARTILE,
//			TrackingEvent.COMPLETE,
//			TrackingEvent.FIRST_QUARTILE,
//			TrackingEvent.MIDPOINT,
//			TrackingEvent.MUTE,
//			TrackingEvent.PAUSE,
//			TrackingEvent.START,
//			TrackingEvent.THIRD_QUARTILE,
//			TrackingEvent.UNMUTE
//		];
//		for (idx in 0...trackingEvents.length) {
//			Assert.isNotNull(linear.trackingEvents[idx]);
//			Assert.areEqual(trackingEvents[idx], linear.trackingEvents[idx].event);
//		}
//		Assert.isNotNull(linear.videoClicks);
//		Assert.areEqual(4, linear.videoClicks.length);
//		Assert.isNotNull(linear.videoClicks[0]);
//		Assert.areEqual(ClickType.CLICK_THROUGH, linear.videoClicks[0].type);
//		Assert.areEqual(ClickType.CLICK_TRACKING, linear.videoClicks[1].type);
//		Assert.areEqual(ClickType.CLICK_TRACKING, linear.videoClicks[2].type);
//		Assert.areEqual('ang', linear.videoClicks[3].id);
//		Assert.areEqual(ClickType.CLICK_TRACKING, linear.videoClicks[3].type);
//		Assert.isNotNull(linear.adParameters);
//		Assert.isNotNull(linear.mediaFiles);
//		Assert.areEqual(1, linear.mediaFiles.length);
//		Assert.isNotNull(linear.mediaFiles[0]);
//		Assert.areEqual(DeliveryType.PROGRESSIVE, linear.mediaFiles[0].delivery);
//		Assert.areEqual(480, linear.mediaFiles[0].width);
//		Assert.areEqual(272, linear.mediaFiles[0].height);
//		Assert.areEqual(MIMEType.VIDEO_MP4, linear.mediaFiles[0].type);
//		Assert.areEqual(500, linear.mediaFiles[0].bitrate);
//		Assert.areEqual(4, ad.extensions.length);



	}
}