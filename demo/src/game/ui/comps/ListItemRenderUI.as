/**Created by the Morn,do not modify.*/
package game.ui.comps {
	import morn.core.components.*;
	public class ListItemRenderUI extends View {
		protected static var uiXML:XML =
			<View>
			  <Label text="label" x="31" y="3.5" width="80" name="label"/>
			  <Clip url="png.comp.clip_num" x="0" y="0" clipX="10" name="icon"/>
			</View>;
		public function ListItemRenderUI(){}
		override protected function createChildren():void {
			super.createChildren();
			createView(uiXML);
		}
	}
}