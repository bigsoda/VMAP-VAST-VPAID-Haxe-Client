package bs.vast;
import bs.model.VastError.VastErrorEvent;
import bs.interfaces.IParser;
import bs.model.vast.ad.Ad;
import bs.model.HttpError;
import bs.model.vast.Vast;
import bs.parser.VAST_1_0;
import bs.parser.VAST_2_0;
import bs.parser.VAST_3_0;
import bs.tools.Trace;
import haxe.Constraints.Function;
import haxe.Http;
import haxe.xml.Fast;
import js.html.ProgressEvent;
import js.html.XMLHttpRequest;

/**
 * ...
 * @author Piotr Skolysz <piotr.skolysz@bigsoda.pl>
 */
class VASTClient
{
	
	public function new() 
	{
		
	}
	
	public static function parseVast(xml:Xml, success:Vast->Void, error:VastErrorEvent->Null<String>->Void):Void
	{ 
		var version:VastVersion = null;

		var vastNode = new Fast(xml);
		if (vastNode.hasNode.VAST)
			version = Vast.getVersion(vastNode.node.VAST.att.version);
		else
		if (vastNode.hasNode.VideoAdServingTemplate)
			version = VastVersion.v_1_0;

		var parser:Class<IParser>;
		switch(version) {
			case VastVersion.v_1_0 : parser = VAST_1_0;
			case VastVersion.v_2_0 | VastVersion.v_3_0 : parser = VAST_3_0;
			default : parser = VAST_3_0;
		}
		VastParser.parse(xml, parser, success, error);
	}
	
	public static function getVast(url:String, success:Dynamic->Void, error:VastErrorEvent->Null<String>->Void, ?timeout = 6000):Void
	{
		var req:XMLHttpRequest = new XMLHttpRequest();
		req.onerror = error;
		req.onloadend = function():Void {
			if (req.status == 200) {
				var xml = Xml.parse(req.response); 
				success(xml);
			} else {
				for (err in HttpError.LIST) {
					if (err.code == req.status)
						error(err, req.statusText);
					else 
						error({code:req.status , description:req.statusText }, null);
				}
			}
			
		}; 
		req.open('GET', url);
		req.timeout = timeout;
		req.send();
	}
	
}