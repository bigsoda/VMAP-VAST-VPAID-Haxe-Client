package vast;

import bs.model.VastTypes.Vast;
import bs.model.VastTypes.RequiredType;
import bs.model.VastTypes.ResourceType;
import bs.model.VastTypes.ClickType;
import bs.model.VastTypes.Tracking;
import bs.model.VastTypes.TrackingEvent;
import bs.model.VastTypes.MIMEType;
import bs.model.VastTypes.DeliveryType;
import bs.model.VastTypes.CreativeDetailLinear;
import bs.model.VastTypes.CreativeDetailCompanion;
import bs.model.VastTypes.VastVersion;
import massive.munit.async.AsyncFactory;


class Vast2RegularLinearTest extends Tests
{
	public function new() { super(); }

	@AsyncTest
	public function test(factory:AsyncFactory):Void {
		super.vast(factory,'web/examples/vast2/vast2RegularLinear.xml');
	}
	override public function testStart():Void {
		super.testStart();
/////////////////////////////////
//CREATIVE 1/2 - LINEAR
		var linear:CreativeDetailLinear = { duration:30,
			mediaFiles:[{delivery:DeliveryType.PROGRESSIVE, type:MIMEType.VIDEO_X_FLV,
				width:600, height:396, url:'http://media.scanscout.com/ads/partner1_a1d1fbbc-c4d4-419f-b6c8-e9db63fd4491.flv',
				scalable:true, minBitrate:null, maxBitrate:null, maintainAspectRatio:true, id:null, codec:null,
				bitrate:496, apiFramework:null
			}],
			trackingEvents:[],
			videoClicks:[{id:'scanscout', type:ClickType.CLICK_THROUGH, url:'http://www.target.com'}],
			skipoffset:null, icons:null, adParameters:null
		};
//CREATIVE 2/2 - CompanionAds
		var companions:CreativeDetailCompanion = { width:300, height:250, id:'555750', clicks:[],
			adParameters:null, altText:null, assetWidth:null, assetHeight:null, expandedWidth:null, expandedHeight:null, apiFramework:null, adSlotID:null, required:null, trackingEvents:null,
			resources:[{type:ResourceType.HTML_RESOURCE, data:'<A onClick="var i= new Image(1,1); i.src=\'http://app.scanscout.com/ssframework/log/log.png?a=logitemaction&RI=555750&CbC=1&CbF=true&EC=0&RC=0&SmC=2&CbM=1.0E-5&VI=736e6b13bad531dc476bc3612749bc35&admode=preroll&PRI=-4827170214961170629&RprC=0&ADsn=17&VcaI=192,197&RrC=1&VgI=736e6b13bad531dc476bc3612749bc35&AVI=142&Ust=ma&Uctry=us&CI=1223187&AC=4&PI=567&Udma=506&ADI=5748406&VclF=true\';" HREF="http://target.com" target="_blank"><IMG SRC="http://media.scanscout.com/ads/target300x250Companion.jpg" BORDER=0 WIDTH=300 HEIGHT=250 ALT="Click Here"></A><img src="http://app.scanscout.com/ssframework/log/log.png?a=logitemaction&RI=555750&CbC=1&CbF=true&EC=1&RC=0&SmC=2&CbM=1.0E-5&VI=736e6b13bad531dc476bc3612749bc35&admode=preroll&PRI=-4827170214961170629&RprC=0&ADsn=17&VcaI=192,197&RrC=1&VgI=736e6b13bad531dc476bc3612749bc35&AVI=142&Ust=ma&Uctry=us&CI=1223187&AC=4&PI=567&Udma=506&ADI=5748406&VclF=true" height="1" width="1">'}]
		};
		var vast:Vast = {
			version:VastVersion.v_2_0,
			ads:[{ id:'preroll-1', system:{name:'2.0', version:null}, title:'5748406',
				impressions:[ {id:"blah", url:'http://b.scorecardresearch.com/b?C1=1&C2=6000003&C3=0000000200500000197000000&C4=us&C7=http://www.scanscout.com&C8=scanscout.com&C9=http://www.scanscout.com&C10=xn&rn=-103217130'}],
				creatives:[
					{ adID:'601364', details:[linear], adIDs:['601364','602833'], sequence:null, id:null, creativeExtensions:null, apiFramework:null},
					{ adID:'555750', details:[companions], adIDs:null, sequence:null, id:null, creativeExtensions:null, apiFramework:null}
				],
				ids:['602833','601364'], description:'VAST 2.0 Instream Test 1',
				errors:[{url:'http://myErrorURL/error'},{url:'http://myErrorURL/wrapper/error'}],
				survey:'http://mySurveyURL/survey', advertiser:null, sequence:null, extensions:null, pricing:null
			}],
			error:null
		};
		checkMap('vast', vast, data);
/////////////////////////////////
	}
}