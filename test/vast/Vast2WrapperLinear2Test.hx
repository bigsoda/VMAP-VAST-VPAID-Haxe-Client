package vast;

import vast.TestTypes.VastTestType;
import vast.TestTypes.CreativeDetailLinearTestType;
import vast.TestTypes.CreativeDetailCompanionTestType;
import bs.model.vast.ad.creatives.linear.MediaFile.DeliveryType;
import bs.model.vast.ad.creatives.Tracking.TrackingEvent;
import bs.model.vast.ad.creatives.Resource.ResourceType;
import bs.model.vast.ad.creatives.Click.ClickType;
import bs.model.vast.ad.creatives.MIMEType;
import bs.model.vast.Vast.VastVersion;

import massive.munit.async.AsyncFactory;


class Vast2WrapperLinear2Test extends Tests
{
	public function new() { super(); }

	@AsyncTest
	public function test(factory:AsyncFactory):Void {
		super.vast(factory,'web/examples/vast2/vast_wrapper_linear_2.xml');
	}

	override public function testStart():Void {
		super.testStart();
		//CREATIVE 1/2 - LINEAR
		var linear:CreativeDetailLinearTestType = { duration:30,
			mediaFiles:[{
				delivery:DeliveryType.PROGRESSIVE, type:MIMEType.VIDEO_X_FLV,
				width:400, height:300, url:'http://cdnp.tremormedia.com/video/acudeo/Carrot_400x300_500kb.flv',
				scalable:true, minBitrate:null, maxBitrate:null, maintainAspectRatio:true, id:null, codec:null,
				bitrate:500, apiFramework:null
			}],
			trackingEvents:[
				{ event:TrackingEvent.CREATIVE_VIEW, url:'http://myTrackingURL/creativeView'},
				{ event:TrackingEvent.START, url:'http://myTrackingURL/start'},
				{ event:TrackingEvent.MIDPOINT, url:'http://myTrackingURL/midpoint'},
				{ event:TrackingEvent.FIRST_QUARTILE, url:'http://myTrackingURL/firstQuartile'},
				{ event:TrackingEvent.THIRD_QUARTILE, url:'http://myTrackingURL/thirdQuartile'},
				{ event:TrackingEvent.COMPLETE, url:'http://myTrackingURL/complete'}
			],
			videoClicks:[
				{ id:null, type:ClickType.CLICK_THROUGH, url:'http://www.tremormedia.com'},
				{ id:null, type:ClickType.CLICK_TRACKING, url:'http://myTrackingURL/click'}
			],
			skipoffset:null, icons:null, adParameters:null
		};
		//CREATIVE 2/2 - CompanionAds
		var companionAds:Array<CreativeDetailCompanionTestType> = [
			{ width:300,height:250,
				id:null, adParameters:null, altText:null, assetWidth:null,assetHeight:null,expandedWidth:null,expandedHeight:null,apiFramework:null,adSlotID:null,required:null,
				resources:[{type:ResourceType.STATIC_RESOURCE, creativeType:MIMEType.IMAGE_JPEG, url:"http://demo.tremormedia.com/proddev/vast/Blistex1.jpg"}],
				clicks:[{id:null, type:ClickType.COMPANION_CLICK_THROUGH, url:'http://www.tremormedia.com'}],
				trackingEvents:[{event:TrackingEvent.CREATIVE_VIEW, url:'http://myTrackingURL/firstCompanionCreativeView'}]
			},
			{ width:728,height:90,
				id:null, trackingEvents:null, adParameters:null, altText:null, assetWidth:null, assetHeight:null, expandedWidth:null, expandedHeight:null, apiFramework:null, adSlotID:null, required:null,
				resources:[{ type:ResourceType.STATIC_RESOURCE, creativeType:MIMEType.IMAGE_JPEG, url:"http://demo.tremormedia.com/proddev/vast/728x90_banner1.jpg"}],
				clicks:[{id:null, type:ClickType.COMPANION_CLICK_THROUGH, url:'http://www.tremormedia.com'}]
			}
		];
		/////////////////////////////////
		var vast:VastTestType = { version:VastVersion.v_2_0,
			ads:[{ id:'601364', system:{name:'Acudeo Compatible', version:null}, title:'VAST 2.0 Instream Test 1',
				impressions:[
					{id:null, url:'http://myTrackingURL/impression'},
					{id:null, url:'http://myTrackingURL/wrapper/impression'}
				],
				creatives:[
					{adID:'601364', adIDs:null, details:[linear], sequence:null, id:null, creativeExtensions:null, apiFramework:null },
					{adID:'601364-Companion', adIDs:null, details:companionAds, sequence:null, id:null, creativeExtensions:null, apiFramework:null }
				],
				ids:['602833','601364'], description:'VAST 2.0 Instream Test 1',
				errors:[{url:'http://myErrorURL/error'}],
				advertiser:null, survey:null, sequence:null, extensions:null, pricing:null }],
			error:null
		};
		/////////////////////////////////
		checkMap('vast', vast, data);
		/////////////////////////////////
	}

}