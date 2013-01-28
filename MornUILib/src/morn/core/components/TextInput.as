/**
 * Version 0.9.4.1.3 https://github.com/yungzhu/morn
 * Feedback yungzhu@gmail.com http://weibo.com/newyung
 */
package morn.core.components {
	import flash.events.Event;
	import flash.text.TextFieldType;

	/**输入框*/
	public class TextInput extends Label {
		
		public function TextInput(text:String = null) {
			super(text);
		}
		
		override protected function preinitialize():void {
			super.preinitialize();
			_width = 128;
			_height = 22;
		}
		
		override protected function initialize():void {
			super.initialize();
			_textField.type = TextFieldType.INPUT;
			_textField.autoSize = "none";
			selectable = true;

			//要让控件真正能接收输入 并且能取的出来
			_textField.addEventListener(Event.CHANGE,onInput);
		}
		
		private function onInput(evt:Event):void
		{
			_text = _textField.text;
		}
		
		/**指示用户可以输入到控件的字符集*/
		public function get restrict():String {
			return _textField.restrict;
		}
		
		public function set restrict(value:String):void {
			_textField.restrict = value;
		}
		
		/**是否可编辑*/
		public function get editable():Boolean {
			return _textField.type == TextFieldType.INPUT;
		}
		
		public function set editable(value:Boolean):void {
			_textField.type = value ? TextFieldType.INPUT : TextFieldType.DYNAMIC;
		}
	}
}
