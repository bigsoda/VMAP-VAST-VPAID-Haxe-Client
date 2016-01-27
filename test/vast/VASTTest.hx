package vast;
import haxe.xml.Fast;
import js.html.XMLHttpRequest;
import massive.munit.Assert;
import massive.munit.async.AsyncFactory;

import bs.model.vast.Vast;
import bs.vast.VASTClient;

/**
* Auto generated ExampleTest for MassiveUnit. 
* This is an example test class can be used as a template for writing normal and async tests 
* Refer to munit command line tool for more information (haxelib run munit)
*/
class VASTTest
{
	var vastXmlUrls:Array<String>;
//	var vastData:Vast;
	var asyncHandler:Dynamic;

	public function new() { }


	@BeforeClass
	public function beforeClass():Void
	{
		trace('beforeClass');

//		vastXmlUrls = [
//
//		];
	}


	@AsyncTest
	public function getVAST(factory:AsyncFactory):Void {

		asyncHandler = factory.createHandler(this, startTests, 6000);

		var req:XMLHttpRequest = new XMLHttpRequest();
		req.onerror = function():Void {
			Assert.fail('load examples xml error');
		}
		req.onloadend = function():Void {
			if (req.status == 200) {
				var xml = Xml.parse(req.response);
				for( elt in xml.firstElement().elements() ) {
					trace(elt.toString());
				}
			} else {
				Assert.fail(req.statusText);
			}
		};
		req.open('GET', 'http://localhost:9999/vast.examples.xml');
		req.send();


		//trace(vastXmlUrls);

//		for (url in vastUrls) {
//			trace(url);
//		}

//
		// LOCAL EXAMPLES
//		VASTClient.getVast(, parseVAST, onError);

	}

//	function parseVAST(data:Xml):Void {
//		VASTClient.parseVast(data, onVastParseSuccess, onError);
//	}
//
//	function onVastParseSuccess(data:Vast):Void {
//		vastData = data;
//		asyncHandler();
//	}
//
//	function onError(data:Dynamic):Void {
//		Assert.fail(' onVastError ' + data);
//	}
//
	function startTests():Void {
//		checkVersion();
//		checkAds();
	}
//
//	function checkVersion():Void {
//		Assert.isNotNull(vastData.version);
//	}
//
//	function checkAds():Void {
//		Assert.isNotNull(vastData.ads);
//		if (vastData.ads.length < 1 )
//			Assert.fail('VAST Ads array.length < 1');
//	}


}