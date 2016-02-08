package vast;

import bs.model.VastTypes.Vast;
import bs.model.vast.ad.creatives.Tracking.TrackingEvent;
import bs.model.vast.ad.creatives.Resource.ResourceType;
import bs.model.vast.ad.creatives.Click.ClickType;
import bs.model.vast.ad.creatives.MIMEType;
import bs.model.vast.Vast.VastVersion;
import bs.model.VastTypes.CreativeDetailNonLinearAds;
import bs.model.VastTypes.CreativeDetailCompanion;
import massive.munit.async.AsyncFactory;

class Vast2InlineNonLinearTest extends Tests
{
	public function new() { super(); }

	@AsyncTest
	public function test(factory:AsyncFactory):Void {
		super.vast(factory,'web/examples/vast2/vast_inline_nonlinear.xml');
	}
	override public function testStart():Void {
		super.testStart();
/////////////////////////////////
		var nonLinearAds:CreativeDetailNonLinearAds = {
			nonLinear:[{ width:300, height:50, minSuggestedDuration:15,
				id:null, expandedWidth:null, adParameters:null, expandedHeight:null, scalable:null, maintainAspectRatio:null, apiFramework:null,
				resources:[{ type:ResourceType.STATIC_RESOURCE, creativeType:MIMEType.IMAGE_JPEG, url:"http://demo.tremormedia.com/proddev/vast/50x300_static.jpg"}],
				clicks:[{id:null, type:ClickType.NON_LINEAR_CLICK_THROUGH, url:'http://www.tremormedia.com'}]
			},{ width:450, height:50, minSuggestedDuration:20,
				id:null, adParameters:null,expandedWidth:null, expandedHeight:null, scalable:null, maintainAspectRatio:null, apiFramework:null,
				resources:[{type:ResourceType.STATIC_RESOURCE, creativeType:MIMEType.IMAGE_JPEG, url:"http://demo.tremormedia.com/proddev/vast/50x450_static.jpg"}],
				clicks:[{id:null, type:ClickType.NON_LINEAR_CLICK_THROUGH, url:'http://www.tremormedia.com'}]
			}],
			trackingEvents:[
				{ event:TrackingEvent.CREATIVE_VIEW, url:'http://myTrackingURL/nonlinear/creativeView' },
				{ event:TrackingEvent.EXPAND, url:'http://myTrackingURL/nonlinear/expand' },
				{ event:TrackingEvent.COLLAPSE, url:'http://myTrackingURL/nonlinear/collapse' },
				{ event:TrackingEvent.ACCEPT_INVITATION_NONLINEAR, url:'http://myTrackingURL/nonlinear/acceptInvitation' },
				{ event:TrackingEvent.CLOSE_NONLINEAR, url:'http://myTrackingURL/nonlinear/close' }
			]
		};
		var companionAds:Array<CreativeDetailCompanion> = [{ width:300,height:250,
			id:null, trackingEvents:[], adParameters:null, altText:null, assetWidth:null,assetHeight:null,expandedWidth:null,expandedHeight:null,apiFramework:null,adSlotID:null,required:null,
			resources:[{type:ResourceType.STATIC_RESOURCE, creativeType:MIMEType.APPLICATION_X_SHOCKWAVE_FLASH, url:"http://demo.tremormedia.com/proddev/vast/300x250_companion_1.swf"}],
			clicks:[{id:null, type:ClickType.COMPANION_CLICK_THROUGH, url:'http://www.tremormedia.com'}]
		},{ width:728,height:90,
			id:null, adParameters:null, altText:null, assetWidth:null, assetHeight:null, expandedWidth:null, expandedHeight:null, apiFramework:null,adSlotID:null,required:null,
			resources:[{ type:ResourceType.STATIC_RESOURCE, creativeType:MIMEType.IMAGE_JPEG, url:"http://demo.tremormedia.com/proddev/vast/728x90_banner1.jpg"}],
			clicks:[{id:null, type:ClickType.COMPANION_CLICK_THROUGH, url:'http://www.tremormedia.com'}],
			trackingEvents:[{ event:TrackingEvent.CREATIVE_VIEW, url:'http://myTrackingURL/secondCompanion' }]
		}];

		var vast:Vast = {
			version:VastVersion.v_2_0,
			ads:[{ id:'602678', system:{name:'Acudeo Compatible', version:null}, title:'NonLinear Test Campaign 1',
				impressions:[{id:null, url:'http://myTrackingURL/impression'}],
				creatives:[
					{ adID:'602678-NonLinear', details:nonLinearAds, adIDs:null, sequence:null, id:null, creativeExtensions:null, apiFramework:null},
					{ adID:'602678-Companion', details:companionAds, adIDs:null, sequence:null, id:null, creativeExtensions:null, apiFramework:null}
				],
				ids:['602867','602678'], description:'NonLinear Test Campaign 1', errors:[{url:'http://myErrorURL/error'}],
				survey:'http://mySurveyURL/survey', advertiser:null, sequence:null, extensions:null, pricing:null
			}],
			error:null
		};
		checkMap('vast', vast, data);
	}
}