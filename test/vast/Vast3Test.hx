package vast;

import vast.TestTypes.VastTestType;
import vast.TestTypes.TrackingTestType;
import vast.TestTypes.CreativeDetailLinearTestType;
import vast.TestTypes.CreativeDetailCompanionTestType;
import massive.munit.async.AsyncFactory;
import bs.model.vast.Vast.VastVersion;
import bs.model.vast.ad.creatives.MIMEType;
import bs.model.vast.ad.creatives.Click.ClickType;
import bs.model.vast.ad.creatives.Tracking.TrackingEvent;
import bs.model.vast.ad.creatives.linear.MediaFile.DeliveryType;

class Vast3Test extends Tests
{
	public function new() { super(); }
	@AsyncTest
	public function test(factory:AsyncFactory):Void {
		super.vast(factory,'web/examples/vast3/vast3_inline.xml');
	}
	override public function testStart():Void {
		super.testStart();
		var ad1_details:Array<CreativeDetailLinearTestType> = [{
			duration:15,
			mediaFiles:[{
				delivery:DeliveryType.STREAMING,
				type:MIMEType.APPLICATION_X_MPEGURL,
				width:0,
				height:0,
				url:'http://hdadshds-f.akamaihd.net/i/video/campaigns/fox/tmobile/tmo15unlimitedh641080_,130,80,180,340,450,250,50,30,22,15,0.mp4.csmil/master.m3u8',
				scalable:null, minBitrate:null, maxBitrate:null, maintainAspectRatio:null, id:null, codec:null,
				bitrate:null, apiFramework:null
			}],
			trackingEvents:[
				{event:TrackingEvent.COMPLETE,url:'http://g1.v.fwmrm.net/ad/l/1?s=a032&n=164515&t=1366755844262714011&adid=2447226&reid=1698599&arid=0&auid=&cn=complete&et=i&_cc=&tpos=15&init=1&iw=&uxnw=&uxss=&uxct=&metr=121'},
				{event:TrackingEvent.FIRST_QUARTILE,url:'http://g1.v.fwmrm.net/ad/l/1?s=a032&n=164515&t=1366755844262714011&adid=2447226&reid=1698599&arid=0&auid=&cn=firstQuartile&et=i&_cc=&tpos=15&init=1&iw=&uxnw=&uxss=&uxct=&metr=121'},
				{event:TrackingEvent.MIDPOINT,url:'http://g1.v.fwmrm.net/ad/l/1?s=a032&n=164515&t=1366755844262714011&adid=2447226&reid=1698599&arid=0&auid=&cn=midPoint&et=i&_cc=&tpos=15&init=1&iw=&uxnw=&uxss=&uxct=&metr=121'},
				{event:TrackingEvent.THIRD_QUARTILE,url:'http://g1.v.fwmrm.net/ad/l/1?s=a032&n=164515&t=1366755844262714011&adid=2447226&reid=1698599&arid=0&auid=&cn=thirdQuartile&et=i&_cc=&tpos=15&init=1&iw=&uxnw=&uxss=&uxct=&metr=121'}
			],
			videoClicks:[
				{id:'FWc_2447226.0', type:ClickType.CLICK_TRACKING, url:'http://g1.v.fwmrm.net/ad/l/1?s=a032&n=164515&t=1366755844262714011&adid=2447226&reid=1698599&arid=0&auid=&cn=defaultClick&et=c&_cc=&tpos=15&cr='}
			],
			skipoffset:null, icons:null, adParameters:null
		}];
		var ad2_details:Array<CreativeDetailLinearTestType> = [{
			duration:31,
			mediaFiles:[{
				delivery:DeliveryType.STREAMING,
				type:MIMEType.APPLICATION_X_MPEGURL,
				width:0,
				height:0,
				url:'http://hdadshds-f.akamaihd.net/i/video/campaigns/fox/showtime/homelandlookagain30qsbj2330h_,340,450,180,250,130,80,50,30,22,15,0.mp4.csmil/master.m3u8',
				scalable:null, minBitrate:null, maxBitrate:null, maintainAspectRatio:null, id:null, codec:null,
				bitrate:null, apiFramework:null
			}],
			trackingEvents:[
				{event:TrackingEvent.COMPLETE,url:'http://g1.v.fwmrm.net/ad/l/1?s=a032&n=164515&t=1366755844262714011&adid=2447227&reid=1698600&arid=0&auid=&cn=complete&et=i&_cc=&tpos=15&init=1&iw=&uxnw=&uxss=&uxct=&metr=121'},
				{event:TrackingEvent.FIRST_QUARTILE,url:'http://g1.v.fwmrm.net/ad/l/1?s=a032&n=164515&t=1366755844262714011&adid=2447227&reid=1698600&arid=0&auid=&cn=firstQuartile&et=i&_cc=&tpos=15&init=1&iw=&uxnw=&uxss=&uxct=&metr=121'},
				{event:TrackingEvent.MIDPOINT,url:'http://g1.v.fwmrm.net/ad/l/1?s=a032&n=164515&t=1366755844262714011&adid=2447227&reid=1698600&arid=0&auid=&cn=midPoint&et=i&_cc=&tpos=15&init=1&iw=&uxnw=&uxss=&uxct=&metr=121'},
				{event:TrackingEvent.THIRD_QUARTILE,url:'http://g1.v.fwmrm.net/ad/l/1?s=a032&n=164515&t=1366755844262714011&adid=2447227&reid=1698600&arid=0&auid=&cn=thirdQuartile&et=i&_cc=&tpos=15&init=1&iw=&uxnw=&uxss=&uxct=&metr=121'}
			],
			videoClicks:[
				{id:'FWc_2447227.0', type:ClickType.CLICK_TRACKING, url:'http://g1.v.fwmrm.net/ad/l/1?s=a032&n=164515&t=1366755844262714011&adid=2447227&reid=1698600&arid=0&auid=&cn=defaultClick&et=c&_cc=&tpos=15&cr='}
			],
			skipoffset:null, icons:null, adParameters:null
		}];
		var ad3_details:Array<CreativeDetailLinearTestType> = [{
			duration:31,
			mediaFiles:[{
				delivery:DeliveryType.STREAMING,
				type:MIMEType.APPLICATION_X_MPEGURL,
				width:0,
				height:0,
				url:'http://hdadshds-f.akamaihd.net/i/video/campaigns/fx/millercoors/snowparty30enhdns_,340,50,30,22,15,450,180,250,130,80,0.mp4.csmil/master.m3u8',
				scalable:null, minBitrate:null, maxBitrate:null, maintainAspectRatio:null, id:null, codec:null,
				bitrate:null, apiFramework:null
			}],
			trackingEvents:[
				{event:TrackingEvent.COMPLETE,url:'http://g1.v.fwmrm.net/ad/l/1?s=a032&n=164515&t=1366755844262714011&adid=2447228&reid=1698602&arid=0&auid=&cn=complete&et=i&_cc=&tpos=15&init=1&iw=&uxnw=&uxss=&uxct=&metr=121'},
				{event:TrackingEvent.FIRST_QUARTILE,url:'http://g1.v.fwmrm.net/ad/l/1?s=a032&n=164515&t=1366755844262714011&adid=2447228&reid=1698602&arid=0&auid=&cn=firstQuartile&et=i&_cc=&tpos=15&init=1&iw=&uxnw=&uxss=&uxct=&metr=121'},
				{event:TrackingEvent.MIDPOINT,url:'http://g1.v.fwmrm.net/ad/l/1?s=a032&n=164515&t=1366755844262714011&adid=2447228&reid=1698602&arid=0&auid=&cn=midPoint&et=i&_cc=&tpos=15&init=1&iw=&uxnw=&uxss=&uxct=&metr=121'},
				{event:TrackingEvent.THIRD_QUARTILE,url:'http://g1.v.fwmrm.net/ad/l/1?s=a032&n=164515&t=1366755844262714011&adid=2447228&reid=1698602&arid=0&auid=&cn=thirdQuartile&et=i&_cc=&tpos=15&init=1&iw=&uxnw=&uxss=&uxct=&metr=121'}
			],
			videoClicks:[
				{id:'FWc_2447228.0', type:ClickType.CLICK_TRACKING, url:'http://g1.v.fwmrm.net/ad/l/1?s=a032&n=164515&t=1366755844262714011&adid=2447228&reid=1698602&arid=0&auid=&cn=defaultClick&et=c&_cc=&tpos=15&cr='}
			],
			skipoffset:null, icons:null, adParameters:null
		}
		];
		/////////////////////////////////
		var vast:VastTestType = {
			version:VastVersion.v_3_0,
			ads:[{
				id:'2447226.251866656',
				system:{name:'FreeWheel', version:null},
				title:'Ooyla test m3u8 midroll 1',
				impressions:[{id:"FWi_2447226.0", url:'http://g1.v.fwmrm.net/ad/l/1?s=a032&n=164515&t=1366755844262714011&adid=2447226&reid=1698599&arid=0&auid=&cn=defaultImpression&et=i&_cc=&tpos=15&iw=&uxnw=&uxss=&uxct=&metr=121&init=1&_dic=1&cr='}],
				creatives:[{
					adID:'2447226',
					adIDs:null,	sequence:null, id:null, creativeExtensions:null, apiFramework:null,
					details:ad1_details
				}],
				ids:null,
				description:null,
				errors:[
					{url:'http://g1.v.fwmrm.net/ad/l/1?s=a032&n=164515&t=1366755844262714011&adid=2447226&reid=1698599&arid=0&iw=&uxnw=&uxss=&uxct=&et=e&cn=[ERRORCODE]'}
				],
				advertiser:null,
				survey:null,
				sequence:1,
				extensions:null,
				pricing:null
			},
			{id:'2447227.255243472', system:{name:'FreeWheel',version:null}, title:'Ooyla test m3u8 midroll 2',
				impressions:[{id:"FWi_2447227.0", url:'http://g1.v.fwmrm.net/ad/l/1?s=a032&n=164515&t=1366755844262714011&adid=2447227&reid=1698600&arid=0&auid=&cn=defaultImpression&et=i&_cc=&tpos=15&iw=&uxnw=&uxss=&uxct=&metr=121&init=1&_dic=1&cr='}],
				creatives:[{adID:'2447227',details:ad2_details, adIDs:null,	sequence:null, id:null, creativeExtensions:null, apiFramework:null}],
				errors:[ {url:'http://g1.v.fwmrm.net/ad/l/1?s=a032&n=164515&t=1366755844262714011&adid=2447227&reid=1698600&arid=0&iw=&uxnw=&uxss=&uxct=&et=e&cn=[ERRORCODE]'}],
				ids:null, description:null, advertiser:null, survey:null, sequence:2, extensions:null, pricing:null
			},
			{id:'2447228.257609712', system:{name:'FreeWheel',version:null}, title:'Ooyla test m3u8 midroll 3',
				impressions:[{id:"FWi_2447228.0", url:'http://g1.v.fwmrm.net/ad/l/1?s=a032&n=164515&t=1366755844262714011&adid=2447228&reid=1698602&arid=0&auid=&cn=defaultImpression&et=i&_cc=&tpos=15&iw=&uxnw=&uxss=&uxct=&metr=121&init=1&_dic=1&cr='}],
				creatives:[{adID:'2447228', adIDs:null,	sequence:null, id:null, creativeExtensions:null, apiFramework:null, details:ad3_details}],
				errors:[{url:'http://g1.v.fwmrm.net/ad/l/1?s=a032&n=164515&t=1366755844262714011&adid=2447228&reid=1698602&arid=0&iw=&uxnw=&uxss=&uxct=&et=e&cn=[ERRORCODE]'}],
				ids:null,description:null, advertiser:null, survey:null, sequence:3, extensions:null, pricing:null
			}],
			error:null
		};
		checkMap('vast', vast, data);
	}

}