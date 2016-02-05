package vast;

import bs.model.vast.ad.creatives.Creative;
import bs.model.vast.ad.Ad;
import bs.model.vast.ad.creatives.MIMEType;
import bs.model.vast.ad.creatives.Tracking.TrackingEvent;
import bs.model.vast.ad.creatives.linear.MediaFile.DeliveryType;
import bs.model.vast.ad.creatives.Click.ClickType;
import bs.model.vast.ad.creatives.linear.Linear;
import massive.munit.Assert;
import massive.munit.async.AsyncFactory;

class Vast3Test extends Tests
{

	public function new() { super(); }

	@AsyncTest
	public function test(factory:AsyncFactory):Void {
		super.vast(factory,'web/examples/vast3/vast3_inline.xml');
	}

	override public function testStart():Void {
		super.testStart();
		/////////////////////////////////
		Assert.areEqual(3, data.ads.length);
		var ad:Ad;
		//AD 1///////////////////////////////
		ad = data.ads[0];
		Assert.isNotNull(ad.id);
		Assert.areEqual('2447226.251866656', ad.id);
		Assert.isNotNull(ad.system);
		Assert.areEqual('FreeWheel', ad.system.name);
		Assert.isNotNull(ad.title);
		Assert.areEqual('Ooyla test m3u8 midroll 1', ad.title);
		Assert.isNotNull(ad.sequence);
		Assert.areEqual(1, ad.sequence);
		Assert.isNotNull(ad.errors);
		Assert.areEqual(1, ad.errors.length);
		Assert.isNotNull(ad.impressions);
		Assert.areEqual(1, ad.impressions.length);
		Assert.isNotNull(ad.impressions[0]);
		Assert.areEqual('FWi_2447226.0', ad.impressions[0].id);
		//CREATIVES
		Assert.isNotNull(ad.creatives);
		Assert.areEqual(1, ad.creatives.length);

		//CREATIVE
		Assert.isNotNull(ad.creatives[0]);
		var creative:Creative = ad.creatives[0];
		Assert.areEqual('2447226', creative.adID);
		Assert.isNull(creative.adIDs);
		Assert.isNotNull(creative.details);
		Assert.areEqual(1, creative.details.length);

		Assert.isNotNull(creative.details[0]);
		Assert.isType(creative.details[0], Linear);
		var linear:Linear = cast creative.details[0];
		Assert.isNotNull(linear.duration);
		Assert.areEqual(15, linear.duration);
		Assert.isNotNull(linear.trackingEvents);
		Assert.areEqual(4, linear.trackingEvents.length);
		Assert.isNotNull(linear.trackingEvents[0]);
		Assert.areEqual(TrackingEvent.COMPLETE, linear.trackingEvents[0].event);
		Assert.isNotNull(linear.trackingEvents[1]);
		Assert.areEqual(TrackingEvent.FIRST_QUARTILE, linear.trackingEvents[1].event);
		Assert.isNotNull(linear.trackingEvents[2]);
		Assert.areEqual(TrackingEvent.MIDPOINT, linear.trackingEvents[2].event);
		Assert.isNotNull(linear.trackingEvents[3]);
		Assert.areEqual(TrackingEvent.THIRD_QUARTILE, linear.trackingEvents[3].event);
		Assert.isNotNull(linear.videoClicks);
		Assert.areEqual(1, linear.videoClicks.length);
		Assert.isNotNull(linear.videoClicks[0]);
		Assert.areEqual(ClickType.CLICK_TRACKING, linear.videoClicks[0].type);
		Assert.areEqual('FWc_2447226.0', linear.videoClicks[0].id);
		Assert.isNotNull(linear.mediaFiles);
		Assert.areEqual(1, linear.mediaFiles.length);
		Assert.isNotNull(linear.mediaFiles[0]);
		Assert.areEqual(DeliveryType.STREAMING, linear.mediaFiles[0].delivery);
		Assert.areEqual(0, linear.mediaFiles[0].width);
		Assert.areEqual(0, linear.mediaFiles[0].height);
		Assert.areEqual(MIMEType.APPLICATION_X_MPEGURL, linear.mediaFiles[0].type);
		//AD 2///////////////////////////////
		ad = data.ads[1];
		Assert.isNotNull(ad.id);
		Assert.areEqual('2447227.255243472', ad.id);
		Assert.isNotNull(ad.system);
		Assert.areEqual('FreeWheel', ad.system.name);
		Assert.isNotNull(ad.title);
		Assert.areEqual('Ooyla test m3u8 midroll 2', ad.title);
		Assert.isNotNull(ad.sequence);
		Assert.areEqual(2, ad.sequence);
		Assert.isNotNull(ad.errors);
		Assert.areEqual(1, ad.errors.length);
		Assert.isNotNull(ad.impressions);
		Assert.areEqual(1, ad.impressions.length);
		Assert.isNotNull(ad.impressions[0]);
		Assert.areEqual('FWi_2447227.0', ad.impressions[0].id);
		Assert.isNotNull(ad.creatives);
		Assert.areEqual(1, ad.creatives.length);

		Assert.isNotNull(ad.creatives[0]);
		creative = ad.creatives[0];
		Assert.areEqual('2447227', creative.adID);
		Assert.isNull(creative.adIDs);
		Assert.isNotNull(creative.details);
		Assert.areEqual(1, creative.details.length);

		Assert.isNotNull(creative.details[0]);
		Assert.isType(creative.details[0], Linear);
		linear = cast creative.details[0];
		Assert.isNotNull(linear.duration);
		Assert.areEqual(31, linear.duration);
		Assert.isNotNull(linear.trackingEvents);
		Assert.areEqual(4, linear.trackingEvents.length);
		Assert.isNotNull(linear.trackingEvents[0]);
		Assert.areEqual(TrackingEvent.COMPLETE, linear.trackingEvents[0].event);
		Assert.isNotNull(linear.trackingEvents[1]);
		Assert.areEqual(TrackingEvent.FIRST_QUARTILE, linear.trackingEvents[1].event);
		Assert.isNotNull(linear.trackingEvents[2]);
		Assert.areEqual(TrackingEvent.MIDPOINT, linear.trackingEvents[2].event);
		Assert.isNotNull(linear.trackingEvents[3]);
		Assert.areEqual(TrackingEvent.THIRD_QUARTILE, linear.trackingEvents[3].event);

		Assert.isNotNull(linear.videoClicks);
		Assert.areEqual(1, linear.videoClicks.length);
		Assert.isNotNull(linear.videoClicks[0]);
		Assert.areEqual(ClickType.CLICK_TRACKING, linear.videoClicks[0].type);
		Assert.areEqual('FWc_2447227.0', linear.videoClicks[0].id);

		Assert.isNotNull(linear.mediaFiles);
		Assert.areEqual(1, linear.mediaFiles.length);
		Assert.isNotNull(linear.mediaFiles[0]);
		Assert.areEqual(DeliveryType.STREAMING, linear.mediaFiles[0].delivery);
		Assert.areEqual(0, linear.mediaFiles[0].width);
		Assert.areEqual(0, linear.mediaFiles[0].height);
		Assert.areEqual(MIMEType.APPLICATION_X_MPEGURL, linear.mediaFiles[0].type);
		//AD 3///////////////////////////////
		ad = data.ads[2];
		Assert.isNotNull(ad.id);
		Assert.areEqual('2447228.257609712', ad.id);
		Assert.isNotNull(ad.system);
		Assert.areEqual('FreeWheel', ad.system.name);
		Assert.isNotNull(ad.title);
		Assert.areEqual('Ooyla test m3u8 midroll 3', ad.title);
		Assert.isNotNull(ad.sequence);
		Assert.areEqual(3, ad.sequence);
		Assert.isNotNull(ad.errors);
		Assert.areEqual(1, ad.errors.length);
		Assert.isNotNull(ad.impressions);
		Assert.areEqual(1, ad.impressions.length);
		Assert.isNotNull(ad.impressions[0]);
		Assert.areEqual('FWi_2447228.0', ad.impressions[0].id);
		Assert.isNotNull(ad.creatives);
		Assert.areEqual(1, ad.creatives.length);

		Assert.isNotNull(ad.creatives[0]);
		creative = ad.creatives[0];
		Assert.areEqual('2447228', creative.adID);
		Assert.isNull(creative.adIDs);
		Assert.isNotNull(creative.details);
		Assert.areEqual(1, creative.details.length);
		Assert.isNotNull(creative.details[0]);

		Assert.isType(creative.details[0], Linear);
		linear = cast creative.details[0];
		Assert.isNotNull(linear.duration);
		Assert.areEqual(31, linear.duration);
		Assert.isNotNull(linear.trackingEvents);
		Assert.areEqual(4, linear.trackingEvents.length);
		Assert.isNotNull(linear.trackingEvents[0]);
		Assert.areEqual(TrackingEvent.COMPLETE, linear.trackingEvents[0].event);
		Assert.isNotNull(linear.trackingEvents[1]);
		Assert.areEqual(TrackingEvent.FIRST_QUARTILE, linear.trackingEvents[1].event);
		Assert.isNotNull(linear.trackingEvents[2]);
		Assert.areEqual(TrackingEvent.MIDPOINT, linear.trackingEvents[2].event);
		Assert.isNotNull(linear.trackingEvents[3]);
		Assert.areEqual(TrackingEvent.THIRD_QUARTILE, linear.trackingEvents[3].event);
		Assert.isNotNull(linear.videoClicks);
		Assert.areEqual(1, linear.videoClicks.length);
		Assert.isNotNull(linear.videoClicks[0]);
		Assert.areEqual(ClickType.CLICK_TRACKING, linear.videoClicks[0].type);
		Assert.areEqual('FWc_2447228.0', linear.videoClicks[0].id);
		Assert.isNotNull(linear.mediaFiles);
		Assert.areEqual(1, linear.mediaFiles.length);
		Assert.isNotNull(linear.mediaFiles[0]);
		Assert.areEqual(DeliveryType.STREAMING, linear.mediaFiles[0].delivery);
		Assert.areEqual(0, linear.mediaFiles[0].width);
		Assert.areEqual(0, linear.mediaFiles[0].height);
		Assert.areEqual(MIMEType.APPLICATION_X_MPEGURL, linear.mediaFiles[0].type);
		///////////////////////////////////
	}

}