/**Created by the Morn,do not modify.*/
package game.ui.comps {
	import morn.core.components.*;
	public class LabelTestUI extends Dialog {
		protected static var uiXML:XML =
			<Dialog>
			  <Image url="png.comp.bg" x="0" y="0" sizeGrid="4,30,4,4" width="300" height="350"/>
			  <Button skin="png.comp.btn_close" x="265" y="3" name="close"/>
			  <Image url="png.comp.blank" x="0" y="0" width="261" height="26" name="drag"/>
			  <Label text="label" x="44" y="51" width="178" height="18"/>
			  <Label text="label" x="44" y="86" width="177" height="34" stroke="0x666666,1,4,4,5" size="24" color="0xffff33"/>
			  <Label text="换行&lt;br>换行&lt;font size='20' color='#ff0000'>20号字体&lt;/font>同时该机还为内置的800万像素摄像头还增加了光学防抖功能" x="44" y="137" width="184" height="86" isHtml="true" multiline="true" wordWrap="true" skin="png.comp.label" margin="4,4,4,4"/>
			  <Label text="同时该机还为内置的800万像素摄像头还增加了光学防抖功能" x="44" y="240" width="186" height="67" isHtml="true" multiline="true" wordWrap="true" skin="png.comp.label" margin="4,4,4,4" align="left" underline="true" leading="4" indent="20" letterSpacing="5"/>
			</Dialog>;
		public function LabelTestUI(){}
		override protected function createChildren():void {
			super.createChildren();
			createView(uiXML);
		}
	}
}