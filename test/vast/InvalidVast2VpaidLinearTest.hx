package vast;

import massive.munit.Assert;
import bs.model.vast.ad.creatives.linear.MediaFile;
import massive.munit.async.AsyncFactory;

class InvalidVast2VpaidLinearTest extends Tests
{
	public function new() { super(); }

	@AsyncTest
	public function test(factory:AsyncFactory):Void {
		super.vast(factory,'web/examples/vast2/vast2VPAIDLinear.xml');
	}

	override function checkAdCreativeLinearMediaFiles(mediaFiles:Array<MediaFile>):Void {
		for(mf in mediaFiles) {
			Assert.isNull(mf.delivery);
			Assert.isNotNull(mf.type);
			Assert.isNotNaN(mf.width);
			Assert.isNotNaN(mf.height);
		}
	}
}