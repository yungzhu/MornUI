package view {
	import flash.events.Event;
	import game.ui.comps.TabTestUI;
	import morn.core.components.Button;
	
	/**标签*/
	public class TabTest extends TabTestUI {
		
		public function TabTest() {
			tab.addEventListener(Event.SELECT, onTabSelect);
		}
		
		private function onTabSelect(e:Event):void {
			trace(tab.selectedIndex, Button(tab.selection).label);
		}
	}
}