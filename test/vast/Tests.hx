package vast;

import bs.model.vast.Vast;
import bs.vast.VASTClient;
import massive.munit.Assert;
import massive.munit.async.AsyncFactory;
import bs.model.vast.ad.creatives.linear.Icon;
import bs.model.vast.ad.creatives.linear.MediaFile;
import bs.model.vast.ad.creatives.nonlinears.NonLinear;
import bs.model.vast.ad.creatives.linear.Linear;
import bs.model.vast.ad.creatives.companion.Companion;
import bs.model.vast.ad.creatives.CreativeDetails;
import bs.model.vast.ad.creatives.Creative;
import bs.model.vast.ad.Impression;
import bs.model.vast.ad.Ad;

class Tests
{
	var data:Vast;
	var name:String;
	var asyncHandler:Dynamic;

	public function new() {}

	@Before
	public function setup():Void {
		name = Type.getClassName(Type.getClass(this));
		log('START');
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
		this.data = data;
		log(data);
		asyncHandler();
	}

	function getVastError(data:Dynamic):Void {
		log('ERROR getVast');
		error(data);
	}
	function parseVastError(data:Dynamic):Void {
		log('ERROR parseVast');
		error(data);
	}

	function log(data:Dynamic):Void {
		#if js
		js.Browser.console.log(name, data);
		#end
		var str = '';
		try { str = data.toString(); } catch(err:Dynamic) { };
		trace(name + ' : ' + str);
	}

	function error(data:Dynamic):Void {
		Assert.fail(' onVastError ' + data);
	}
	///////////////////////////////////////////

	public function testStart():Void {
		log('TEST');
		Assert.isNotNull(data.version);
		Assert.isNotNull(data.ads);
		if (data.ads.length < 1 )
			Assert.fail('VAST ads.length < 1');
		if (data.version == VastVersion.v_1_0) {
			checkAdsV1(data.ads);
		}
		else if (data.version == VastVersion.v_2_0) {
			checkAdsV2(data.ads);
		}
		else if (data.version == VastVersion.v_3_0) {
			checkAdsV3(data.ads);
		}
	}

	function checkAdsV1(ads:Array<Ad>):Void {
		for(ad in ads) {
			Assert.isNotNull(ad.system);
			Assert.isNotNull(ad.title);
		}
	}


	function checkAdsV2(ads:Array<Ad>):Void {
		for(ad in ads) {
			Assert.isNotNull(ad.id);
			Assert.isNotNull(ad.system);
			Assert.isNotNull(ad.title);
			Assert.isNotNull(ad.impressions);
			checkAdImpresions(ad.impressions);
			Assert.isNotNull(ad.creatives);
			checkAdCreatives(ad.creatives);
		}
	}

	function checkAdsV3(ads:Array<Ad>):Void {

		for(ad in ads) {
			Assert.isNotNull(ad.id);
			Assert.isNotNull(ad.sequence);
			Assert.isNotNaN(ad.sequence);
			Assert.areNotEqual(0, ad.sequence);
			Assert.isNotNull(ad.system);
			Assert.isNotNull(ad.title);
			Assert.isNotNull(ad.impressions);

//			if (ad.impressions.length < 1 )
//				Assert.fail('VAST Ad impressions.length < 1');
			checkAdImpresions(ad.impressions);

			Assert.isNotNull(ad.creatives);
//			if (ad.creatives.length < 1 )
//				Assert.fail('VAST Ad creatives.length < 1');
			checkAdCreatives(ad.creatives);
		}
	}

	function checkAdImpresions(impressions:Array<Impression>):Void {
		for(imp in impressions) {
			Assert.isNotNull(imp);
			Assert.isNotNull(imp.url);
		}
	}

	function checkAdCreatives(creatives:Array<Creative>):Void {
		for(cre in creatives) {
			Assert.isNotNull(cre);
			Assert.isNotNull(cre.details);
			for(detail in cre.details) {
				Assert.isNotNull(detail);
				switch(Type.getClassName(Type.getClass(detail))) {
					case "bs.model.vast.ad.creatives.companion.Companion":
						checkAdCreativeCompanion(cast detail);
					case "bs.model.vast.ad.creatives.linear.Linear":
						checkAdCreativeLinear(cast detail);
					case "bs.model.vast.ad.creatives.nonlinears.NonLinear":
						checkAdCreativeNonLinear(cast detail);
					default : null;
				}
			}
		}
	}

	function checkAdCreativeCompanion(comp:Companion):Void {
		Assert.isNotNaN(comp.width);
		Assert.isNotNaN(comp.height);
	}

	function checkAdCreativeNonLinear(nlin:NonLinear):Void {
		Assert.isNotNaN(nlin.width);
		Assert.isNotNaN(nlin.height);
	}

	function checkAdCreativeLinear(lin:Linear):Void {
		Assert.isNotNaN(lin.duration);

		//Assert.isNotNull(lin.mediaFiles);
		if (lin.mediaFiles != null)
			checkAdCreativeLinearMediaFiles(lin.mediaFiles);

		if (lin.icons != null)
			checkAdCreativeLinearIcons(lin.icons);
	}

	function checkAdCreativeLinearMediaFiles(mediaFiles:Array<MediaFile>):Void {
		for(mf in mediaFiles) {
			Assert.isNotNull(mf.delivery);
			Assert.isNotNull(mf.type);
			Assert.isNotNaN(mf.width);
			Assert.isNotNaN(mf.height);
		}
	}

	function checkAdCreativeLinearIcons(icons:Array<Icon>):Void {
		for(ico in icons) {
			Assert.isNotNull(ico.program);
			Assert.isNotNaN(ico.width);
			Assert.isNotNaN(ico.height);
			Assert.isNotNaN(ico.xPosition);
			Assert.isNotNaN(ico.yPosition);
		}
	}





}