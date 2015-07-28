/**Created by the Morn,do not modify.*/
package game.ui.other {
	import morn.core.components.*;
	public class LanguageTestUI extends Dialog {
		public var btn:Button = null;
		public var box:Box = null;
		protected static var uiXML:XML =
			<Dialog>
			  <Image url="png.comp.bg" x="0" y="0" sizeGrid="4,30,4,4" width="400" height="350"/>
			  <Button skin="png.comp.btn_close" x="365" y="3" name="close"/>
			  <Image url="png.comp.blank" x="0" y="0" width="360" height="26" name="drag"/>
			  <Button label="点击这里切换语言" skin="png.comp.button" x="122" y="229" width="150" height="40" var="btn"/>
			  <Box x="29" y="80" var="box">
			    <Image url="png.comp.bg2" sizeGrid="4,4,4,4" width="351" height="104"/>
			    <Label text="这里是中文" x="31" y="23" width="117" height="19"/>
			    <CheckBox label="选择框" skin="png.comp.checkbox" x="31" y="62"/>
			    <Label text="多语言测试" x="179" y="23" width="163" height="19"/>
			  </Box>
			</Dialog>;
		public function LanguageTestUI(){}
		override protected function createChildren():void {
			super.createChildren();
			createView(uiXML);
		}
	}
}