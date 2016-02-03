package vast;

import bs.model.vast.ad.Ad;
import bs.model.vast.ad.creatives.MIMEType;
import bs.model.vast.ad.creatives.linear.MediaFile.DeliveryType;
import bs.model.vast.ad.creatives.Click.ClickType;
import bs.model.vast.ad.creatives.Tracking.TrackingEvent;
import bs.model.vast.ad.creatives.linear.Linear;
import massive.munit.Assert;
import massive.munit.async.AsyncFactory;


class Vast2WrapperTest extends Tests
{
	public function new() { super(); }

	@AsyncTest
	public function test(factory:AsyncFactory):Void {
		super.vast(factory,'web/examples/vast2/1a.xml');
	}

	override public function testStart():Void {
		super.testStart();
		/////////////////////////////////
		Assert.areEqual(1, data.ads.length);
		var ad:Ad = data.ads[0];
		Assert.isNotNull(ad.id);
		Assert.areEqual('a115440', ad.id);
		Assert.isNotNull(ad.ids);
		Assert.areEqual(3, ad.ids.length);
		Assert.isNotNull(ad.system);
		Assert.areEqual('Adap.tv', ad.system.name);
		Assert.areEqual('1.0', ad.system.version);
		Assert.isNotNull(ad.title);
		Assert.areEqual('Adap.tv Ad Unit', ad.title);
		Assert.isNull(ad.sequence);
		Assert.isNotNull(ad.errors);
		Assert.areEqual(3, ad.errors.length);
		Assert.isNotNull(ad.impressions);
		Assert.areEqual(13, ad.impressions.length);
		Assert.isNotNull(ad.creatives);
		Assert.areEqual(1, ad.creatives.length);
		Assert.isNotNull(ad.creatives[0]);
		Assert.isNull(ad.creatives[0].adID);
		Assert.isNotNull(ad.creatives[0].details);
		Assert.areEqual(1, ad.creatives[0].details.length);
		Assert.isNotNull(ad.creatives[0].details[0]);
		Assert.isType(ad.creatives[0].details[0], Linear);
		var linear:Linear = cast ad.creatives[0].details[0];
		Assert.isNotNull(linear.duration);
		Assert.areEqual(15, linear.duration);
		Assert.isNotNull(linear.trackingEvents);
		Assert.areEqual(22, linear.trackingEvents.length);
		var trackingEvents = [
			TrackingEvent.START,
			TrackingEvent.FIRST_QUARTILE,
			TrackingEvent.MIDPOINT,
			TrackingEvent.THIRD_QUARTILE,
			TrackingEvent.COMPLETE,
			TrackingEvent.ACCEPT_INVITATION_NONLINEAR,
			TrackingEvent.PAUSE,
			TrackingEvent.RESUME,
			TrackingEvent.MIDPOINT,
			TrackingEvent.COMPLETE,
			TrackingEvent.START,
			TrackingEvent.FIRST_QUARTILE,
			TrackingEvent.CLOSE_NONLINEAR,
			TrackingEvent.THIRD_QUARTILE,
			TrackingEvent.COMPLETE,
			TrackingEvent.FIRST_QUARTILE,
			TrackingEvent.MIDPOINT,
			TrackingEvent.MUTE,
			TrackingEvent.PAUSE,
			TrackingEvent.START,
			TrackingEvent.THIRD_QUARTILE,
			TrackingEvent.UNMUTE
		];
		for (idx in 0...trackingEvents.length) {
			Assert.isNotNull(linear.trackingEvents[idx]);
			Assert.areEqual(trackingEvents[idx], linear.trackingEvents[idx].event);
		}
		Assert.isNotNull(linear.videoClicks);
		Assert.areEqual(4, linear.videoClicks.length);
		Assert.isNotNull(linear.videoClicks[0]);
		Assert.areEqual(ClickType.CLICK_THROUGH, linear.videoClicks[0].type);
		Assert.areEqual(ClickType.CLICK_TRACKING, linear.videoClicks[1].type);
		Assert.areEqual(ClickType.CLICK_TRACKING, linear.videoClicks[2].type);
		Assert.areEqual('ang', linear.videoClicks[3].id);
		Assert.areEqual(ClickType.CLICK_TRACKING, linear.videoClicks[3].type);
		Assert.isNotNull(linear.adParameters);
		Assert.isNotNull(linear.mediaFiles);
		Assert.areEqual(1, linear.mediaFiles.length);
		Assert.isNotNull(linear.mediaFiles[0]);
		Assert.areEqual(DeliveryType.PROGRESSIVE, linear.mediaFiles[0].delivery);
		Assert.areEqual(480, linear.mediaFiles[0].width);
		Assert.areEqual(272, linear.mediaFiles[0].height);
		Assert.areEqual(MIMEType.VIDEO_MP4, linear.mediaFiles[0].type);
		Assert.areEqual(500, linear.mediaFiles[0].bitrate);
		Assert.areEqual(4, ad.extensions.length);
	}
}