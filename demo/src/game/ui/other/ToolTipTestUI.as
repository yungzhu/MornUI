/**Created by the Morn,do not modify.*/
package game.ui.other {
	import morn.core.components.*;
	public class ToolTipTestUI extends Dialog {
		public var clip:Clip = null;
		public var image:Image = null;
		public var check:CheckBox = null;
		protected static var uiXML:XML =
			<Dialog>
			  <Image url="png.comp.bg" x="0" y="0" sizeGrid="4,30,4,4" width="400" height="350"/>
			  <Button skin="png.comp.btn_close" x="365" y="3" name="close"/>
			  <Image url="png.comp.blank" x="0" y="0" width="360" height="26" name="drag"/>
			  <Label text="This is a label" x="55" y="97" toolTip="这里是文本"/>
			  <Button label="Button" skin="png.comp.button" x="55" y="161" toolTip="这里是按钮"/>
			  <Clip url="png.comp.clip_num" x="230" y="225" clipX="10" var="clip" frame="5"/>
			  <Image url="png.comp.bg" x="229" y="96" sizeGrid="4,30,4,4" var="image"/>
			  <CheckBox label="label" skin="png.comp.checkbox" x="291" y="231" var="check"/>
			  <TextInput skin="png.comp.textinput" x="55" y="229" toolTip="请在这里输入"/>
			</Dialog>;
		public function ToolTipTestUI(){}
		override protected function createChildren():void {
			super.createChildren();
			createView(uiXML);
		}
	}
}