/**Created by the Morn,do not modify.*/
package game.ui.comps {
	import morn.core.components.*;
	public class TextInputTestUI extends Dialog {
		public var input1:TextInput = null;
		public var input2:TextInput = null;
		protected static var uiXML:XML =
			<Dialog>
			  <Image url="png.comp.bg" x="0" y="0" sizeGrid="4,30,4,4" width="400" height="350"/>
			  <Button skin="png.comp.btn_close" x="365" y="3" name="close"/>
			  <Image url="png.comp.blank" x="0" y="0" width="360" height="26" name="drag"/>
			  <TextInput text="请输入" skin="png.comp.textinput" x="137" y="110" margin="1,1,1,1" var="input1"/>
			  <TextInput text="请输入" skin="png.comp.textinput" x="137" y="165" align="center" margin="1,1,1,1" var="input2"/>
			  <TextInput text="请输入" skin="png.comp.textinput" x="137" y="220" margin="1,1,1,1" asPassword="true"/>
			</Dialog>;
		public function TextInputTestUI(){}
		override protected function createChildren():void {
			super.createChildren();
			createView(uiXML);
		}
	}
}