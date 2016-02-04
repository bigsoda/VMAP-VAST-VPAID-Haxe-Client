package vast;

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
		var ad:Ad = data.ads[0];
		Assert.isNotNull(ad.id);
		Assert.areEqual('inLine', ad.id);

		Assert.isNotNull(ad.ids);
		Assert.areEqual(3, ad.ids.length);
		Assert.areEqual('wrapper1', ad.ids[0]);
		Assert.areEqual('wrapper2', ad.ids[1]);
		Assert.areEqual('inLine', ad.ids[2]);

		Assert.isNotNull(ad.system);
		Assert.areEqual('VAST TEST', ad.system.name);
		Assert.isNotNull(ad.title);
		Assert.areEqual('VAST InLine', ad.title);
		Assert.isNotNull(ad.description);
		Assert.areEqual('VAST TEST', ad.description);
		Assert.isNotNull(ad.errors);
		Assert.areEqual(1, ad.errors.length);
		Assert.areEqual('http://myErrorURL/error', ad.errors[0].url);

		Assert.isNotNull(ad.impressions);
		Assert.areEqual(3, ad.impressions.length);
		Assert.areEqual('http://myTrackingURL/impression', ad.impressions[0].url);
		Assert.areEqual('http://myTrackingURL/wrapper/impression', ad.impressions[1].url);
		Assert.areEqual('http://myTrackingURL/wrapper/impression', ad.impressions[2].url);

		Assert.isNotNull(ad.creatives);
		Assert.areEqual(3, ad.creatives.length);

		var creative:Creative = ad.creatives[0];
		Assert.isNotNull(creative);
		Assert.isNotNull(creative.adID);
		Assert.areEqual('inLine.creative1.Linear', creative.adID);
		Assert.isNotNull(creative.adIDs);
		//TODO:
//		Assert.areEqual(3, creative.adIDs.length);
//		Assert.areEqual('inLine.creative1.Linear', creative.adIDs[0]);
//		Assert.areEqual('wrapper1.creative1.Linear', creative.adIDs[1]);
//		Assert.areEqual('wrapper2.creative1.Linear', creative.adIDs[2]);

	}

}