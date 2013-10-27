package view {
	import flash.events.Event;
	import game.ui.comps.RadioGroupTestUI;
	
	/**单选框示例*/
	public class RadioGroupTest extends RadioGroupTestUI {
		
		public function RadioGroupTest() {
			radioGroup1.addEventListener(Event.SELECT, onRadioGroupSelect);
			radioGroup2.addEventListener(Event.SELECT, onRadioGroupSelect);
		}
		
		private function onRadioGroupSelect(e:Event):void {
			trace(radioGroup1.selectedIndex);
			trace(radioGroup2.selectedValue);
		}
	}
}