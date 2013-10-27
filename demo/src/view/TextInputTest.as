package view {
	import flash.events.FocusEvent;
	import flash.events.TextEvent;
	import game.ui.comps.TextInputTestUI;
	
	/**输入框*/
	public class TextInputTest extends TextInputTestUI {
		
		public function TextInputTest() {
			input1.addEventListener(TextEvent.TEXT_INPUT, onInputTextInput);
			input1.addEventListener(FocusEvent.FOCUS_IN, onInput1FocusIn);
			input2.addEventListener(FocusEvent.FOCUS_IN, onInput2FocusIn);
		}
		
		private function onInput2FocusIn(e:FocusEvent):void {
			input2.text = "";
		}
		
		private function onInput1FocusIn(e:FocusEvent):void {
			input1.text = "";
		}
		
		private function onInputTextInput(e:TextEvent):void {
			trace(input1.text);
		}
	}
}