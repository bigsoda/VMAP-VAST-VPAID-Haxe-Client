package vast;

import bs.model.VastTypes.Vast;
import bs.model.VastTypes.RequiredType;
import bs.model.VastTypes.ResourceType;
import bs.model.VastTypes.ClickType;
import bs.model.VastTypes.Tracking;
import bs.model.VastTypes.TrackingEvent;
import bs.model.VastTypes.MIMEType;
import bs.model.VastTypes.DeliveryType;
import bs.model.VastTypes.CreativeDetailNonLinearAds;
import bs.model.VastTypes.VastVersion;
import massive.munit.async.AsyncFactory;

class Vast2NonLinearTest extends Tests
{
	public function new() { super(); }

	@AsyncTest
	public function test(factory:AsyncFactory):Void {
		super.vast(factory,'web/examples/vast2/vast2Nonlinear.xml');

	}
	override public function testStart():Void {
		super.testStart();
		///////////////////////////
		var nonLinearAds1:CreativeDetailNonLinearAds = {
			nonLinear:[{
				width:380, height:60, minSuggestedDuration:20, apiFramework:"VPAID", id:"overlay-1", clicks:[], adParameters:null,expandedWidth:null, expandedHeight:null, scalable:null, maintainAspectRatio:null,
				resources:[{type:ResourceType.STATIC_RESOURCE, creativeType:MIMEType.APPLICATION_X_SHOCKWAVE_FLASH, url:"http://static.scanscout.com/ads/vpaidad3.swf?adData=http%3A//app.scanscout.com/ssframework/adStreamJSController.xml%3Fa%3Dgetadscheduleforcontent%26PI%3D567%26scheduleVersion%3D3%26HI%3D567|overlay|372934318%26AI%3D0"}]
			}],
			trackingEvents:null
		};
		var nonLinearAds2:CreativeDetailNonLinearAds = {
			nonLinear:[{
				width:380, height:60, minSuggestedDuration:20, apiFramework:"VPAID", id:"overlay-2", clicks:[], adParameters:null,expandedWidth:null, expandedHeight:null, scalable:null, maintainAspectRatio:null,
				resources:[{type:ResourceType.STATIC_RESOURCE, creativeType:MIMEType.APPLICATION_X_SHOCKWAVE_FLASH, url:"http://static.scanscout.com/ads/vpaidad3.swf?adData=http%3A//app.scanscout.com/ssframework/adStreamJSController.xml%3Fa%3Dgetadscheduleforcontent%26PI%3D567%26scheduleVersion%3D3%26HI%3D567|overlay|372934318%26AI%3D1"}]
			}],
			trackingEvents:null
		};
		var nonLinearAds3:CreativeDetailNonLinearAds = {
			nonLinear:[{
				width:380, height:60, minSuggestedDuration:20, apiFramework:"VPAID", id:"overlay-3", clicks:[], adParameters:null,expandedWidth:null, expandedHeight:null, scalable:null, maintainAspectRatio:null,
				resources:[{type:ResourceType.STATIC_RESOURCE, creativeType:MIMEType.APPLICATION_X_SHOCKWAVE_FLASH, url:"http://static.scanscout.com/ads/vpaidad3.swf?adData=http%3A//app.scanscout.com/ssframework/adStreamJSController.xml%3Fa%3Dgetadscheduleforcontent%26PI%3D567%26scheduleVersion%3D3%26HI%3D567|overlay|372934318%26AI%3D2"}]
			}],
			trackingEvents:null
		};
		var nonLinearAds4:CreativeDetailNonLinearAds = {
			nonLinear:[{
				width:380, height:60, minSuggestedDuration:20, apiFramework:"VPAID", id:"overlay-4", clicks:[], adParameters:null,expandedWidth:null, expandedHeight:null, scalable:null, maintainAspectRatio:null,
				resources:[{type:ResourceType.STATIC_RESOURCE, creativeType:MIMEType.APPLICATION_X_SHOCKWAVE_FLASH, url:"http://static.scanscout.com/ads/vpaidad3.swf?adData=http%3A//app.scanscout.com/ssframework/adStreamJSController.xml%3Fa%3Dgetadscheduleforcontent%26PI%3D567%26scheduleVersion%3D3%26HI%3D567|overlay|372934318%26AI%3D3"}]
			}],
			trackingEvents:null
		};
		var nonLinearAds5:CreativeDetailNonLinearAds = {
			nonLinear:[{
				width:380, height:60, minSuggestedDuration:20, apiFramework:"VPAID", id:"overlay-5", clicks:[], adParameters:null,expandedWidth:null, expandedHeight:null, scalable:null, maintainAspectRatio:null,
				resources:[{type:ResourceType.STATIC_RESOURCE, creativeType:MIMEType.APPLICATION_X_SHOCKWAVE_FLASH, url:"http://static.scanscout.com/ads/vpaidad3.swf?adData=http%3A//app.scanscout.com/ssframework/adStreamJSController.xml%3Fa%3Dgetadscheduleforcontent%26PI%3D567%26scheduleVersion%3D3%26HI%3D567|overlay|372934318%26AI%3D4"}]
			}],
			trackingEvents:null
		};
		var nonLinearAds6:CreativeDetailNonLinearAds = {
			nonLinear:[{
				width:380, height:60, minSuggestedDuration:20, apiFramework:"VPAID", id:"overlay-6", clicks:[], adParameters:null,expandedWidth:null, expandedHeight:null, scalable:null, maintainAspectRatio:null,
				resources:[{type:ResourceType.STATIC_RESOURCE, creativeType:MIMEType.APPLICATION_X_SHOCKWAVE_FLASH, url:"http://static.scanscout.com/ads/vpaidad3.swf?adData=http%3A//app.scanscout.com/ssframework/adStreamJSController.xml%3Fa%3Dgetadscheduleforcontent%26PI%3D567%26scheduleVersion%3D3%26HI%3D567|overlay|372934318%26AI%3D5"}]
			}],
			trackingEvents:null
		};
		var nonLinearAds7:CreativeDetailNonLinearAds = {
			nonLinear:[{
				width:380, height:60, minSuggestedDuration:20, apiFramework:"VPAID", id:"overlay-7", clicks:[], adParameters:null,expandedWidth:null, expandedHeight:null, scalable:null, maintainAspectRatio:null,
				resources:[{type:ResourceType.STATIC_RESOURCE, creativeType:MIMEType.APPLICATION_X_SHOCKWAVE_FLASH, url:"http://static.scanscout.com/ads/vpaidad3.swf?adData=http%3A//app.scanscout.com/ssframework/adStreamJSController.xml%3Fa%3Dgetadscheduleforcontent%26PI%3D567%26scheduleVersion%3D3%26HI%3D567|overlay|372934318%26AI%3D6"}]
			}],
			trackingEvents:null
		};
		var nonLinearAds8:CreativeDetailNonLinearAds = {
			nonLinear:[{
				width:380, height:60, minSuggestedDuration:20, apiFramework:"VPAID", id:"overlay-8", clicks:[], adParameters:null,expandedWidth:null, expandedHeight:null, scalable:null, maintainAspectRatio:null,
				resources:[{type:ResourceType.STATIC_RESOURCE, creativeType:MIMEType.APPLICATION_X_SHOCKWAVE_FLASH, url:"http://static.scanscout.com/ads/vpaidad3.swf?adData=http%3A//app.scanscout.com/ssframework/adStreamJSController.xml%3Fa%3Dgetadscheduleforcontent%26PI%3D567%26scheduleVersion%3D3%26HI%3D567|overlay|372934318%26AI%3D7"}]
			}],
			trackingEvents:null
		};
		var nonLinearAds9:CreativeDetailNonLinearAds = {
			nonLinear:[{
				width:380, height:60, minSuggestedDuration:20, apiFramework:"VPAID", id:"overlay-9", clicks:[],  adParameters:null,expandedWidth:null, expandedHeight:null, scalable:null, maintainAspectRatio:null,
				resources:[{type:ResourceType.STATIC_RESOURCE, creativeType:MIMEType.APPLICATION_X_SHOCKWAVE_FLASH, url:"http://static.scanscout.com/ads/vpaidad3.swf?adData=http%3A//app.scanscout.com/ssframework/adStreamJSController.xml%3Fa%3Dgetadscheduleforcontent%26PI%3D567%26scheduleVersion%3D3%26HI%3D567|overlay|372934318%26AI%3D8"}]
			}],
			trackingEvents:null
		};
		var nonLinearAds10:CreativeDetailNonLinearAds = {
			nonLinear:[{
				width:380, height:60, minSuggestedDuration:20, apiFramework:"VPAID", id:"overlay-10", clicks:[], adParameters:null,expandedWidth:null, expandedHeight:null, scalable:null, maintainAspectRatio:null,
				resources:[{type:ResourceType.STATIC_RESOURCE, creativeType:MIMEType.APPLICATION_X_SHOCKWAVE_FLASH, url:"http://static.scanscout.com/ads/vpaidad3.swf?adData=http%3A//app.scanscout.com/ssframework/adStreamJSController.xml%3Fa%3Dgetadscheduleforcontent%26PI%3D567%26scheduleVersion%3D3%26HI%3D567|overlay|372934318%26AI%3D9"}]
			}],
			trackingEvents:null
		};
		var vast:Vast = {
			version:VastVersion.v_2_0,
			ads:[
				{ id:'overlay-1', system:{name:'2.0', version:null}, title:'5750100', impressions:[], creatives:[{ details:nonLinearAds1, adID:null, adIDs:null, sequence:null, id:null, creativeExtensions:null, apiFramework:null}], ids:null, description:null, errors:null, survey:null, advertiser:null, sequence:null, extensions:null, pricing:null },
				{ id:'overlay-2', system:{name:'2.0', version:null}, title:'5750092', impressions:[], creatives:[{ details:nonLinearAds2, adID:null, adIDs:null, sequence:null, id:null, creativeExtensions:null, apiFramework:null}], ids:null, description:null, errors:null, survey:null, advertiser:null, sequence:null, extensions:null, pricing:null },
				{ id:'overlay-3', system:{name:'2.0', version:null}, title:'5750094', impressions:[], creatives:[{ details:nonLinearAds3, adID:null, adIDs:null, sequence:null, id:null, creativeExtensions:null, apiFramework:null}], ids:null, description:null, errors:null, survey:null, advertiser:null, sequence:null, extensions:null, pricing:null },
				{ id:'overlay-4', system:{name:'2.0', version:null}, title:'5750091', impressions:[], creatives:[{ details:nonLinearAds4, adID:null, adIDs:null, sequence:null, id:null, creativeExtensions:null, apiFramework:null}], ids:null, description:null, errors:null, survey:null, advertiser:null, sequence:null, extensions:null, pricing:null },
				{ id:'overlay-5', system:{name:'2.0', version:null}, title:'5748118', impressions:[], creatives:[{ details:nonLinearAds5, adID:null, adIDs:null, sequence:null, id:null, creativeExtensions:null, apiFramework:null}], ids:null, description:null, errors:null, survey:null, advertiser:null, sequence:null, extensions:null, pricing:null },
				{ id:'overlay-6', system:{name:'2.0', version:null}, title:'5750088', impressions:[], creatives:[{ details:nonLinearAds6, adID:null, adIDs:null, sequence:null, id:null, creativeExtensions:null, apiFramework:null}], ids:null, description:null, errors:null, survey:null, advertiser:null, sequence:null, extensions:null, pricing:null },
				{ id:'overlay-7', system:{name:'2.0', version:null}, title:'5700028', impressions:[], creatives:[{ details:nonLinearAds7, adID:null, adIDs:null, sequence:null, id:null, creativeExtensions:null, apiFramework:null}], ids:null, description:null, errors:null, survey:null, advertiser:null, sequence:null, extensions:null, pricing:null },
				{ id:'overlay-8', system:{name:'2.0', version:null}, title:'5750098', impressions:[], creatives:[{ details:nonLinearAds8, adID:null, adIDs:null, sequence:null, id:null, creativeExtensions:null, apiFramework:null}], ids:null, description:null, errors:null, survey:null, advertiser:null, sequence:null, extensions:null, pricing:null },
				{ id:'overlay-9', system:{name:'2.0', version:null}, title:'5750097', impressions:[], creatives:[{ details:nonLinearAds9, adID:null, adIDs:null, sequence:null, id:null, creativeExtensions:null, apiFramework:null}], ids:null, description:null, errors:null, survey:null, advertiser:null, sequence:null, extensions:null, pricing:null },
				{ id:'overlay-10', system:{name:'2.0', version:null}, title:'5700030', impressions:[], creatives:[{ details:nonLinearAds10, adID:null, adIDs:null, sequence:null, id:null, creativeExtensions:null, apiFramework:null}], ids:null, description:null, errors:null, survey:null, advertiser:null, sequence:null, extensions:null, pricing:null },
			],
			error:null
		};
		checkMap('vast', vast, data);
/////////////////////////////////
	}
}