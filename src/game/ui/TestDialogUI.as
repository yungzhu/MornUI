/**Created by Morn,Do not modify.*/
package game.ui {
	import morn.core.components.*;
	public class TestDialogUI extends Dialog {
		private var uiXML:XML =
			<Dialog>
			  <Image url="png.comp.image2" x="0" y="0" width="600" height="400" sizeGrid="4,4,4,4"/>
			  <Button skin="png.comp.btn_close" x="570" y="12" name="closeBtn"/>
			  <FrameClip skin="assets.frameclip_Bear" x="488" y="314"/>
			  <Image url="png.nav.image 106" x="263" y="35"/>
			  <Image url="png.hero.info" x="144" y="140"/>
			</Dialog>;
		public function TestDialogUI() {
			createView(uiXML);
		}
	}
}