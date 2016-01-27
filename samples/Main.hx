package;
import bs.model.vast.Vast;
import bs.tools.Trace;
import bs.vast.VASTClient;

/**
 * ...
 * @author Piotr Skolysz <piotr.skolysz@bigsoda.pl>
 */
class Main
{
	
	public static function main()
	{
		//VASTClient.getVast("http://localhost:9999/vast/1a.xml", onVastLoadSuccess, onVastError);

		//VASTClient.getVast("http://localhost:9999/vast2/ad3.liverail.com.non.linear.xml", onVastLoadSuccess, onVastError);

		VASTClient.getVast("http://localhost:9999/vast3/vast3_inline.xml", onVastLoadSuccess, onVastError);
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