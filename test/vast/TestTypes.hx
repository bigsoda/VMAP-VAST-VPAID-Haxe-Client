package vast;

import haxe.xml.Fast;
import bs.model.VastTypes.RequiredType;
import bs.model.VastTypes.ResourceType;
import bs.model.vast.Vast.VastVersion;
import bs.model.VastTypes.ClickType;
import bs.model.VastTypes.Tracking;
import bs.model.VastTypes.TrackingEvent;
import bs.model.VastTypes.MIMEType;
import bs.model.VastTypes.DeliveryType;

class TestTypes {

}

typedef VastTestType = {
    var version:VastVersion;
    var ads:Array<AdTestType>;
    var error:ErrorTestType;
}

typedef AdTestType = {
    var id:String;
    var system:AdSystemTestType;
    var title:String;
    var impressions:Array<ImpressionTestType>;
    var creatives:Array<CreativeTestType>;
    //optional
    var ids:Array<String>;
    var description:String;
    var errors:Array<ErrorTestType>;
    var advertiser:String;
    var survey:String;
    var sequence:Int;
    var extensions:Array<Fast>;
    var pricing:PricingTestType;
}

typedef CreativeTestType = {
    var id:String;
    var sequence:Int;
    var adID:String;
    var apiFramework:String;
    var creativeExtensions:Array<CreativeExtensionTestType>;
    var details:Dynamic;
    var adIDs:Array<String>;
}
typedef CreativeExtensionTestType = {
    var type:MIMEType;
    var data:String;
}
typedef ImpressionTestType = {
    var url:String;
    var id:String;
}

typedef ErrorTestType = {
    var url:String;
}

typedef PricingTestType = {
    var price:Float;
    var model:String;
    var currency:String;
}

typedef AdSystemTestType = {
    var name:String;
    var version:String;
}

typedef CreativeLinearTestType = {
    var details:Array<Dynamic>;
    //optional
    var id:String;
    var sequence:Int;
    var adID:String;
    var adIDs:Array<String>;
    var apiFramework:String;
    var creativeExtensions:Array<CreativeExtensionTestType>;

}

typedef CreativeDetailNonLinearAdsTestType = {
    var nonLinear:Array<NonLinearTestType>;
    var trackingEvents:Array<TrackingTestType>;
}

typedef NonLinearTestType = {
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
    var resources:Array<ResourceTestType>;
    var clicks:Array<ClickTestType>;
    var adParameters:AdParametersTestType;
}

typedef ClickTestType = {
    var type:ClickType;
    var url:String;
//optional
    var id:String;
}

typedef ResourceTestType = {
    var type:ResourceType;
    var creativeType:MIMEType;
    var url:String;
}

typedef CreativeDetailCompanionTestType = {
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
    var adParameters:AdParametersTestType;
    var altText:String;
    var clicks:Array<ClickTestType>;
    var trackingEvents:Array<TrackingTestType>;
}

typedef CreativeDetailLinearTestType = {
    var duration:Float;
    var mediaFiles:Array<MediaFileTestType>;
    //optional
    var skipoffset:Float;
    var adParameters:AdParametersTestType;
    var videoClicks:Array<ClickTestType>;
    var trackingEvents:Array<TrackingTestType>;
    var icons:Array<Dynamic>;
}

typedef AdParametersTestType = {
    var xmlEncoded:Bool;
    var id:String;
    var data:String;
}

typedef MediaFileTestType = {
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

typedef TrackingTestType = {
    var url:String;
    var event:TrackingEvent;
}