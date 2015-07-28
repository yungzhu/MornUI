/**Created by the Morn,do not modify.*/
package game.ui.comps {
	import morn.core.components.*;
	public class TextAreaTestUI extends Dialog {
		public var area1:TextArea = null;
		public var area2:TextArea = null;
		protected static var uiXML:XML =
			<Dialog>
			  <Image url="png.comp.bg" x="0" y="0" sizeGrid="4,30,4,4" width="400" height="350"/>
			  <Button skin="png.comp.btn_close" x="365" y="3" name="close"/>
			  <Image url="png.comp.blank" x="0" y="0" width="360" height="26" name="drag"/>
			  <TextArea text="请输入" skin="png.comp.textarea" x="27" y="54" margin="1,1,1,1" scrollBarSkin="png.comp.vscroll" width="349" height="112" var="area1"/>
			  <TextArea text="测试自动滚动到底部" skin="png.comp.textarea" x="27" y="195" margin="1,1,1,1" scrollBarSkin="png.comp.vscroll" width="349" height="112" var="area2"/>
			</Dialog>;
		public function TextAreaTestUI(){}
		override protected function createChildren():void {
			super.createChildren();
			createView(uiXML);
		}
	}
}