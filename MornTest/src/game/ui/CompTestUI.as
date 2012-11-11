/**Created by Morn,Do not modify.*/
package game.ui {
	import morn.core.components.*;
	public class CompTestUI extends Dialog {
		public var btn:Button;
		public var progressBar:ProgressBar;
		public var checkbox:CheckBox;
		public var radioGroup:RadioGroup;
		public var tab:Tab;
		public var clip:Clip;
		public var hSlider:HSlider;
		public var list:List;
		public var viewStack:ViewStack;
		public var closeBtn:Button;
		private var uiXML:XML =
			<Dialog>
			  <Image url="png.comp.bg" x="0" y="0" sizeGrid="5,5,5,5" width="530" height="400"/>
			  <Label text="这里是标签" x="35" y="26"/>
			  <Button label="点我点我" skin="png.comp.btn_blue" x="274" y="58" var="btn"/>
			  <ProgressBar skin="png.comp.progress" x="35" y="110" width="100" height="12" sizeGrid="4,4,4,4" var="progressBar"/>
			  <VScrollBar skin="png.comp.vscroll" x="170" y="150" height="100"/>
			  <Image url="png.comp.image" x="35" y="150" sizeGrid="4,4,4,4" width="100" height="100"/>
			  <TextArea text="谷歌一直很重视Android系统缺乏足够的应用程序这方面的问题，公司认为新发布的Nexus平板将对这一问题的解决其促进作用。谷歌的Android产品经理雨果·巴拉（Hugo Barra）在接受科技网站the Verge的采访时表示，“公司投入大量精力推出Nexus 10平板，也是为了刺激开发者，让他们对Android应用的开发更有动力" x="35" y="280" width="150" height="100" scrollBarSkin="png.comp.vscroll"/>
			  <CheckBox label="label" skin="png.comp.checkbox" x="35" y="62" var="checkbox"/>
			  <RadioGroup labels="label1,label2" skin="png.comp.radioGroup" x="114" y="62" var="radioGroup"/>
			  <Tab labels="tab1,tab2" skin="png.comp.tab" x="399" y="207" var="tab"/>
			  <LinkButton label="我是LinkButton" x="273" y="27"/>
			  <Clip url="png.comp.clip_num" x="313" y="102" clipX="10" clipY="1" index="10" var="clip"/>
			  <TextInput text="我是输入框" x="136" y="26" width="100" height="20"/>
			  <HSlider skin="png.comp.hslider" x="174" y="114" width="100" var="hSlider"/>
			  <List x="266" y="205" var="list">
			    <VScrollBar skin="png.comp.vscroll" x="85" y="3" width="15" height="170" name="scrollBar"/>
			    <Box x="0" y="0" name="item0">
			      <Label text="label" x="27" y="4" name="label"/>
			      <Clip url="png.comp.clip_num" clipX="10" clipY="1" name="icon"/>
			    </Box>
			    <Box x="0" y="37" name="item1">
			      <Label text="label" x="27" y="4" name="label"/>
			      <Clip url="png.comp.clip_num" clipX="10" clipY="1" name="icon"/>
			    </Box>
			    <Box x="0" y="74" name="item2">
			      <Label text="label" x="27" y="4" name="label"/>
			      <Clip url="png.comp.clip_num" clipX="10" clipY="1" name="icon"/>
			    </Box>
			    <Box x="0" y="111" name="item3">
			      <Label text="label" x="27" y="4" name="label"/>
			      <Clip url="png.comp.clip_num" clipX="10" clipY="1" name="icon"/>
			    </Box>
			    <Box x="0" y="148" name="item4">
			      <Label text="label" x="27" y="4" name="label"/>
			      <Clip url="png.comp.clip_num" clipX="10" clipY="1" name="icon"/>
			    </Box>
			  </List>
			  <ViewStack x="407" y="257" var="viewStack">
			    <Label text="view1" name="item0" y="0"/>
			    <LinkButton label="view2" x="47" y="0" name="item1"/>
			  </ViewStack>
			  <FrameClip skin="assets.frameclip_Bear" x="380" y="61"/>
			  <Button skin="png.comp.btn_close" x="489" y="18" var="closeBtn"/>
			</Dialog>;
		public function CompTestUI() {
			createView(uiXML);
		}
	}
}