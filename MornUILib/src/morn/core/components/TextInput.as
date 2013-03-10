/**
 * Morn UI Version 1.2.0309 http://code.google.com/p/morn https://github.com/yungzhu/morn
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
			width = 128;
			height = 22;
		}
		
		override protected function initialize():void {
			super.initialize();
			selectable = true;
			_textField.type = TextFieldType.INPUT;
			_textField.autoSize = "none";
			_textField.addEventListener(Event.CHANGE, onTextFieldChange);
		}
		
		protected function onTextFieldChange(e:Event):void {
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