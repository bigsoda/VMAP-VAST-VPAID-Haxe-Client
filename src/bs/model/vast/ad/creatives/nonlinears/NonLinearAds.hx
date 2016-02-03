package bs.model.vast.ad.creatives.nonlinears;
import bs.interfaces.ICreativeDetails;

class NonLinearAds implements ICreativeDetails
{
	/**
	 * a container for the <NonLinear> element
	 */
	public var nonLinear:Array<NonLinear>;
	/**
	 * a container for the <Tracking> element used to track defined metrics defined by the event attribute
	 */
	public var trackingEvents:Array<Tracking>;
	public function new() 
	{
		
	}
	
}