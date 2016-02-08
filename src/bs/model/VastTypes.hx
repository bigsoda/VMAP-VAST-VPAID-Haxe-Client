package bs.model;

import haxe.xml.Fast;
import bs.model.vast.Vast.VastVersion;
import bs.model.vast.ad.creatives.MIMEType;
import bs.model.vast.ad.creatives.Click.ClickType;
import bs.model.vast.ad.creatives.Tracking.TrackingEvent;
import bs.model.vast.ad.creatives.Resource.ResourceType;
import bs.model.vast.ad.creatives.linear.MediaFile.DeliveryType;
import bs.model.vast.ad.creatives.companion.Companion.RequiredType;

class VastTypes {

}

typedef Vast = {
    var version:VastVersion;
    var ads:Array<Ad>;
    var error:Error;
}

typedef Ad = {
    var id:String;
    var system:AdSystem;
    var title:String;
    var impressions:Array<Impression>;
    var creatives:Array<Creative>;
    //optional
    var ids:Array<String>;
    var description:String;
    var errors:Array<Error>;
    var advertiser:String;
    var survey:String;
    var sequence:Int;
    var extensions:Array<Fast>;
    var pricing:Pricing;
}

typedef Creative = {
    var id:String;
    var sequence:Int;
    var adID:String;
    var apiFramework:String;
    var creativeExtensions:Array<CreativeExtension>;
    var details:Dynamic;
    var adIDs:Array<String>;
}

typedef CreativeExtension = {
    var type:MIMEType;
    var data:String;
}

typedef Impression = {
    var url:String;
    var id:String;
}

typedef Error = {
    var url:String;
}

typedef Pricing = {
    var price:Float;
    var model:String;
    var currency:String;
}

typedef AdSystem = {
    var name:String;
    var version:String;
}

typedef CreativeLinear = {
    var details:Array<Dynamic>;
    //optional
    var id:String;
    var sequence:Int;
    var adID:String;
    var adIDs:Array<String>;
    var apiFramework:String;
    var creativeExtensions:Array<CreativeExtension>;

}

typedef CreativeDetailNonLinearAds = {
    var nonLinear:Array<NonLinear>;
    var trackingEvents:Array<Tracking>;
}

typedef NonLinear = {
    var width:Float;
    var height:Float;
    //optional
    var id:String;
    var expandedWidth:Float;
    var expandedHeight:Float;
    var scalable:Bool;
    var maintainAspectRatio:Bool;
    var minSuggestedDuration:Float;
    var apiFramework:String;
    var resources:Array<Resource>;
    var clicks:Array<Click>;
    var adParameters:AdParameters;
}

typedef Click = {
    var type:ClickType;
    var url:String;
//optional
    var id:String;
}

typedef Resource = {
    var type:ResourceType;
    var creativeType:MIMEType;
    var url:String;
}

typedef CreativeDetailCompanion = {
    var width:Float;
    var height:Float;
//optional
    var id:String;
    var assetWidth:Float;
    var assetHeight:Float;
    var expandedWidth:Float;
    var expandedHeight:Float;
    var apiFramework:String;
    var adSlotID:String;
    var required:RequiredType;
    var resources:Array<Dynamic>;
    var adParameters:AdParameters;
    var altText:String;
    var clicks:Array<Click>;
    var trackingEvents:Array<Tracking>;
}

typedef CreativeDetailLinear = {
    var duration:Float;
    var mediaFiles:Array<MediaFile>;
    //optional
    var skipoffset:Float;
    var adParameters:AdParameters;
    var videoClicks:Array<Click>;
    var trackingEvents:Array<Tracking>;
    var icons:Array<Dynamic>;
}

typedef AdParameters = {
    var xmlEncoded:Bool;
    var id:String;
    var data:String;
}

typedef MediaFile = {
    var url:String;
    var delivery:DeliveryType;
    var type:MIMEType;
    var width:Int;
    var height:Int;
    //optional
    var id:String;
    var bitrate:Float;
    var minBitrate:Float;
    var maxBitrate:Float;
    var scalable:Bool;
    var maintainAspectRatio:Bool;
    var codec:String;
    var apiFramework:String;
}

typedef Tracking = {
    var url:String;
    var event:TrackingEvent;
}
//
//@:enum abstract RequiredType(String) {
///** the video player must attempt to display the contents for all <Companion> elements provided; if all Companion creative cannot be displayed, the Ad should be disregarded and the ad server should be notified using the <Error> elemen */
//    var  ALL = "all";
///** the video player must attempt to display content from at least one of the <Companion> elements provided (i.e. display the one with dimensions that best fit the page); if none of the Companion creative can be displayed, the Ad should be disregarded and the ad server should be notified using the <Error> element */
//    var ANY = "any";
///** the video player may choose to not display any of the Companion creative, but is not restricted from doing so; the ad server may use this option when the advertiser prefers that the master ad be displayed with or without the Companion creative */
//    var  NONE = "none";
//}
//
//@:enum abstract DeliveryType(String) {
//    var PROGRESSIVE = "progressive";
//    var STREAMING = "streaming";
//}
//
//@:enum abstract VastVersion(String) {
//    var v_1_0 = "1.0";
//    var v_2_0 = "2.0";
//    var v_3_0 = "3.0";
//}
//
//@:enum abstract ResourceType(String) {
///**  Describes non-html creative where an attribute for creativeType is used to identify the creative resource platform. The video player uses the creativeType information to determine how to display the resource */
//    var STATIC_RESOURCE = "StaticResource";
///** Describes a resource that is an HTML page that can be displayed within an Iframe on the publisher's page */
//    var I_FRAME_RESOURCE = "IFrameResource";
///** Describes a "snippet" of HTML code to be inserted directly within the publisher's HTML page code. */
//    var HTML_RESOURCE = "HTMLResource";
//}
//
//@:enum abstract ClickType(String) {
///** contains a URI to a page that the video player should request and display in a Web browser window when the user clicks within the video frame while the Linear ad is  played (known as the 	"clickthrough" or "landing page" URI); the server can also use requests to this URI for tracking the "clickthrough" metric */
//    var CLICK_THROUGH = "ClickThrough";
///** contains a URI to a location or file that the video player should request when the user clicks within the video frame while the Linear ad is played; the server can also use requests to this URI for tracking the “clickthrough” metric */
//    var CLICK_TRACKING = "ClickTracking";
///** contains a URI to a location or file that the video player should request when the user clicks on a particular button, link, or other call to action associated with the Linear ad during its playback, but which does not open a new page in a Web browser window; the ClickThrough and CustomClick URLs should never be requested at the same time (i.e. for the same click) */
//    var CUSTOM_CLICK = "CustomClick";
///** contains a URI for a Webpage that the video player should open in a Web browser window when the user clicks on the Icon creative that is displayed in association with the ad; may also be used to track the click */
//    var ICON_CLICK_THROUGH = "IconClickThrough";
///** contains a URI to a location or file that the video player should request when the user clicks on the Icon creative */
//    var ICON_CLICK_TRACKING = "IconClickTracking";
///** contains a URI for a Webpage that the video player should open in a Web browser window when the user clicks on the companion creative; URI may also be used to track the clickthrough */
//    var COMPANION_CLICK_THROUGH = "CompanionClickThrough";
///** contains a URI to a location or file that the video player should request when the user clicks on the companion creative; used to track the clickthrough for InLine creative when the creative handles the click; in a Wrapper Ad the URI is used to track clickthroughs for the InLine response that results after the Wrapper */
//    var COMPANION_CLICK_TRACKING = "CompanionClickTracking";
///** contains a URI for a Webpage that the video player should open in a Web browser window when the user clicks on the Nonlinear creative; */
//    var NON_LINEAR_CLICK_THROUGH = "NonLinearClickThrough";
///** contains a URI to a location or file that the video player should request when the user clicks on the Nonlinear creative; used to track an InLine clickthrough when the creative handles the click; in a Wrapper Ad the URI is used to track clickthroughs for the InLine response that results after the Wrapper */
//    var NON_LINEAR_CLICK_TRACKING = "NonLinearClickTracking";
//}
//
//@:enum abstract TrackingEvent(String) {
///** not to be confused with an impression, this event indicates that an individual creative portion of the ad was viewed. An impression indicates the first frame of the ad was displayed; however an ad may be composed of multiple creative, or creative that only play on some platforms and not others. This event enables ad servers to track which ad creative are viewed, and therefore, which platforms are more common. */
//    var CREATIVE_VIEW = "creativeView";
///** this event is used to indicate that an individual creative within the ad was loaded and playback began. As with creativeView, this event is another way of tracking creative playback. */
//    var START = "start";
///** the creative played for at least 25% of the total duration */
//    var FIRST_QUARTILE = "firstQuartile";
///** the creative played for at least 50% of the total duration */
//    var MIDPOINT = "midpoint";
///** the creative played for at least 75% of the duration */
//    var THIRD_QUARTILE = "thirdQuartile";
///** The creative was played to the end at normal speed */
//    var COMPLETE = "complete";
///** the user activated the mute control and muted the creative */
//    var MUTE = "mute";
///** the user activated the mute control and unmuted the creative */
//    var UNMUTE = "unmute";
///** the user clicked the pause control and stopped the creative */
//    var PAUSE = "pause";
///** the user activated the rewind control to access a previous point in the creative timeline */
//    var REWIND = "rewind" ;
///** the user activated the resume control after the creative had been stopped or paused */
//    var RESUME = "resume";
///** the user activated a control to extend the video player to the edges of the viewer's screen */
//    var FULLSCREEN = "fullscreen";
///** the user activated the control to reduce video player size to original dimensions */
//    var EXIT_FULLSCREEN = "exitFullscreen";
///** the user activated a control to expand the creative */
//    var EXPAND = "expand";
///** the user activated a control to reduce the creative to its original dimensions */
//    var COLLAPSE = "collapse";
///** the user activated a control that launched an additional portion of the creative. The name of this event distinguishes it from the existing “acceptInvitation” event described in the 2008 IAB Digital Video In-Stream Ad Metrics Definitions, which defines the "acceptInivitation" metric as applying to non-linear ads only. The “acceptInvitationLinear” event extends the metric for use in Linear creative */
//    var ACCEPT_INVITATION_NONLINEAR = "acceptInvitation";
///** Indicates that the user clicks or otherwise activates a control to expand the viewable area (or “take-over” the video content area) and launch an additional portion of the ad. A video ad is usually played upon acceptance, but other types of formats, including rich media, are also used. 	*/
//    var ACCEPT_INVITATION_LINEAR = "acceptInvitationLinear";
///** the user clicked the close button on the creative. The name of this event distinguishes it from the existing “close” event described in the 2008 IAB Digital Video In-Stream Ad Metrics Definitions, which defines the "close" metric as applying to non-linear ads only. The "closeLinear" event extends the "close" event for use in Linear creative [ref: http://www.iab.net/media/file/DV_In-Stream_Metrics_Definitions.pdf] */
//    var CLOSE_NONLINEAR = "close";
///** Indicates that the user clicks or otherwise activates a Close control which fully dispatches the ad from the player environment. May not apply to non-overlay ads. [ref: http://www.iab.net/media/file/DV_In-Stream_Metrics_Definitions.pdf] */
//    var CLOSE_LINEAR = "closeLinear" ;
///** the user activated a skip control to skip the creative, which is a different control than the one used to close the creative. */
//    var SKIP = "skip" ;
///** the creative played for a duration at normal speed that is equal to or greater than the value provided in an additional attribute for offset. Offset values can be time in the format HH:MM:SS or HH:MM:SS.mmm or a percentage value in the format n%. Multiple progress events with different values can be used to track multiple progress points in the Linear creative timeline */
//    var PROGRESS = "progress";
//}
//
//@:enum abstract MIMEType(String) {
//    var VIDEO_X_FLV = "video/x-flv";
//    var VIDEO_MP4 = "video/mp4";
//    var VIDEO_F4V = "video/f4v";
//    var VIDEO_F4M = "video/f4m";
//    var APPLICATION_X_SHOCKWAVE_FLASH = "application/x-shockwave-flash";
//    var APPLICATION_X_JAVASCRIPT = "application/x-javascript";
//    var APPLICATION_X_MPEGURL = "application/x-mpegURL";
//    var IMAGE_JPEG = "image/jpeg";
//    var IMAGE_GIF = "image/gif";
//    var IMAGE_PNG = "image/png";
//    var NOT_SUPPORTED = "NOT_SUPPORTED";
//}