package vast;

import massive.munit.async.AsyncFactory;

class Vast3Test extends Tests
{

	public function new() { super(); }

	@AsyncTest
	public function test(factory:AsyncFactory):Void {
		super.vast(factory,'web/examples/vast3/vast3_inline.xml');
	}

}