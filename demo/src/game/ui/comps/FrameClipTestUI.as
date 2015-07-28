/**Created by the Morn,do not modify.*/
package game.ui.comps {
	import morn.core.components.*;
	public class FrameClipTestUI extends Dialog {
		public var mc:FrameClip = null;
		protected static var uiXML:XML =
			<Dialog>
			  <Image url="png.comp.bg" x="0" y="0" sizeGrid="4,30,4,4" width="300" height="289"/>
			  <Button skin="png.comp.btn_close" x="265" y="3" name="close"/>
			  <FrameClip skin="assets.frameclip_Bear" x="41" y="67" var="mc"/>
			  <Image url="png.comp.blank" x="0" y="0" width="261" height="26" name="drag"/>
			</Dialog>;
		public function FrameClipTestUI(){}
		override protected function createChildren():void {
			super.createChildren();
			createView(uiXML);
		}
	}
}