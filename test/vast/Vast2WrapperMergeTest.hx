package vast;

import massive.munit.async.AsyncFactory;

class Vast2WrapperMergeTest extends Tests
{
	public function new() { super(); }

	@AsyncTest
	public function test(factory:AsyncFactory):Void {
		super.vast(factory,'web/examples/vastWrapper1.xml');
	}

}