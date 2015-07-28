/**Created by the Morn,do not modify.*/
package game.ui.comps {
	import morn.core.components.*;
	public class SliderTestUI extends Dialog {
		public var slider:HSlider = null;
		protected static var uiXML:XML =
			<Dialog>
			  <Image url="png.comp.bg" x="0" y="0" sizeGrid="4,30,4,4" width="400" height="350"/>
			  <Button skin="png.comp.btn_close" x="365" y="3" name="close"/>
			  <Image url="png.comp.blank" x="0" y="0" width="360" height="26" name="drag"/>
			  <HSlider skin="png.comp.hslider" x="91" y="119" var="slider" width="200" height="6" tick="10" min="0" max="200"/>
			  <VSlider skin="png.comp.vslider" x="96" y="169"/>
			  <VSlider skin="png.comp.vslider" x="189" y="169" tick="0.1" min="0" max="10"/>
			  <VSlider skin="png.comp.vslider" x="282" y="169" min="0" max="1000" tick="100"/>
			  <Label text="Tick：20" x="91" y="83"/>
			  <Label text="Tick：0.1" x="167" y="141"/>
			  <Label text="Tick：1" x="73" y="140"/>
			  <Label text="Tick：100" x="252" y="140"/>
			</Dialog>;
		public function SliderTestUI(){}
		override protected function createChildren():void {
			super.createChildren();
			createView(uiXML);
		}
	}
}