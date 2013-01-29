/**Created by Morn,Do not modify.*/
package game.ui {
	import morn.core.components.*;
	public class CompTestUI extends Dialog {
		public var btn2:Button;
		public var btn:Button;
		public var progressBar:ProgressBar;
		public var checkbox:CheckBox;
		public var radioGroup:RadioGroup;
		public var tab:Tab;
		public var link:LinkButton;
		public var clip:Clip;
		public var hslider:HSlider;
		public var list:List;
		public var viewStack:ViewStack;
		public var frame:FrameClip;
		public var combo:ComboBox;
		private var uiXML:XML =
			<Dialog>
			  <Image url="png.comp.bg" x="0" y="0" sizeGrid="4,26,4,4" width="530" height="450"/>
			  <Button skin="png.comp.btn_close" x="497" y="4" name="close"/>
			  <Button label="我被拉大了" skin="png.comp.button" x="331" y="73" width="150" height="36" var="btn2" labelSize="20" labelBold="true" labelMargin="1,1,1,1"/>
			  <Label text="这里是标签" x="34" y="42" name="label"/>
			  <Button label="点我点我" skin="png.comp.button" x="398" y="41" var="btn"/>
			  <ProgressBar skin="png.comp.progress" x="35" y="131" width="100" height="12" sizeGrid="4,4,4,4" var="progressBar"/>
			  <TextArea text="谷歌一直很重视Android系统缺乏足够的应用程序这方面的问题，公司认为新发布的Nexus平板将对这一问题的解决其促进作用。谷歌的Android产品经理雨果·巴拉（Hugo Barra）在接受科技网站the Verge的采访时表示，“公司投入大量精力推出Nexus 10平板，也是为了刺激开发者，让他们对Android应用的开发更有动力" x="35" y="324" width="150" height="100" scrollBarSkin="png.comp.vscroll"/>
			  <CheckBox label="label" skin="png.comp.checkbox" x="35" y="82" var="checkbox" name="checkbox"/>
			  <RadioGroup labels="label1,label2" skin="png.comp.radiogroup" x="121" y="82" var="radioGroup"/>
			  <Tab labels="tab1,tab2" skin="png.comp.tab" x="356" y="278" var="tab"/>
			  <LinkButton label="我是LinkButton" x="274" y="43" var="link"/>
			  <Clip url="png.comp.clip_num" x="266" y="76" clipX="10" clipY="1" index="10" var="clip"/>
			  <TextInput text="我是输入框" x="136" y="42" width="100" height="20" skin="png.comp.textinput"/>
			  <HSlider skin="png.comp.hslider" x="183" y="135" width="100" var="hslider"/>
			  <List x="214" y="275" var="list">
			    <Box x="0" y="0" name="item0">
			      <Clip url="png.other.clip_selectBox" x="24" y="4" clipX="1" clipY="2" width="64" height="20" name="selectBox"/>
			      <Label text="label" x="27" y="4" name="label"/>
			      <Clip url="png.comp.clip_num" clipX="10" clipY="1" name="icon"/>
			    </Box>
			    <Box x="0" y="32" name="item1">
			      <Clip url="png.other.clip_selectBox" x="24" y="4" clipX="1" clipY="2" width="64" height="20" name="selectBox"/>
			      <Label text="label" x="27" y="4" name="label"/>
			      <Clip url="png.comp.clip_num" clipX="10" clipY="1" name="icon"/>
			    </Box>
			    <Box x="0" y="64" name="item2">
			      <Clip url="png.other.clip_selectBox" x="24" y="4" clipX="1" clipY="2" width="64" height="20" name="selectBox"/>
			      <Label text="label" x="27" y="4" name="label"/>
			      <Clip url="png.comp.clip_num" clipX="10" clipY="1" name="icon"/>
			    </Box>
			    <Box x="0" y="96" name="item3">
			      <Clip url="png.other.clip_selectBox" x="24" y="4" clipX="1" clipY="2" width="64" height="20" name="selectBox"/>
			      <Label text="label" x="27" y="4" name="label"/>
			      <Clip url="png.comp.clip_num" clipX="10" clipY="1" name="icon"/>
			    </Box>
			    <Box x="0" y="128" name="item4">
			      <Clip url="png.other.clip_selectBox" x="24" y="4" clipX="1" clipY="2" width="64" height="20" name="selectBox"/>
			      <Label text="label" x="27" y="4" name="label"/>
			      <Clip url="png.comp.clip_num" clipX="10" clipY="1" name="icon"/>
			    </Box>
			    <VScrollBar skin="png.comp.vscroll" x="89" y="3" width="15" height="150" name="scrollBar"/>
			  </List>
			  <ViewStack x="364" y="328" var="viewStack">
			    <Label text="view1" name="item0" y="0"/>
			    <LinkButton label="view2" x="47" y="0" name="item1"/>
			  </ViewStack>
			  <FrameClip skin="assets.frameclip_Bear" x="222" y="176" var="frame"/>
			  <Panel x="36" y="182" scrollBarSkin="png.comp.vscroll" width="150" height="100">
			    <Image url="png.comp.image"/>
			  </Panel>
			  <ComboBox labels="label1,label2" skin="png.comp.combobox" x="331" y="123" var="combo" sizeGrid="4,4,14,4"/>
			  <ComboBox labels="类可使用表示,位带符号整数的数据,这意味着无需对象,不需要使用构造函数,这意味着需要对象才能,不需要浮点数,如果您正在处理超过,无需使用构造函数" skin="png.comp.combobox" x="331" y="171" sizeGrid="4,4,14,4" width="150" height="23" scrollBarSkin="png.comp.vscroll"/>
			</Dialog>;
		public function CompTestUI() {
			createView(uiXML);
		}
	}
}