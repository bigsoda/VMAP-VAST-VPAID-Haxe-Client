package vast;

import massive.munit.async.AsyncFactory;


class Vast2WrapperTest extends Tests
{
	public function new() { super(); }

	@AsyncTest
	public function test(factory:AsyncFactory):Void {
		super.vast(factory,'web/examples/vast2/1a.xml');
	}

}