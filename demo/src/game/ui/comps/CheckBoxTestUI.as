/**Created by the Morn,do not modify.*/
package game.ui.comps {
	import morn.core.components.*;
	public class CheckBoxTestUI extends Dialog {
		public var check:CheckBox = null;
		protected static var uiXML:XML =
			<Dialog>
			  <Image url="png.comp.bg" x="0" y="0" sizeGrid="4,30,4,4" width="235" height="179"/>
			  <Button skin="png.comp.btn_close" x="198" y="3" name="close"/>
			  <CheckBox label="我被选中了" skin="png.comp.checkbox" x="62" y="61" selected="true" var="check"/>
			  <CheckBox label="改变字体颜色" skin="png.comp.checkbox" x="62" y="94" labelColors="0xff0000,0x5eb10c,0xfe9705"/>
			  <CheckBox label="被禁用了" skin="png.comp.checkbox" x="62" y="127" labelColors="0x" disabled="true" selected="true"/>
			  <Image url="png.comp.blank" x="0" y="0" width="195" height="26" name="drag"/>
			</Dialog>;
		public function CheckBoxTestUI(){}
		override protected function createChildren():void {
			super.createChildren();
			createView(uiXML);
		}
	}
}