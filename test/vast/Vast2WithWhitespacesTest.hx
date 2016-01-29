package vast;

import massive.munit.async.AsyncFactory;

class Vast2WithWhitespacesTest extends Tests
{
	public function new() { super(); }

	@AsyncTest
	public function test(factory:AsyncFactory):Void {
		super.vast(factory,'web/examples/vast2/ad3.liverail.com.non.linear.xml');
	}

}