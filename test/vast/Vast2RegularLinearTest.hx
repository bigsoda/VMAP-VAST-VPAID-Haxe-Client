package vast;

import vast.Asserts;
import bs.model.vast.Vast;
import bs.vast.VASTClient;
import massive.munit.Assert;
import massive.munit.async.AsyncFactory;


class Vast2RegularLinearTest
{
	var asyncHandler:Dynamic;
	var vastAss:Asserts;

	public function new() {}

	@Before
	public function setup():Void {
		vastAss = new Asserts();
	}

	@AsyncTest
	public function getVAST(factory:AsyncFactory):Void {
		asyncHandler = factory.createHandler(this, vastAss.start, 6000);
		VASTClient.getVast('http://localhost:9999/vast2/vast2RegularLinear.xml', parseVAST, vastAss.error);
	}

	function parseVAST(data:Xml):Void {
		//#if js js.Browser.console.log(Type.getClassName(Type.getClass(this)), data.toString()); #end
		VASTClient.parseVast(data, onVastParseSuccess, vastAss.error);
	}

	function onVastParseSuccess(data:Vast):Void {
		#if js js.Browser.console.log(Type.getClassName(Type.getClass(this)), data); #end
		vastAss.data = data;
		asyncHandler();
	}

}