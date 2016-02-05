package bs.parser;
import bs.model.VastError.VastErrorEvent;
import haxe.xml.Fast;
import bs.parser.VAST_3_0;
import bs.interfaces.IParser;
import bs.model.vast.ad.Ad;
import bs.model.vast.Vast;
import bs.tools.Trace;
import haxe.Constraints.Function;

/**
 * ...
 * @author Piotr Skolysz <piotr.skolysz@bigsoda.pl>
 */
class VAST_1_0 implements IParser
{

	public function new() 
	{
	}
	
	public function parse(xml:Xml, onError:VastErrorEvent->Null<String>->Void):Vast
	{
		trace("PARSE FROM VAST_2_0 Parser");
		return new Vast();
	}

/*
	override public function parse(vastXml:Xml, onWarn:Dynamic->Void, onError:Dynamic->Void):Vast
	{
		error = onError;
		error = onError;
		var result:Vast = new Vast();
		result.version = VastVersion.v_1_0;
		vast = new Fast(vastXml.firstElement());
		result.ads = getAds(vast.nodes.Ad);
		return result;
	}

	override function getAds(ads:List<Fast>):Array<Ad>
	{
		var result:Array<Ad> = new Array<Ad>();

		for (adFast in ads)
		{
			var ad:Ad = new Ad();
			//Requierd
			ad.id = adFast.att.id;
			ad.system = getAdSystem(adFast.node.InLine.node.AdSystem);
			ad.title = adFast.node.InLine.node.AdTitle.innerData;

			//TODO: parse VAST 1.0
			if (adFast.node.InLine.hasNode.Creatives)
				ad.creatives = getCreatives(adFast.node.InLine.node.Creatives.nodes.Creative);
			//if (adFast.node.InLine.hasNode.Impression)
			//	ad.impressions = getImpressions(adFast.node.InLine.nodes.Impression);

			//Optional
			if (adFast.node.InLine.hasNode.Advertiser)
				ad.advertiser = adFast.node.InLine.node.Advertiser.innerData;
			if (adFast.node.InLine.hasNode.Description)
				ad.description = adFast.node.InLine.node.Description.innerData;
			if (adFast.node.InLine.hasNode.Error)
				ad.errors = getErrors(adFast.node.InLine.nodes.Error);
			if (adFast.node.InLine.hasNode.Extensions)
				ad.extensions = getExtensions(adFast.node.InLine.node.Extensions);
			if (adFast.node.InLine.hasNode.Pricing)
				ad.pricing = getPricing(adFast.node.InLine.node.Pricing);
			if (adFast.has.sequence)
				ad.sequence = Std.parseInt(adFast.att.sequence);
			if (adFast.node.InLine.hasNode.Survey)
				ad.survey = adFast.node.InLine.node.Survey.innerData;

			result.push(ad);
		}

		return result;
	}
*/
}