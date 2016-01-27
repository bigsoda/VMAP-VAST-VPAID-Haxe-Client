package vast;

import bs.model.vast.Vast;
import massive.munit.Assert;


class Asserts
{
	public var data:Vast;

	public function new() {}

	public function error(data:Dynamic):Void {
		Assert.fail(' onVastError ' + data);
	}

	public function start():Void {
		checkVersion();
		checkAds();
	}

	function checkVersion():Void {
		Assert.isNotNull(data.version);
	}

	function checkAds():Void {
		Assert.isNotNull(data.ads);

		if (data.ads.length < 1 )
			Assert.fail('VAST Ads array.length < 1');

	}


}