/**Created by Morn,Do not modify.*/
package game.ui.dialogs {
	import morn.core.components.*;
	public class DialogTestUI extends Dialog {
		public var closeBtn:Button;
		private var uiXML:XML =
			<Dialog>
			  <Image url="png.comp.image" x="0" y="0" sizeGrid="4,4,4,4" width="400" height="300"/>
			  <Button skin="png.comp.btn_close" x="370" y="7" var="closeBtn"/>
			  <FrameClip skin="assets.frameclip_Bear" x="18" y="43" width="365.85" height="247.5"/>
			</Dialog>;
		public function DialogTestUI() {
			createView(uiXML);
		}
	}
}