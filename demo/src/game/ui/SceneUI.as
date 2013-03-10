/**Created by Morn,Do not modify.*/
package game.ui {
	import morn.core.components.*;
	public class SceneUI extends View {
		public var btn1:Button;
		public var btn3:Button;
		public var btn2:Button;
		private var uiXML:XML =
			<View>
			  <Image url="jpg.map.map1" x="0" y="0"/>
			  <Image url="png.map.map1_item" x="0" y="0" width="2500" height="650"/>
			  <Box x="0" y="0">
			    <Image url="png.other.info" y="29"/>
			    <Image url="png.other.touxiang" x="4"/>
			    <Label text="yung" x="105" y="37" color="0xffffff" stroke="0x333333"/>
			    <Label text="Lv.36" x="225" y="39" color="0xffffff" stroke="0x333333"/>
			    <Label text="银币" x="105" y="60" color="0xffffff" stroke="0x333333"/>
			    <Label text="6万" x="134" y="60" color="0xffffff" stroke="0x333333"/>
			    <Label text="金币" x="105" y="82" color="0xffff00" stroke="0x333333"/>
			    <Label text="10" x="134" y="82" color="0xffffff" stroke="0x333333"/>
			    <Label text="礼券" x="190" y="82" color="0xffff00" stroke="0x333333"/>
			    <Label text="20" x="221" y="82" color="0xffffff" stroke="0x333333"/>
			    <Label text="10/80" x="134" y="107" color="0xffffff" stroke="0x333333"/>
			  </Box>
			  <Box x="28" y="152">
			    <Image url="png.other.team"/>
			    <Label text="小白龙" x="55" y="17" color="0xffffff" stroke="0x333333"/>
			  </Box>
			  <Box x="28" y="233">
			    <LinkButton label="当前可以强化装备" x="28" labelColors="0x00ff00" labelStroke="0x333333"/>
			    <Image url="png.other.streng" x="3"/>
			    <Image url="png.other.battle" y="30"/>
			    <Image url="png.other.slave" x="2" y="64"/>
			    <LinkButton label="可以进行竞技战斗" x="28" y="32" labelColors="0x00ff00" labelStroke="0x333333"/>
			    <LinkButton label="你是【自由身】" x="28" y="64" labelColors="0x00ff00" labelStroke="0x333333"/>
			  </Box>
			  <Container x="13" y="337" left="5" bottom="5">
			    <TextArea text="Facebook是一个社交网络服务网站，于2004年2月4日上线。Facebook是美国排名第一的照片分享站点，每天上载八百五十万张照片。随着用户数量增加，Facebook的目标已经指向另外一个领域：互联网搜索。2012年2月1日，Facebook正式向美国证券交易委员会（SEC）提出首次公开发行（IPO）申请，目标融资规模达50亿美元，并任命摩根士丹利、高盛和摩根大通为主要承销商。这将是硅谷有史以来规模最大的IPO。2012年5月18日，Facebook正式在美国纳斯达克证券交易所上市。2012年6月，Facebook称将涉足在线支付领域。" x="2" y="55" width="266" height="150" scrollBarSkin="png.comp.vscroll"/>
			    <Label text="【系统】每天21:00会开启怪物攻城活动，参与活动可获得天赋石和大量经验，金币，各国30级以上的勇士均可参与。" color="0xc8ce78" stroke="0x333333" width="275" height="55" wordWrap="true" multiline="true"/>
			  </Container>
			  <Button label="对话框1" skin="png.other.btn_yellow" x="399" y="186" var="btn1" width="70" height="26"/>
			  <Button label="组件" skin="png.other.btn_yellow" x="399" y="247" var="btn3" labelBold="true" width="86" height="38" labelSize="14"/>
			  <Button label="对话框2" skin="png.other.btn_yellow" x="497" y="186" var="btn2" width="70" height="26"/>
			  <Container x="319" y="480" right="0" bottom="0">
			    <Image url="png.nav.bg" y="39"/>
			    <ProgressBar skin="png.nav.progress" x="33" y="58" sizeGrid="4,4,4,4" width="648" height="12"/>
			    <Image url="png.nav.image_134" x="122" y="3"/>
			    <Image url="png.nav.image_78" x="46"/>
			  </Container>
			</View>;
		override protected function createChildren():void {
			createView(uiXML);
		}
	}
}