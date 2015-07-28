/**Created by the Morn,do not modify.*/
package game.ui.comps {
	import morn.core.components.*;
	public class ComboBoxTestUI extends Dialog {
		public var combo2:ComboBox = null;
		public var combo1:ComboBox = null;
		public var label:Label = null;
		protected static var uiXML:XML =
			<Dialog>
			  <Image url="png.comp.bg" x="0" y="0" sizeGrid="4,30,4,4" width="300" height="289"/>
			  <Button skin="png.comp.btn_close" x="265" y="3" name="close"/>
			  <Image url="png.comp.blank" x="0" y="0" width="261" height="26" name="drag"/>
			  <ComboBox labels="label1,label2" skin="png.comp.combobox" x="41" y="182" sizeGrid="4,4,25,4" width="202" height="23" scrollBarSkin="png.comp.vscroll" var="combo2"/>
			  <ComboBox labels="label1,label2,label3,label4" skin="png.comp.combobox" x="41" y="72" sizeGrid="4,4,25,4"/>
			  <ComboBox labels="label1,label2,label3,label4" skin="png.comp.combobox" x="41" y="127" sizeGrid="4,4,25,4" width="149" height="23" scrollBarSkin="png.comp.vscroll" openDirection="up" labelBold="false" labelSize="16" itemSize="16" itemColors="0x333333,0xffffff" selectedIndex="0" var="combo1"/>
			  <Label text="请选择上面下拉框" x="41" y="211" width="249" height="18" var="label"/>
			</Dialog>;
		public function ComboBoxTestUI(){}
		override protected function createChildren():void {
			super.createChildren();
			createView(uiXML);
		}
	}
}