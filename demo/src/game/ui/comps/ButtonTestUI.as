/**Created by the Morn,do not modify.*/
package game.ui.comps {
	import morn.core.components.*;
	public class ButtonTestUI extends Dialog {
		public var btn1:Button = null;
		public var btn2:Button = null;
		protected static var uiXML:XML =
			<Dialog>
			  <Image url="png.comp.bg" x="0" y="0" sizeGrid="4,30,4,4" width="300" height="310"/>
			  <Button skin="png.comp.btn_close" x="265" y="3" name="close"/>
			  <Image url="png.comp.blank" x="0" y="0" width="261" height="26" name="drag"/>
			  <LinkButton label="linkButton" x="72" y="264"/>
			  <Button label="label" skin="png.comp.button" x="71" y="101" selected="false" disabled="true" width="100" height="30"/>
			  <Button label="label" skin="png.comp.button" x="71" y="153" labelStroke="0xcccc00" width="100" height="30" labelBold="false" labelSize="14" labelColors="0x666666"/>
			  <Button label="label" skin="png.comp.button" x="71" y="49" width="100" height="30" var="btn1"/>
			  <Button label="点我点我" skin="png.comp.button" x="71" y="205" labelBold="true" labelSize="20" height="40" width="150" labelColors="0xff0000,0x5eb10c,0xfe9705" var="btn2"/>
			</Dialog>;
		public function ButtonTestUI(){}
		override protected function createChildren():void {
			super.createChildren();
			createView(uiXML);
		}
	}
}