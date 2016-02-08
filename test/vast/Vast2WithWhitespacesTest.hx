package vast;

import massive.munit.Assert;
import massive.munit.async.AsyncFactory;

class Vast2WithWhitespacesTest extends Tests
{
	public function new() { super(); }

	@AsyncTest
	public function test(factory:AsyncFactory):Void {
		super.vast(factory,'web/examples/vast2/non.linear.xml');
	}

	override public function testStart():Void {
		super.testStart();
/////////////////////////////////
		Assert.areEqual(1, data.ads.length);
		var impressions = ['http://myTrackingURL/impression','http://myTrackingURL/wrapper/impression'];
		var ids = ['602833','601364'];
		var errors = ['http://myErrorURL/error','http://myErrorURL/wrapper/error'];
		Assert.fail('TODO');
//		checkAd(data.ads[0], '601364', 'Acudeo Compatible', 'VAST 2.0 Instream Test 1', impressions, 2,
//		ids, 'VAST 2.0 Instream Test 1', errors);
	}

}