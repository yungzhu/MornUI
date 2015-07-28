/**Created by the Morn,do not modify.*/
package game.ui.other {
	import morn.core.components.*;
	public class DataSourceTestUI extends Dialog {
		public var box1:Box = null;
		public var box2:Box = null;
		public var list:List = null;
		public var btn:Button = null;
		protected static var uiXML:XML =
			<Dialog>
			  <Image url="png.comp.bg" x="0" y="0" sizeGrid="4,30,4,4" width="398" height="500"/>
			  <Button skin="png.comp.btn_close" x="365" y="3" name="close"/>
			  <Image url="png.comp.blank" x="0" y="0" width="360" height="26" name="drag"/>
			  <Box x="24" y="69" var="box1">
			    <Image url="png.comp.bg2" sizeGrid="4,4,4,4" width="351" height="104"/>
			    <Label text="This is label1" x="31" y="23" width="117" height="19" name="label1"/>
			    <CheckBox label="checkbox" skin="png.comp.checkbox" x="31" y="62" name="check"/>
			    <ProgressBar skin="png.comp.progress" x="190" y="62" width="110" height="14" name="progress" sizeGrid="2,2,2,2"/>
			    <Label text="This is label2" x="190" y="23" width="117" height="19" name="label2"/>
			  </Box>
			  <Box x="24" y="204" var="box2">
			    <Image url="png.comp.bg2" sizeGrid="4,4,4,4" width="351" height="104"/>
			    <Label text="This is label1" x="31" y="23" width="154" height="19" name="label1"/>
			    <CheckBox label="checkbox" skin="png.comp.checkbox" x="31" y="62" name="check"/>
			    <ProgressBar skin="png.comp.progress" x="190" y="62" width="110" height="14" name="progress" sizeGrid="2,2,2,2"/>
			    <Label text="This is label2" x="190" y="23" width="117" height="19" name="label2"/>
			  </Box>
			  <List x="24" y="345" repeatX="1" repeatY="5" spaceX="4" spaceY="0" var="list">
			    <VScrollBar skin="png.comp.vscroll" x="121" height="135" name="scrollBar" y="0"/>
			    <Box name="render">
			      <Clip url="png.comp.clip_selectBox" x="26" y="0" clipY="2" width="90" name="selectBox" height="27"/>
			      <Clip url="png.comp.clip_num" clipX="10" name="icon"/>
			      <Label text="label" x="26" y="3" width="90" name="label"/>
			    </Box>
			  </List>
			  <Label text="List赋值" x="23" y="321"/>
			  <Label text="默认属性赋值" x="23" y="45"/>
			  <Label text="任意属性赋值" x="23" y="183"/>
			  <Button label="点击这里进行赋值" skin="png.comp.button" x="209" y="387" width="150" var="btn" labelColors="0xff0000" height="40"/>
			</Dialog>;
		public function DataSourceTestUI(){}
		override protected function createChildren():void {
			super.createChildren();
			createView(uiXML);
		}
	}
}