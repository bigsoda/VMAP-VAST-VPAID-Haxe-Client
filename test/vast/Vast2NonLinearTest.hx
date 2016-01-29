package vast;

import massive.munit.async.AsyncFactory;

class Vast2NonLinearTest extends Tests
{
	public function new() { super(); }

	@AsyncTest
	public function test(factory:AsyncFactory):Void {
		super.vast(factory,'web/examples/vast2/vast2Nonlinear.xml');
	}

}