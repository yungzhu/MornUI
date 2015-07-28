/**Created by the Morn,do not modify.*/
package game.ui.comps {
	import morn.core.components.*;
	public class ClipTestUI extends Dialog {
		public var clip1:Clip = null;
		public var btn1:Button = null;
		public var clip2:Clip = null;
		public var btn2:Button = null;
		protected static var uiXML:XML =
			<Dialog label="点我播放停止">
			  <Image url="png.comp.bg" x="0" y="0" sizeGrid="4,30,4,4" width="300" height="289"/>
			  <Button skin="png.comp.btn_close" x="265" y="3" name="close"/>
			  <Image url="png.comp.blank" x="0" y="0" width="261" height="26" name="drag"/>
			  <Clip url="png.comp.clip_num" x="180" y="101" clipX="10" var="clip1"/>
			  <Button label="点我切换Icon" skin="png.comp.button" x="41" y="100" width="100" height="30" var="btn1"/>
			  <Clip url="png.comp.clip_num" x="180" y="179" clipX="10" autoPlay="true" var="clip2"/>
			  <Button label="点我播放停止" skin="png.comp.button" x="44" y="174" width="100" height="30" var="btn2"/>
			</Dialog>;
		public function ClipTestUI(){}
		override protected function createChildren():void {
			super.createChildren();
			createView(uiXML);
		}
	}
}