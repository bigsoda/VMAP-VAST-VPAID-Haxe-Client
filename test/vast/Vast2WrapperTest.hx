package vast;

import haxe.xml.Fast;
import vast.TestTypes.VastTestType;
import vast.TestTypes.CreativeDetailLinearTestType;
import bs.model.vast.ad.creatives.linear.MediaFile.DeliveryType;
import bs.model.vast.ad.creatives.Tracking.TrackingEvent;
import bs.model.vast.ad.creatives.Click.ClickType;
import bs.model.vast.ad.creatives.MIMEType;
import bs.model.vast.Vast.VastVersion;
import massive.munit.async.AsyncFactory;


class Vast2WrapperTest extends Tests
{
	public function new() { super(); }

	@AsyncTest
	public function test(factory:AsyncFactory):Void {
		super.vast(factory,'web/examples/vast2/1a.xml');
	}

	override public function testStart():Void {
		super.testStart();
		/////////////////////////////////
		var details:Array<CreativeDetailLinearTestType> = [{
			duration:15,
			mediaFiles:[{
				delivery:DeliveryType.PROGRESSIVE,
				type:MIMEType.VIDEO_MP4,
				width:480,
				height:272,
				url:'http://cdn.adap.tv/integration_test/adaptv_logo_test_ad-092412105734313-20344.mp4',
				scalable:null, minBitrate:null, maxBitrate:null, maintainAspectRatio:null, id:null, codec:null,
				bitrate:500, apiFramework:null
			}],
			trackingEvents:[
				{event:TrackingEvent.START,url:'http://log.adaptv.advertising.com/log?3a=progressDisplay0&eb=&25=60076&5=115439&14=&2=115440&37=113540&a=&65=preroll&6a=-2&6b=-2&4f=&3=-2&c=&5c=alexorlovstestpublisher&5b=&18=14168&2e=test.com&2f=&30=test.com&31=&32=1&fd=&90=&86=&83=&82=&af=&80=4223934359608602170&f8=TAe086247a-f26a-11e4-aefd-00163e1c8bbf&42=false&8f=&41=&21=&1b=&76=&77=506081623&67=&d6=e8a2c373-d849-479e-9a9b-9cee6f808b10&bf=0&74=ah&ed=&d5=1&d8=ip-10-49-139-133&ae=&8e=-1&f0=-1&68=-1&d7=&c0=&c4=0&c5=0&91=ONLINE_VIDEO&45=217.67.220.38&ee=Windows+7&b5=-1&33=74443721&a.pub_id=&f3=&f1=&f2=&a.cv=1'},
				{event:TrackingEvent.FIRST_QUARTILE,url:'http://log.adaptv.advertising.com/log?3a=progressDisplay25&eb=&25=60076&5=115439&14=&2=115440&37=113540&a=&65=preroll&6a=-2&6b=-2&4f=&3=-2&c=&5c=alexorlovstestpublisher&5b=&18=14168&2e=test.com&2f=&30=test.com&31=&32=1&fd=&90=&86=&83=&82=&af=&80=4223934359608602170&f8=TAe086247a-f26a-11e4-aefd-00163e1c8bbf&42=false&8f=&41=&21=&1b=&76=&77=506081623&67=&d6=e8a2c373-d849-479e-9a9b-9cee6f808b10&bf=0&74=ah&ed=&d5=1&d8=ip-10-49-139-133&ae=&8e=-1&f0=-1&68=-1&d7=&c0=&c4=0&c5=0&91=ONLINE_VIDEO&45=217.67.220.38&ee=Windows+7&b5=-1&33=74443721&a.pub_id=&f3=&f1=&f2=&a.cv=1'},
				{event:TrackingEvent.MIDPOINT,url:'http://log.adaptv.advertising.com/log?3a=progressDisplay50&eb=&25=60076&5=115439&14=&2=115440&37=113540&a=&65=preroll&6a=-2&6b=-2&4f=&3=-2&c=&5c=alexorlovstestpublisher&5b=&18=14168&2e=test.com&2f=&30=test.com&31=&32=1&fd=&90=&86=&83=&82=&af=&80=4223934359608602170&f8=TAe086247a-f26a-11e4-aefd-00163e1c8bbf&42=false&8f=&41=&21=&1b=&76=&77=506081623&67=&d6=e8a2c373-d849-479e-9a9b-9cee6f808b10&bf=0&74=ah&ed=&d5=1&d8=ip-10-49-139-133&ae=&8e=-1&f0=-1&68=-1&d7=&c0=&c4=0&c5=0&91=ONLINE_VIDEO&45=217.67.220.38&ee=Windows+7&b5=-1&33=74443721&a.pub_id=&f3=&f1=&f2=&a.cv=1'},
				{event:TrackingEvent.THIRD_QUARTILE,url:'http://log.adaptv.advertising.com/log?3a=progressDisplay75&eb=&25=60076&5=115439&14=&2=115440&37=113540&a=&65=preroll&6a=-2&6b=-2&4f=&3=-2&c=&5c=alexorlovstestpublisher&5b=&18=14168&2e=test.com&2f=&30=test.com&31=&32=1&fd=&90=&86=&83=&82=&af=&80=4223934359608602170&f8=TAe086247a-f26a-11e4-aefd-00163e1c8bbf&42=false&8f=&41=&21=&1b=&76=&77=506081623&67=&d6=e8a2c373-d849-479e-9a9b-9cee6f808b10&bf=0&74=ah&ed=&d5=1&d8=ip-10-49-139-133&ae=&8e=-1&f0=-1&68=-1&d7=&c0=&c4=0&c5=0&91=ONLINE_VIDEO&45=217.67.220.38&ee=Windows+7&b5=-1&33=74443721&a.pub_id=&f3=&f1=&f2=&a.cv=1'},
				{event:TrackingEvent.COMPLETE,url:'http://log.adaptv.advertising.com/log?3a=progressDisplay100&eb=&25=60076&5=115439&14=&2=115440&37=113540&a=&65=preroll&6a=-2&6b=-2&4f=&3=-2&c=&5c=alexorlovstestpublisher&5b=&18=14168&2e=test.com&2f=&30=test.com&31=&32=1&fd=&90=&86=&83=&82=&af=&80=4223934359608602170&f8=TAe086247a-f26a-11e4-aefd-00163e1c8bbf&42=false&8f=&41=&21=&1b=&76=&77=506081623&67=&d6=e8a2c373-d849-479e-9a9b-9cee6f808b10&bf=0&74=ah&ed=&d5=1&d8=ip-10-49-139-133&ae=&8e=-1&f0=-1&68=-1&d7=&c0=&c4=0&c5=0&91=ONLINE_VIDEO&45=217.67.220.38&ee=Windows+7&b5=-1&33=74443721&a.pub_id=&f3=&f1=&f2=&a.cv=1'},
				{event:TrackingEvent.ACCEPT_INVITATION_NONLINEAR,url:'http://log.adaptv.advertising.com/log?event=acceptInvitation&creativeId=60076&adSourceId=115439&bidId=&afppId=115440&exSId=113540&adSpotId=&pet=preroll&pod=-2&position=-2&marketplaceId=&adPlanId=-2&adaptag=&key=alexorlovstestpublisher&buyerId=&campaignId=14168&pageUrl=test.com&adapDetD=&sellRepD=test.com&urlDetMeth=&targDSellRep=1&mediaId=&zid=&url=&id=&duration=&a.geostrings=&uid=4223934359608602170&apid=TAe086247a-f26a-11e4-aefd-00163e1c8bbf&htmlEnabled=false&width=&height=&context=&categories=&sessionId=&serverRev=506081623&playerRev=&a.rid=e8a2c373-d849-479e-9a9b-9cee6f808b10&a.cluster=0&rtype=ah&ext_id=&a.ssc=1&a.asn=ip-10-49-139-133&a.profile_id=&p.vw.viewable=-1&p.vw.viewableOpportunity=-1&p.vw.psize=-1&a.sdk=&a.sdkType=&a.appReq=0&a.sscCap=0&a.platformDevice=ONLINE_VIDEO&ipAddressOverride=217.67.220.38&a.platformOs=Windows+7&p.vw.active=-1&eov=74443721&a.pub_id=&a.aid=&a.idfa=&a.idfa_md5='},
				{event:TrackingEvent.PAUSE,url:'http://log.adaptv.advertising.com/log?event=paused&creativeId=60076&adSourceId=115439&bidId=&afppId=115440&exSId=113540&adSpotId=&pet=preroll&pod=-2&position=-2&marketplaceId=&adPlanId=-2&adaptag=&key=alexorlovstestpublisher&buyerId=&campaignId=14168&pageUrl=test.com&adapDetD=&sellRepD=test.com&urlDetMeth=&targDSellRep=1&mediaId=&zid=&url=&id=&duration=&a.geostrings=&uid=4223934359608602170&apid=TAe086247a-f26a-11e4-aefd-00163e1c8bbf&htmlEnabled=false&width=&height=&context=&categories=&sessionId=&serverRev=506081623&playerRev=&a.rid=e8a2c373-d849-479e-9a9b-9cee6f808b10&a.cluster=0&rtype=ah&ext_id=&a.ssc=1&a.asn=ip-10-49-139-133&a.profile_id=&p.vw.viewable=-1&p.vw.viewableOpportunity=-1&p.vw.psize=-1&a.sdk=&a.sdkType=&a.appReq=0&a.sscCap=0&a.platformDevice=ONLINE_VIDEO&ipAddressOverride=217.67.220.38&a.platformOs=Windows+7&p.vw.active=-1&eov=74443721&a.pub_id=&a.aid=&a.idfa=&a.idfa_md5='},
				{event:TrackingEvent.RESUME,url:'http://log.adaptv.advertising.com/log?event=playing&creativeId=60076&adSourceId=115439&bidId=&afppId=115440&exSId=113540&adSpotId=&pet=preroll&pod=-2&position=-2&marketplaceId=&adPlanId=-2&adaptag=&key=alexorlovstestpublisher&buyerId=&campaignId=14168&pageUrl=test.com&adapDetD=&sellRepD=test.com&urlDetMeth=&targDSellRep=1&mediaId=&zid=&url=&id=&duration=&a.geostrings=&uid=4223934359608602170&apid=TAe086247a-f26a-11e4-aefd-00163e1c8bbf&htmlEnabled=false&width=&height=&context=&categories=&sessionId=&serverRev=506081623&playerRev=&a.rid=e8a2c373-d849-479e-9a9b-9cee6f808b10&a.cluster=0&rtype=ah&ext_id=&a.ssc=1&a.asn=ip-10-49-139-133&a.profile_id=&p.vw.viewable=-1&p.vw.viewableOpportunity=-1&p.vw.psize=-1&a.sdk=&a.sdkType=&a.appReq=0&a.sscCap=0&a.platformDevice=ONLINE_VIDEO&ipAddressOverride=217.67.220.38&a.platformOs=Windows+7&p.vw.active=-1&eov=74443721&a.pub_id=&a.aid=&a.idfa=&a.idfa_md5='},
				{event:TrackingEvent.MIDPOINT,url:'http://konnect-test.videoplaza.tv/proxy/tracker/v2?aid=e529f14a-6d86-4905-896f-1410901d5dad&cf=short_form&dcid=911d9b52-dbf6-407d-915c-1499a49b8b09&e=16&pid=f3997825-9112-41ea-a91b-2db354dcff0d&s=mobile&t=VP10-mobile&tid=4082e5c7-0e79-11e5-bd51-002590e81073&tt=p'},
				{event:TrackingEvent.COMPLETE,url:'http://konnect-test.videoplaza.tv/proxy/tracker/v2?aid=e529f14a-6d86-4905-896f-1410901d5dad&cf=short_form&dcid=911d9b52-dbf6-407d-915c-1499a49b8b09&e=18&pid=f3997825-9112-41ea-a91b-2db354dcff0d&s=mobile&t=VP10-mobile&tid=4082e5c7-0e79-11e5-bd51-002590e81073&tt=p'},
				{event:TrackingEvent.START,url:'http://konnect-test.videoplaza.tv/proxy/tracker/v2?aid=e529f14a-6d86-4905-896f-1410901d5dad&cf=short_form&dcid=911d9b52-dbf6-407d-915c-1499a49b8b09&e=14&pid=f3997825-9112-41ea-a91b-2db354dcff0d&s=mobile&t=VP10-mobile&tid=4082e5c7-0e79-11e5-bd51-002590e81073&tt=p'},
				{event:TrackingEvent.FIRST_QUARTILE,url:'http://konnect-test.videoplaza.tv/proxy/tracker/v2?aid=e529f14a-6d86-4905-896f-1410901d5dad&cf=short_form&dcid=911d9b52-dbf6-407d-915c-1499a49b8b09&e=15&pid=f3997825-9112-41ea-a91b-2db354dcff0d&s=mobile&t=VP10-mobile&tid=4082e5c7-0e79-11e5-bd51-002590e81073&tt=p'},
				{event:TrackingEvent.CLOSE_NONLINEAR,url:'http://konnect-test.videoplaza.tv/proxy/tracker/v2?aid=e529f14a-6d86-4905-896f-1410901d5dad&cf=short_form&dcid=911d9b52-dbf6-407d-915c-1499a49b8b09&e=7&pid=f3997825-9112-41ea-a91b-2db354dcff0d&s=mobile&t=VP10-mobile&tid=4082e5c7-0e79-11e5-bd51-002590e81073&tt=p'},
				{event:TrackingEvent.THIRD_QUARTILE,url:'http://konnect-test.videoplaza.tv/proxy/tracker/v2?aid=e529f14a-6d86-4905-896f-1410901d5dad&cf=short_form&dcid=911d9b52-dbf6-407d-915c-1499a49b8b09&e=17&pid=f3997825-9112-41ea-a91b-2db354dcff0d&s=mobile&t=VP10-mobile&tid=4082e5c7-0e79-11e5-bd51-002590e81073&tt=p'},
				{event:TrackingEvent.COMPLETE,url:'http://ac.eu.angsrvr.com/count?type=complete&crea=2306&ite=1877&cpg=596&adv=1979&plc=1013189&sit=102875&pub=2232&iid=b94b8929-ee7c-4f10-989d-a175ff7f5b4f&ep=1433834938&url=http://angsrvr.r.worldssl.net/img/trpx.gif'},
				{event:TrackingEvent.FIRST_QUARTILE,url:'http://ac.eu.angsrvr.com/count?type=firstQuartile&crea=2306&ite=1877&cpg=596&adv=1979&plc=1013189&sit=102875&pub=2232&iid=b94b8929-ee7c-4f10-989d-a175ff7f5b4f&ep=1433834938&url=http://angsrvr.r.worldssl.net/img/trpx.gif'},
				{event:TrackingEvent.MIDPOINT,url:'http://ac.eu.angsrvr.com/count?type=midpoint&crea=2306&ite=1877&cpg=596&adv=1979&plc=1013189&sit=102875&pub=2232&iid=b94b8929-ee7c-4f10-989d-a175ff7f5b4f&ep=1433834938&url=http://angsrvr.r.worldssl.net/img/trpx.gif'},
				{event:TrackingEvent.MUTE,url:'http://ac.eu.angsrvr.com/count?type=mute&crea=2306&ite=1877&cpg=596&adv=1979&plc=1013189&sit=102875&pub=2232&iid=b94b8929-ee7c-4f10-989d-a175ff7f5b4f&ep=1433834938&url=http://angsrvr.r.worldssl.net/img/trpx.gif'},
				{event:TrackingEvent.PAUSE,url:'http://ac.eu.angsrvr.com/count?type=pause&crea=2306&ite=1877&cpg=596&adv=1979&plc=1013189&sit=102875&pub=2232&iid=b94b8929-ee7c-4f10-989d-a175ff7f5b4f&ep=1433834938&url=http://angsrvr.r.worldssl.net/img/trpx.gif'},
				{event:TrackingEvent.START,url:'http://ac.eu.angsrvr.com/count?type=start&crea=2306&ite=1877&cpg=596&adv=1979&plc=1013189&sit=102875&pub=2232&iid=b94b8929-ee7c-4f10-989d-a175ff7f5b4f&ep=1433834938&url=http://angsrvr.r.worldssl.net/img/trpx.gif'},
				{event:TrackingEvent.THIRD_QUARTILE,url:'http://ac.eu.angsrvr.com/count?type=thirdQuartile&crea=2306&ite=1877&cpg=596&adv=1979&plc=1013189&sit=102875&pub=2232&iid=b94b8929-ee7c-4f10-989d-a175ff7f5b4f&ep=1433834938&url=http://angsrvr.r.worldssl.net/img/trpx.gif'},
				{event:TrackingEvent.UNMUTE,url:'http://ac.eu.angsrvr.com/count?type=unmute&crea=2306&ite=1877&cpg=596&adv=1979&plc=1013189&sit=102875&pub=2232&iid=b94b8929-ee7c-4f10-989d-a175ff7f5b4f&ep=1433834938&url=http://angsrvr.r.worldssl.net/img/trpx.gif'}
			],
			videoClicks:[
				{id:null, type:ClickType.CLICK_THROUGH, url:'http://log.adaptv.advertising.com/log?3a=click&eb=&d3=&25=60076&6c=&5=115439&14=&2=115440&37=113540&a=&65=preroll&6a=-2&6b=-2&4f=&3=-2&c=&5c=alexorlovstestpublisher&5b=&18=14168&2e=test.com&2f=&30=test.com&31=&32=1&fd=&90=&86=&83=&82=&af=&80=4223934359608602170&f8=TAe086247a-f26a-11e4-aefd-00163e1c8bbf&42=false&8f=&41=&21=&1b=&76=&77=506081623&67=&d6=e8a2c373-d849-479e-9a9b-9cee6f808b10&bf=0&74=ah&ed=&d5=1&d8=ip-10-49-139-133&ae=&8e=-1&f0=-1&68=-1&d7=&c0=&c4=0&c5=0&91=ONLINE_VIDEO&45=217.67.220.38&ee=Windows+7&b5=-1&33=74443721&a.pub_id=&f3=&f1=&f2=&a.cv=1&rUrl=http%3A%2F%2Fwww.adap.tv%2F'},
				{id:null, type:ClickType.CLICK_TRACKING, url:'http://conversions.adaptv.advertising.com/conversion/wc?adSourceId=115439&bidId=&afppId=115440&creativeId=60076&exSId=113540&marketplaceId=&key=alexorlovstestpublisher&a.pvt=0&a.rid=e8a2c373-d849-479e-9a9b-9cee6f808b10&a.pub_id=&eov=74443721&a.click=true'},
				{id:null, type:ClickType.CLICK_TRACKING, url:'http://konnect-test.videoplaza.tv/proxy/tracker/v2?aid=e529f14a-6d86-4905-896f-1410901d5dad&cf=short_form&dcid=911d9b52-dbf6-407d-915c-1499a49b8b09&e=20&pid=f3997825-9112-41ea-a91b-2db354dcff0d&s=mobile&t=VP10-mobile&tid=4082e5c7-0e79-11e5-bd51-002590e81073&tt=p'},
				{id:'ang', type:ClickType.CLICK_TRACKING, url:'http://ac.eu.angsrvr.com/count?type=cli&crea=2306&ite=1877&cpg=596&adv=1979&plc=1013189&sit=102875&pub=2232&iid=b94b8929-ee7c-4f10-989d-a175ff7f5b4f&ep=1433834938&url=http://angsrvr.r.worldssl.net/img/trpx.gif'}
			],
			skipoffset:null, icons:null,
			adParameters:{
				xmlEncoded:null,
				id:'adaptv',
				data:'cd=%7B%22skipAdEnabled%22%3Afalse%2C%22adTagUrl%22%3A%22http%3A%2F%2Fads.adaptv.advertising.com%2Fcreative%3FcreativeId%3D60076%26a.pvt%3D0%26companionId%3D%26key%3Dalexorlovstestpublisher%26pet%3Dpreroll%26sellerDealId%3D%7BsellerDealId%7D%26width%3D%26height%3D%26url%3D%7Burl%7D%26uid%3D4223934359608602170%26apid%3DTAe086247a-f26a-11e4-aefd-00163e1c8bbf%26serverRev%3D506081623%26a.rid%3De8a2c373-d849-479e-9a9b-9cee6f808b10%26id%3D%26a.cluster%3D0%26rtype%3Dah%26ext_id%3D%26a.asn%3Dip-10-49-139-133%26a.sdk%3D%7Ba.sdk%7D%26a.sdkType%3D%7Ba.sdkType%7D%26a.appReq%3D0%26a.sscCap%3D0%26a.platformDevice%3DONLINE_VIDEO%26ipAddressOverride%3D217.67.220.38%26a.platformOs%3DWindows%2B7%26categories%3D%26zid%3D%7Bzid%7D%26title%3D%7Btitle%7D%26description%3D%7Bdescription%7D%26keywords%3D%7Bkeywords%7D%26context%3D%26p.vw.viewable%3D-1%26p.vw.viewableOpportunity%3D-1%26p.vw.psize%3D-1%26p.vw.active%3D-1%26a.aid%3D%7Baid%7D%26a.idfa%3D%26a.idfa_md5%3D%26a.geostrings%3D%26adtemplId%3D5%26adSourceId%3D115439%26adName%3DMP4%2BTest%253AWrapper%26campaignName%3DAll%2Btest%2Bads%26campaignId%3D14168%26uniques%3D%26buyerId%3D%7BbuyerId%7D%26pageUrl%3Dtest.com%26adapDetD%3D%7BadapDetD%7D%26sellRepD%3Dtest.com%26urlDetMeth%3D%26targDSellRep%3D1%26mediaId%3D%7BmediaId%7D%26bidId%3D%7BbidId%7D%26afppId%3D115440%26exSId%3D113540%26marketplaceId%3D%7BmarketplaceId%7D%26sellMarketplaceIds%3D%7BsellMarketplaceIds%7D%26sellerDealId%3D%7BsellerDealId%7D%26buyerDealId%3D%7BbuyerDealId%7D%26a.ma%3D%7Ba.ma%7D%26dataCost%3DqUsI3M4M68M_%26serviceFeeIds%3DoOt0lqLFswM_%26serviceFeeWeights%3DoOt0lqLFswM_%26pricingInfo%3D%7BpricingInfo%7D%26mrp%3DtOOhqVpKiIKzEXyKyh4SWr3aX09g7Q3-%26mtp%3DZX4madbHHCc_%26mtsp%3DtOOhqVpKiIKzEXyKyh4SWr3aX09g7Q3-%26a.profile_id%3D%7Ba.profile_id%7D%26placementId%3D115439%26a.att1%3D0%26ix_attributeId%3D%7Bix_attributeId%7D%26a.pub_id%3D%26a.skip%3D0%26aud_demo_in_target%3D%26cb%3D74443721%22%2C%22startMuted%22%3Afalse%2C%22muteButtonEnabled%22%3Afalse%2C%22companionId%22%3Anull%2C%22countdownText%22%3A%22Ad+will+end+in+__SECONDS__+seconds%22%7D'
			}
		}];
		var vast:VastTestType = {
			version:VastVersion.v_2_0,
			ads:[{
				id:'a115440',
				system:{name:'Adap.tv', version:'1.0'},
				title:'Adap.tv Ad Unit',
				impressions:[
					{id:null, url:'http://pskolysz.techxstream.com/test/ebtv/vmap/impression.php?server=4a'},
					{id:null, url:'http://pskolysz.techxstream.com/test/ebtv/vmap/impression.php?server=4b'},
					{id:null, url:'http://pskolysz.techxstream.com/test/ebtv/vmap/impression.php?server=3'},
					{id:'ang', url:'http://ac.eu.angsrvr.com/count?type=imp&crea=2306&ite=1877&cpg=596&adv=1979&plc=1013189&sit=102875&pub=2232&iid=b94b8929-ee7c-4f10-989d-a175ff7f5b4f&ep=1433834938&pac=1&url=http://angsrvr.r.worldssl.net/img/trpx.gif'},
					{id:'psync', url:'http://pskolysz.techxstream.com/test/ebtv/vmap/impression.php?server=2a'},
					{id:'psync', url:'http://pskolysz.techxstream.com/test/ebtv/vmap/impression.php?server=2b'},
					{id:'psync', url:'http://pskolysz.techxstream.com/test/ebtv/vmap/impression.php?server=2c'},
					{id:'psync', url:'http://pskolysz.techxstream.com/test/ebtv/vmap/impression.php?server=2d'},
					{id:'psync', url:'http://pskolysz.techxstream.com/test/ebtv/vmap/impression.php?server=2e'},
					{id:'psync', url:'http://pskolysz.techxstream.com/test/ebtv/vmap/impression.php?server=2f'},
					{id:'psync', url:'http://pskolysz.techxstream.com/test/ebtv/vmap/impression.php?server=2g'},
					{id:'psync', url:'http://pskolysz.techxstream.com/test/ebtv/vmap/impression.php?server=2h'},
					{id:'psync', url:'http://pskolysz.techxstream.com/test/ebtv/vmap/impression.php?server=2i'}
				],
				creatives:[{
					adID:'2447226', adIDs:['undefined','undefined','2306'],
					sequence:null, id:null, creativeExtensions:null, apiFramework:null,
					details:details
				}],
				ids:['2306','e529f14a-6d86-4905-896f-1410901d5dad','a115440'],
				description:null,
				errors:[
					{url:'http://log.adaptv.advertising.com/log?event=error&sellerDealId=&lastBid=&errNo=&pricingInfo=&nF=&adSourceId=115439&bidId=&afppId=115440&exSId=113540&adSpotId=&pet=preroll&pod=-2&position=-2&marketplaceId=&adPlanId=-2&adaptag=&key=alexorlovstestpublisher&buyerId=&campaignId=14168&pageUrl=test.com&adapDetD=&sellRepD=test.com&urlDetMeth=&targDSellRep=1&mediaId=&zid=&url=&id=&duration=&a.geostrings=&uid=4223934359608602170&apid=TAe086247a-f26a-11e4-aefd-00163e1c8bbf&htmlEnabled=false&width=&height=&context=&categories=&sessionId=&serverRev=506081623&playerRev=&a.rid=e8a2c373-d849-479e-9a9b-9cee6f808b10&a.cluster=0&rtype=ah&ext_id=&a.ssc=1&a.asn=ip-10-49-139-133&a.profile_id=&p.vw.viewable=-1&p.vw.viewableOpportunity=-1&p.vw.psize=-1&a.sdk=&a.sdkType=&a.appReq=0&a.sscCap=0&a.platformDevice=ONLINE_VIDEO&ipAddressOverride=217.67.220.38&a.platformOs=Windows+7&p.vw.active=-1&eov=74443721&a.pub_id=&a.aid=&a.idfa=&a.idfa_md5=&app_storeurl_available=0&app_bundle=&location_available=0'},
					{url:'http://konnect-test.videoplaza.tv/proxy/tracker/v2?aid=0&cf=short_form&dcid=911d9b52-dbf6-407d-915c-1499a49b8b09&e=0&pid=f3997825-9112-41ea-a91b-2db354dcff0d&s=mobile&t=VP10-mobile&tid=4082e5c7-0e79-11e5-bd51-002590e81073&tt=p&ua=%5Bua%5D&uc=%5Buc%5D'},
					{url:'http://ac.eu.angsrvr.com/count?type=vasterr&crea=2306&ite=1877&cpg=596&adv=1979&plc=1013189&sit=102875&pub=2232&iid=b94b8929-ee7c-4f10-989d-a175ff7f5b4f&ep=1433834938&subtype=[ERRORCODE]&url=http://angsrvr.r.worldssl.net/img/trpx.gif'}
				],
				extensions:[
					new Fast(Xml.parse('<Extension type="OneSource creative"><CreativeId><![CDATA[60076]]></CreativeId></Extension>')),
					new Fast(Xml.parse('<Extension type="revenue" currency="USD"><![CDATA[ZP05nQqNNzkDnlnN9D9Qjg==]]></Extension>')),
					new Fast(Xml.parse('<Extension type="adaptv_iab_viewable_beacons"><Beacon type="iab_viewable"><![CDATA[http://log.adaptv.advertising.com/log?event=iabViewable&creativeId=60076&adSourceId=115439&bidId=&afppId=115440&exSId=113540&adSpotId=&pet=preroll&pod=-2&position=-2&marketplaceId=&adPlanId=-2&adaptag=&key=alexorlovstestpublisher&buyerId=&campaignId=14168&pageUrl=test.com&adapDetD=&sellRepD=test.com&urlDetMeth=&targDSellRep=1&mediaId=&zid=&url=&id=&duration=&a.geostrings=&uid=4223934359608602170&apid=TAe086247a-f26a-11e4-aefd-00163e1c8bbf&htmlEnabled=false&width=&height=&context=&categories=&sessionId=&serverRev=506081623&playerRev=&a.rid=e8a2c373-d849-479e-9a9b-9cee6f808b10&a.cluster=0&rtype=ah&ext_id=&a.ssc=1&a.asn=ip-10-49-139-133&a.profile_id=&p.vw.viewable=-1&p.vw.viewableOpportunity=-1&p.vw.psize=-1&a.sdk=&a.sdkType=&a.appReq=0&a.sscCap=0&a.platformDevice=ONLINE_VIDEO&ipAddressOverride=217.67.220.38&a.platformOs=Windows+7&p.vw.active=-1&eov=74443721&a.pub_id=&a.aid=&a.idfa=&a.idfa_md5=]]></Beacon><Beacon type="iab_detection_started"><![CDATA[http://log.adaptv.advertising.com/log?event=iabDetectionStarted&creativeId=60076&adSourceId=115439&bidId=&afppId=115440&exSId=113540&adSpotId=&pet=preroll&pod=-2&position=-2&marketplaceId=&adPlanId=-2&adaptag=&key=alexorlovstestpublisher&buyerId=&campaignId=14168&pageUrl=test.com&adapDetD=&sellRepD=test.com&urlDetMeth=&targDSellRep=1&mediaId=&zid=&url=&id=&duration=&a.geostrings=&uid=4223934359608602170&apid=TAe086247a-f26a-11e4-aefd-00163e1c8bbf&htmlEnabled=false&width=&height=&context=&categories=&sessionId=&serverRev=506081623&playerRev=&a.rid=e8a2c373-d849-479e-9a9b-9cee6f808b10&a.cluster=0&rtype=ah&ext_id=&a.ssc=1&a.asn=ip-10-49-139-133&a.profile_id=&p.vw.viewable=-1&p.vw.viewableOpportunity=-1&p.vw.psize=-1&a.sdk=&a.sdkType=&a.appReq=0&a.sscCap=0&a.platformDevice=ONLINE_VIDEO&ipAddressOverride=217.67.220.38&a.platformOs=Windows+7&p.vw.active=-1&eov=74443721&a.pub_id=&a.aid=&a.idfa=&a.idfa_md5=]]></Beacon>			<Beacon type="iab_detection_failed"><![CDATA[http://log.adaptv.advertising.com/log?event=iabDetectionFailed&creativeId=60076&adSourceId=115439&bidId=&afppId=115440&exSId=113540&adSpotId=&pet=preroll&pod=-2&position=-2&marketplaceId=&adPlanId=-2&adaptag=&key=alexorlovstestpublisher&buyerId=&campaignId=14168&pageUrl=test.com&adapDetD=&sellRepD=test.com&urlDetMeth=&targDSellRep=1&mediaId=&zid=&url=&id=&duration=&a.geostrings=&uid=4223934359608602170&apid=TAe086247a-f26a-11e4-aefd-00163e1c8bbf&htmlEnabled=false&width=&height=&context=&categories=&sessionId=&serverRev=506081623&playerRev=&a.rid=e8a2c373-d849-479e-9a9b-9cee6f808b10&a.cluster=0&rtype=ah&ext_id=&a.ssc=1&a.asn=ip-10-49-139-133&a.profile_id=&p.vw.viewable=-1&p.vw.viewableOpportunity=-1&p.vw.psize=-1&a.sdk=&a.sdkType=&a.appReq=0&a.sscCap=0&a.platformDevice=ONLINE_VIDEO&ipAddressOverride=217.67.220.38&a.platformOs=Windows+7&p.vw.active=-1&eov=74443721&a.pub_id=&a.aid=&a.idfa=&a.idfa_md5=]]></Beacon></Extension>')),
					new Fast(Xml.parse('<Extension type="AdServer" name="Videoplaza"><AdInfo countdown="false" allowLinearModeChange="false" gid="90d696dd-4baf-43e9-833f-4db7f7239d8f" cid="547f8882-45ad-4f97-89a4-32d4235fe129" format="spot_standard" variant="NORMAL" timeout="00:00:02.0" startAdTimeout="00:00:10.0" exclusive="false" /></Extension>'))
				],
				advertiser:null,
				survey:null,
				sequence:null,
				pricing:null
			}],
			error:null
		};
		checkMap('vast', vast, data);
	}
}