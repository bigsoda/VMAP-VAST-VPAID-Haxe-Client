package bs.model;

/**
 * ...
 * @author Piotr Skolysz <piotr.skolysz@bigsoda.pl>
 */
class VastError
{
	public static var CODE_100:VastErrorEvent = { code:100, description:"XML parsing error." };
	public static var CODE_101:VastErrorEvent = { code:101, description:"VAST schema validation error." };
	public static var CODE_102:VastErrorEvent = { code:102, description:"VAST version of response not supported." };
	public static var CODE_200:VastErrorEvent = { code:200, description:"Trafficking error. Video player received!an Ad type that it was not expecting and/or cannot display." };
	public static var CODE_201:VastErrorEvent = { code:201, description:"Video player expecting different linearity." };
	public static var CODE_202:VastErrorEvent = { code:202, description:"Video player expecting different duration." };
	public static var CODE_203:VastErrorEvent = { code:203, description:"Video player expecting different size." };
	public static var CODE_300:VastErrorEvent = { code:300, description:"General Wrapper error." };
	public static var CODE_301:VastErrorEvent = { code:301, description:"Timeout of VAST URI provided in Wrapper element, or of VAST URI provided in a subsequent Wrapper element. (URI was either unavailable or reached a timeout as defined by the video player.)" };
	public static var CODE_302:VastErrorEvent = { code:302, description:"Wrapper limit reached, as defined by the video player. Too many Wrapper responses have been received with no InLine response." };
	public static var CODE_303:VastErrorEvent = { code:303, description:"No Ads VAST response after one or more Wrappers." };
	public static var CODE_400:VastErrorEvent = { code:400, description:"General Linear error. Video player is unable to display the Linear Ad." };
	public static var CODE_401:VastErrorEvent = { code:401, description:"File not found. Unable to find Linear/MediaFile from URI." };
	public static var CODE_402:VastErrorEvent = { code:402, description:"Timeout of MediaFile URI." };
	public static var CODE_403:VastErrorEvent = { code:403, description:"Couldn't find MediaFile that is supported by this video!player, based on the attributes of the MediaFile element." };
	public static var CODE_405:VastErrorEvent = { code:405, description:"Problem displaying MediaFile. Video player found a MediaFile with supported type but couldn't display it. MediaFile may include: unsupported codecs, different MIME type than MediaFile@type, unsupported delivery method, etc." };
	public static var CODE_500:VastErrorEvent = { code:500, description:"General NonLinearAds error." };
	public static var CODE_501:VastErrorEvent = { code:501, description:"Unable to display NonLinear Ad because creative dimensions do not align with creative display area (i.e. creative dimension too large)." };
	public static var CODE_502:VastErrorEvent = { code:502, description:"Unable to fetch NonLinearAds/NonLinear resource." };
	public static var CODE_503:VastErrorEvent = { code:503, description:"Couldn’t find NonLinear resource with supported type." };
	public static var CODE_600:VastErrorEvent = { code:600, description:"General CompanionAds error." };
	public static var CODE_601:VastErrorEvent = { code:601, description:"Unable to display Companion because creative dimensions do not fit within Companion display area (i.e., no available space)." };
	public static var CODE_602:VastErrorEvent = { code:602, description:"Unable to display Required Companion." };
	public static var CODE_603:VastErrorEvent = { code:603, description:"Unable to fetch CompanionAds/Companion resource." };
	public static var CODE_604:VastErrorEvent = { code:604, description:"Couldn’t find Companion resource with supported type." };
	public static var CODE_900:VastErrorEvent = { code:900, description:"Undefined Error." };
	public static var CODE_901:VastErrorEvent = { code:901, description:"General VPAID error." };
 
	public function new() 
	{
		
	}
	
}

typedef VastErrorEvent = {
	var code:Int;
	@:optional var title:String;
	var description:String;
}