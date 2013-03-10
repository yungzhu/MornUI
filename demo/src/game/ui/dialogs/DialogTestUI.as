/**Created by Morn,Do not modify.*/
package game.ui.dialogs {
	import morn.core.components.*;
	public class DialogTestUI extends Dialog {
		private var uiXML:XML =
			<Dialog dragArea="0,0,400,26">
			  <Image url="png.comp.bg" x="0" y="0" width="500" height="300" sizeGrid="4,26,4,4"/>
			  <FrameClip skin="assets.frameclip_Bear" x="72" y="41" width="365.85" height="247.5" autoPlay="true" interval="50"/>
			  <Button skin="png.comp.btn_close" x="461" y="3" name="close"/>
			</Dialog>;
		override protected function createChildren():void {
			createView(uiXML);
		}
	}
}