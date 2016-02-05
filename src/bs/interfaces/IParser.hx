package bs.interfaces;

import bs.model.VastError.VastErrorEvent;
import bs.model.vast.Vast;
/**
 * @author Piotr Skolysz <piotr.skolysz@bigsoda.pl>
 */
interface IParser 
{
	function parse(xml:Xml, onError:VastErrorEvent->Null<String>->Void):Vast;
}