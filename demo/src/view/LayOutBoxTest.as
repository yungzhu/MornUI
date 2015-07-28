package view {
	import flash.events.MouseEvent;
	import game.ui.comps.LayoutBoxTestUI;
	
	/**布局容器示例*/
	public class LayOutBoxTest extends LayoutBoxTestUI {
		
		public function LayOutBoxTest() {	
			hbox1.showBorder();			
			hbox2.showBorder();
			hbox3.showBorder();
			vbox1.showBorder();
			vbox2.showBorder();
			vbox3.showBorder();
			
			hbox1.addEventListener(MouseEvent.CLICK, onHbox1Click);
		}
		
		private function onHbox1Click(e:MouseEvent):void {
			hbox1.showBorder();
		}
	}
}