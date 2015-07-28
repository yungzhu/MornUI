/**Created by the Morn,do not modify.*/
package game.ui.comps {
	import morn.core.components.*;
	public class ViewStackTestUI extends Dialog {
		public var tab:Tab = null;
		public var viewStack:ViewStack = null;
		protected static var uiXML:XML =
			<Dialog>
			  <Image url="png.comp.bg" x="0" y="0" sizeGrid="4,30,4,4" width="400" height="350"/>
			  <Button skin="png.comp.btn_close" x="365" y="3" name="close"/>
			  <Image url="png.comp.blank" x="0" y="0" width="360" height="26" name="drag"/>
			  <Image url="png.comp.bg2" x="34" y="81" sizeGrid="4,4,4,4" width="344" height="236"/>
			  <Tab labels="武器,上衣,裤子,鞋子" skin="png.comp.tab" x="58" y="55" var="tab"/>
			  <ViewStack x="94" y="173" var="viewStack">
			    <Label text="武器" name="item0"/>
			    <Label text="上衣" x="65" name="item1"/>
			    <Label text="裤子" x="130" name="item2"/>
			    <Label text="鞋子" x="195" name="item3"/>
			  </ViewStack>
			</Dialog>;
		public function ViewStackTestUI(){}
		override protected function createChildren():void {
			super.createChildren();
			createView(uiXML);
		}
	}
}