/**Created by the Morn,do not modify.*/
package game.ui.comps {
	import morn.core.components.*;
	public class PanelTestUI extends Dialog {
		public var panel:Panel = null;
		protected static var uiXML:XML =
			<Dialog>
			  <Image url="png.comp.bg" x="0" y="0" sizeGrid="4,30,4,4" width="399" height="446"/>
			  <Button skin="png.comp.btn_close" x="365" y="3" name="close"/>
			  <Image url="png.comp.blank" x="0" y="0" width="360" height="26" name="drag"/>
			  <Panel x="107" y="73" width="163" height="137" vScrollBarSkin="png.comp.vscroll" var="panel">
			    <Image url="png.comp.image"/>
			  </Panel>
			  <Panel x="107" y="240" width="160" height="160" hScrollBarSkin="png.comp.hscroll">
			    <Clip url="png.comp.clip_num" x="0" y="0" clipX="10" width="464" height="160"/>
			  </Panel>
			</Dialog>;
		public function PanelTestUI(){}
		override protected function createChildren():void {
			super.createChildren();
			createView(uiXML);
		}
	}
}