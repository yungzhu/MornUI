/**Created by the Morn,do not modify.*/
package game.ui.comps {
	import morn.core.components.*;
	public class ProgressTestUI extends Dialog {
		public var progress1:ProgressBar = null;
		public var progress2:ProgressBar = null;
		protected static var uiXML:XML =
			<Dialog>
			  <Image url="png.comp.bg" x="0" y="0" sizeGrid="4,30,4,4" width="400" height="350"/>
			  <Button skin="png.comp.btn_close" x="365" y="3" name="close"/>
			  <Image url="png.comp.blank" x="0" y="0" width="360" height="26" name="drag"/>
			  <ProgressBar skin="png.comp.progress" x="102.5" y="131" sizeGrid="4,4,4,4" width="193" height="14" var="progress1" value="0.1"/>
			  <ProgressBar skin="png.comp.progress" x="139" y="208" sizeGrid="4,4,4,4" width="100" height="14" var="progress2" label="HP" value="0.8"/>
			</Dialog>;
		public function ProgressTestUI(){}
		override protected function createChildren():void {
			super.createChildren();
			createView(uiXML);
		}
	}
}