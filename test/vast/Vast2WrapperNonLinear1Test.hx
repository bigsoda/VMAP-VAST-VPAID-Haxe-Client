package vast;

import massive.munit.async.AsyncFactory;

class Vast2WrapperNonLinear1Test extends Tests
{
	public function new() { super(); }

	@AsyncTest
	public function test(factory:AsyncFactory):Void {
		super.vast(factory,'web/examples/vast2/vast_wrapper_nonlinear_1.xml');
	}

}