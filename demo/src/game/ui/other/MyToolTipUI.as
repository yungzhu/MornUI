/**Created by the Morn,do not modify.*/
package game.ui.other {
	import morn.core.components.*;
	public class MyToolTipUI extends View {
		public var label:Label = null;
		protected static var uiXML:XML =
			<View>
			  <Image url="png.comp.bg" x="0" y="0" sizeGrid="4,30,4,4" width="133" height="105"/>
			  <Label x="9" y="41" width="114" height="47" var="label" multiline="true" wordWrap="true" color="0x66cc" leading="8" text="label"/>
			</View>;
		public function MyToolTipUI(){}
		override protected function createChildren():void {
			super.createChildren();
			createView(uiXML);
		}
	}
}