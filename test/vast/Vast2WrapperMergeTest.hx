package vast;

import vast.TestTypes.VastTestType;
import vast.TestTypes.CreativeDetailLinearTestType;
import vast.TestTypes.CreativeDetailCompanionTestType;
import vast.TestTypes.CreativeDetailNonLinearAdsTestType;
import bs.model.vast.ad.creatives.linear.MediaFile.DeliveryType;
import bs.model.vast.ad.creatives.Tracking.TrackingEvent;
import bs.model.vast.ad.creatives.Resource.ResourceType;
import bs.model.vast.ad.creatives.Click.ClickType;
import bs.model.vast.ad.creatives.MIMEType;
import bs.model.vast.Vast.VastVersion;
import massive.munit.async.AsyncFactory;

class Vast2WrapperMergeTest extends Tests
{
	public function new() { super(); }

	@AsyncTest
	public function test(factory:AsyncFactory):Void {
		super.vast(factory,'web/examples/vast2/vastWrapper1.xml');
	}

	override public function testStart():Void {
		super.testStart();
/////////////////////////////////
		var linear:CreativeDetailLinearTestType = {
			duration:30,
			mediaFiles:[{
				delivery:DeliveryType.PROGRESSIVE, type:MIMEType.VIDEO_X_FLV,
				width:400, height:300, url:'http://cdnp.tremormedia.com/video/acudeo/Carrot_400x300_500kb.flv',
				scalable:true, minBitrate:null, maxBitrate:null, maintainAspectRatio:true, id:null, codec:null,
				bitrate:500, apiFramework:null
			}],
			trackingEvents:[
				{event:TrackingEvent.CREATIVE_VIEW, url:'http://inline/Linear/tracking/creative1/1'},
				{event:TrackingEvent.CREATIVE_VIEW, url:'http:///wrapper2/Linear/tracking/creative1/1'},
				{event:TrackingEvent.CREATIVE_VIEW, url:'http://wrapper1/Linear/tracking/creative1/1'}
			],
			videoClicks:[
				{ id:null, type:ClickType.CLICK_THROUGH, url:'http://inline/Linear/videoClick/creative1/clickThrough'},
				{ id:null, type:ClickType.CLICK_THROUGH, url:'http://wrapper1/Linear/videoClick/creative1/clickThrough'},
				{ id:null, type:ClickType.CLICK_TRACKING, url:'http://inline/Linear/videoClick/creative1/clickTracking'},
				{ id:null, type:ClickType.CLICK_TRACKING, url:'http://wrapper1/Linear/videoClick/creative1/clickTracking'}
			],
			skipoffset:null, icons:null, adParameters:null
		};

		var nonLinearAds:CreativeDetailNonLinearAdsTestType = {
			trackingEvents:[{ event:TrackingEvent.CREATIVE_VIEW, url:'http://NonLinearAds/tracking/wrapper1/creative2/1' }],
			//TODO: warn/error on empty nonLinear ??
			nonLinear:[]
		};

		var companionAds:Array<CreativeDetailCompanionTestType> = [{ width:300,height:250,
			id:null, adParameters:null, altText:null, assetWidth:null,assetHeight:null,expandedWidth:null,expandedHeight:null,apiFramework:null,adSlotID:null,required:null,
			resources:[{type:ResourceType.STATIC_RESOURCE, creativeType:MIMEType.IMAGE_JPEG, url:"http://demo.tremormedia.com/proddev/vast/Blistex1.jpg"}],
			clicks:[{id:null, type:ClickType.COMPANION_CLICK_THROUGH, url:'http://www.tremormedia.com'}],
			trackingEvents:[{event:TrackingEvent.CREATIVE_VIEW, url:'http://myTrackingURL/firstCompanionCreativeView'}]
		},{ width:728,height:90,
			id:null, trackingEvents:null, adParameters:null, altText:null, assetWidth:null, assetHeight:null, expandedWidth:null, expandedHeight:null, apiFramework:null, adSlotID:null, required:null,
			resources:[{ type:ResourceType.STATIC_RESOURCE, creativeType:MIMEType.IMAGE_JPEG, url:"http://demo.tremormedia.com/proddev/vast/728x90_banner1.jpg"}],
			clicks:[{id:null, type:ClickType.COMPANION_CLICK_THROUGH, url:'http://www.tremormedia.com'}]
		}];

		var vast:VastTestType = { version:VastVersion.v_2_0,
			ads:[{ id:'inLine', system:{name:'VAST TEST', version:null}, title:'VAST InLine',
				impressions:[
					{id:null, url:'http://myTrackingURL/impression'},
					{id:null, url:'http://myTrackingURL/wrapper/impression'},
					{id:null, url:'http://myTrackingURL/wrapper/impression'}
				],
				creatives:[
					{adID:'inLine.creative1.Linear', adIDs:['inLine.creative1.Linear','wrapper2.creative1.Linear','wrapper1.creative1.Linear'], details:[linear], sequence:null, id:null, creativeExtensions:null, apiFramework:null },
					{adID:'inLine.creative2.CompanionAds', adIDs:null, details:companionAds, sequence:null, id:null, creativeExtensions:null, apiFramework:null },
					{adID:'wrapper1.creative2.NonLinearAds', adIDs:null, details:nonLinearAds, sequence:null, id:null, creativeExtensions:null, apiFramework:null}
				],
				ids:['wrapper1', 'wrapper2','inLine'], description:'VAST TEST',
				errors:[{url:'http://myErrorURL/error'}],
				advertiser:null, survey:null, sequence:null, extensions:null, pricing:null }],
			error:null
		};

		checkMap('vast', vast, data);

	}

}