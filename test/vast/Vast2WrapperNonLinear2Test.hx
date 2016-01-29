package vast;

import massive.munit.async.AsyncFactory;

class Vast2WrapperNonLinear2Test extends Tests
{
	public function new() { super(); }

	@AsyncTest
	public function test(factory:AsyncFactory):Void {
		super.vast(factory,'web/examples/vast2/vast_wrapper_nonlinear_2.xml');
	}

}