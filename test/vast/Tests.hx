package vast;

import vast.Asserts;
import bs.model.vast.Vast;
import bs.vast.VASTClient;
import massive.munit.Assert;
import massive.munit.async.AsyncFactory;


class Tests
{
	var name:String;
	var asyncHandler:Dynamic;
	var vastAss:Asserts;

	public function new() {}

	@Before
	public function setup():Void {
		name = Type.getClassName(Type.getClass(this));
		log('START');
		vastAss = new Asserts();
	}

	@After
	public function tearDown():Void {
		log('STOP');
	}

	public function vast(factory:AsyncFactory, url:String):Void {
		asyncHandler = factory.createHandler(this, testStart, 6000);
		VASTClient.getVast(url, parseVAST, getVastError);
	}

	function parseVAST(data:Xml):Void {
		VASTClient.parseVast(data, onVastParseSuccess, parseVastError);
	}

	function onVastParseSuccess(data:Vast):Void {
		vastAss.data = data;
		log(data);
		asyncHandler();
	}

	function testStart(data:Dynamic):Void {
		log('TEST');
		vastAss.start();
	}

	function getVastError(data:Dynamic):Void {
		log('ERROR getVast');
		vastAss.error(data);
	}
	function parseVastError(data:Dynamic):Void {
		log('ERROR parseVast');
		vastAss.error(data);
	}

	function log(data:Dynamic):Void {
		#if js
		js.Browser.console.log(name, data);
		#end
		trace(name, data);
	}


}