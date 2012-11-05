/**
 * Version 0.9.0 https://github.com/yungzhu/morn
 * Feedback yungzhu@gmail.com http://weibo.com/newyung
 * Copyright 2012, yungzhu. All rights reserved.
 * This program is free software. You can redistribute and/or modify it
 * in accordance with the terms of the accompanying license agreement.
 */
package morn.core.components {
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
			selectable = true;
			_textField.type = TextFieldType.INPUT;
			_textField.autoSize = "none";
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