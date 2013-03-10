/**Created by Morn,Do not modify.*/
package game.ui {
	import morn.core.components.*;
	public class TestTipsUI extends View {
		public var label:Label;
		private var uiXML:XML =
			<View>
			  <Image url="png.comp.bg" x="0" y="0" width="150" height="50"/>
			  <Label text="label" x="9" y="21" var="label" width="130" height="22"/>
			</View>;
		override protected function createChildren():void {
			createView(uiXML);
		}
	}
}