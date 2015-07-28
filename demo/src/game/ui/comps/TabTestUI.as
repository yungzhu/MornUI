/**Created by the Morn,do not modify.*/
package game.ui.comps {
	import morn.core.components.*;
	public class TabTestUI extends Dialog {
		public var tab:Tab = null;
		protected static var uiXML:XML =
			<Dialog>
			  <Image url="png.comp.bg" x="0" y="0" sizeGrid="4,30,4,4" width="400" height="350"/>
			  <Button skin="png.comp.btn_close" x="365" y="3" name="close"/>
			  <Image url="png.comp.blank" x="0" y="0" width="360" height="26" name="drag"/>
			  <Tab labels="label1,label2,label3,label4" skin="png.comp.tab" x="54" y="95" var="tab"/>
			  <Tab x="54" y="215" selectedIndex="1">
			    <Button label="武器" skin="png.comp.btn_tab" name="item0" x="0"/>
			    <Button label="上衣" skin="png.comp.btn_tab" x="78" name="item1" y="0"/>
			    <Button label="裤子" skin="png.comp.btn_tab" x="156" labelColors="0xff0000,0xff0000,0xff0000" name="item2" y="0"/>
			    <Button label="鞋子" skin="png.comp.btn_tab" x="234" labelColors="0xff0000,0xff0000,0xff0000" name="item3" y="0"/>
			  </Tab>
			  <Label text="设置labels的Tab" x="53" y="70"/>
			  <Label text="自定义的Tab" x="54" y="191"/>
			</Dialog>;
		public function TabTestUI(){}
		override protected function createChildren():void {
			super.createChildren();
			createView(uiXML);
		}
	}
}