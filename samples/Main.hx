package;
import bs.model.vast.ad.Ad;
import bs.model.vast.ad.creatives.Click;
import bs.model.vast.Vast;
import bs.parser.VAST_2_0;
import bs.parser.VAST_3_0;
import bs.tools.Trace;
import bs.vast.VASTClient;
import haxe.Constraints.Function;

/**
 * ...
 * @author Piotr Skolysz <piotr.skolysz@bigsoda.pl>
 */
class Main
{
	
	public static function main()
	{
//		VASTClient.getVast("http://localhost:9999/vast/1a.xml", onVastLoadSuccess, onVastError);
//		VASTClient.getVast("http://demo.tremorvideo.com/proddev/vast/vast2RegularLinear.xml", onVastLoadSuccess, onVastError);
//		VASTClient.getVast("http://ad3.liverail.com/?LR_PUBLISHER_ID=1331&LR_CAMPAIGN_ID=229&LR_SCHEMA=vast2", onVastLoadSuccess, onVastError);
//		VASTClient.getVast("http://ad3.liverail.com/?LR_PUBLISHER_ID=1331&LR_CAMPAIGN_ID=228&LR_SCHEMA=vast2", onVastLoadSuccess, onVastError);
		VASTClient.getVast("http://localhost:9999/vast2/ad3.liverail.com.non.linear.xml", onVastLoadSuccess, onVastError);
	}
	
	static function onVastLoadSuccess(data:Xml):Void
	{
		VASTClient.parseVast(data, onVastParseSuccess, onVastError);
	}

	static function onVastError(data:Dynamic):Void
	{
		Trace.error(data);
	}

	static function onVastParseSuccess(data:Vast):Void
	{
		Trace.info(data);
	}
}