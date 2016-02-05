package vast;

import bs.model.vast.ad.creatives.Creative;
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
		Assert.areEqual('2306', ad.ids[0]);
		Assert.areEqual('e529f14a-6d86-4905-896f-1410901d5dad', ad.ids[1]);
		Assert.areEqual('a115440', ad.ids[2]);

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
		var creative:Creative = ad.creatives[0];

		//TODO: 'id' not copied from wrapper
		//Assert.isNull(creative.id);
		//Assert.areEqual('video',creative.id);

		//TODO: 'AdID' not copied from wrapper
		//Assert.isNull(creative.adID);
		//Assert.areEqual('2306', creative.adID);

		Assert.isNotNull(creative.adIDs);
		Assert.areEqual(3, creative.adIDs.length);

		//TODO: 'undefined' ??
		Assert.areEqual('undefined', creative.adIDs[0]);
		Assert.areEqual('undefined', creative.adIDs[1]);
		Assert.areEqual('2306', creative.adIDs[2]);

		Assert.isNotNull(creative.adIDs);

		Assert.isNotNull(creative.details);
		Assert.areEqual(1, creative.details.length);

		Assert.isNotNull(creative.details[0]);
		Assert.isType(creative.details[0], Linear);
		var linear:Linear = cast creative.details[0];
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