/**Created by Morn,Do not modify.*/
package game.ui.dialogs {
	import morn.core.components.*;
	public class DialogTest2UI extends Dialog {
		private var uiXML:XML =
			<Dialog>
			  <Image url="png.comp.bg" x="0" y="0" width="400" height="400" sizeGrid="4,26,4,4"/>
			  <Button skin="png.comp.btn_close" x="361" y="3" name="close"/>
			  <Label text="label" x="161" y="196"/>
			</Dialog>;
		override protected function createChildren():void {
			createView(uiXML);
		}
	}
}