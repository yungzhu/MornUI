/**Created by the Morn,do not modify.*/
package game.ui.comps {
	import morn.core.components.*;
	public class ContainerTestUI extends Dialog {
		protected static var uiXML:XML =
			<Dialog width="600" height="400">
			  <Container x="263" y="88" right="10" top="5">
			    <Button skin="png.comp.btn_close" name="close"/>
			  </Container>
			  <Container x="63" y="86" centerX="0" centerY="0">
			    <Image url="png.comp.bg" sizeGrid="4,30,4,4"/>
			    <Label text="居中定位" x="24" y="39"/>
			  </Container>
			  <Container x="177" y="201" bottom="10" right="10">
			    <Image url="png.comp.bg" sizeGrid="4,30,4,4"/>
			    <Label text="右下角定位" x="20" y="38" width="66" height="18"/>
			  </Container>
			  <Container x="48" y="211" left="10" bottom="10">
			    <Image url="png.comp.bg" sizeGrid="4,30,4,4"/>
			    <Label text="左下角定位" x="20" y="38" width="66" height="18"/>
			  </Container>
			</Dialog>;
		public function ContainerTestUI(){}
		override protected function createChildren():void {
			super.createChildren();
			createView(uiXML);
		}
	}
}