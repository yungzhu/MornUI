/**
 * Version 0.9.9 https://github.com/yungzhu/morn
 * Feedback yungzhu@gmail.com http://weibo.com/newyung
 * Copyright 2012, yungzhu. All rights reserved.
 * This program is free software. You can redistribute and/or modify it
 * in accordance with the terms of the accompanying license agreement.
 */
package morn.core.components {
	import morn.core.utils.ObjectUtils;
	import morn.core.utils.StringUtils;
	import flash.filters.GlowFilter;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	
	/**文字标签*/
	public class Label extends Component {
		protected var _textField:TextField;
		protected var _format:TextFormat;
		protected var _text:String = "";
		protected var _isHtml:Boolean;
		protected var _stroke:String;
		
		public function Label(text:String = "") {
			this.text = text;
		}
		
		override protected function preinitialize():void {
			mouseEnabled = false;
			_format = new TextFormat(Styles.fontName, Styles.fontSize, Styles.labelColor);
		}
		
		override protected function createChildren():void {
			addChild(_textField = new TextField());
		}
		
		override protected function initialize():void {
			_textField.selectable = false;
			_textField.autoSize = TextFieldAutoSize.LEFT;
		}
		
		/**显示文本*/
		public function get text():String {
			return _text;
		}
		
		public function set text(value:String):void {
			if (_text != value) {
				_text = value || "";
				callLater(changeText);
			}
		}
		
		protected function changeText():void {
			_textField.defaultTextFormat = _format;
			_isHtml ? _textField.htmlText = _text : _textField.text = _text;
		}
		
		override protected function changeSize():void {
			if (_width != 0) {
				_textField.autoSize = TextFieldAutoSize.NONE;
				_textField.width = _width;
				_textField.height = _height == 0 ? 18 : _height;
			} else {
				_width = _height = 0;
				_textField.autoSize = TextFieldAutoSize.LEFT;
			}
			super.changeSize();
		}
		
		/**是否是html格式*/
		public function get isHtml():Boolean {
			return _isHtml;
		}
		
		public function set isHtml(value:Boolean):void {
			if (_isHtml != value) {
				_isHtml = value;
				callLater(changeText);
			}
		}
		
		/**描边*/
		public function get stroke():String {
			return _stroke;
		}
		
		public function set stroke(value:String):void {
			if (_stroke != value) {
				_stroke = value;
				ObjectUtils.clearFilter(_textField, GlowFilter);
				if (StringUtils.isNotEmpty(_stroke)) {
					var a:Array = StringUtils.fillArray(Styles.labelStroke, _stroke);
					ObjectUtils.addFilter(_textField, new GlowFilter(a[0], a[1], a[2], a[3], a[4], a[5]));
				}
			}
		}
		
		/**是否是多行*/
		public function get multiline():Boolean {
			return _textField.multiline;
		}
		
		public function set multiline(value:Boolean):void {
			_textField.multiline = value;
		}
		
		/**是否是密码*/
		public function get asPassword():Boolean {
			return _textField.displayAsPassword;
		}
		
		public function set asPassword(value:Boolean):void {
			_textField.displayAsPassword = value;
		}
		
		/**宽高是否自适应*/
		public function get autoSize():String {
			return _textField.autoSize;
		}
		
		public function set autoSize(value:String):void {
			_textField.autoSize = value;
		}
		
		/**是否自动换行*/
		public function get wordWrap():Boolean {
			return _textField.wordWrap;
		}
		
		public function set wordWrap(value:Boolean):void {
			_textField.wordWrap = value;
		}
		
		/**是否可选*/
		public function get selectable():Boolean {
			return _textField.selectable;
		}
		
		public function set selectable(value:Boolean):void {
			_textField.selectable = value;
			mouseEnabled = mouseChildren = value;
		}
		
		/**字体颜色*/
		public function get color():Object {
			return _format.color;
		}
		
		public function set color(value:Object):void {
			if (String(_format.color) != String(value)) {
				_format.color = value;
				callLater(changeText);
			}
		}
		
		/**字体类型*/
		public function get font():String {
			return _format.font;
		}
		
		public function set font(value:String):void {
			_format.font = value;
			callLater(changeText);
		}
		
		/**对齐方式*/
		public function get align():String {
			return _format.align;
		}
		
		public function set align(value:String):void {
			_format.align = value;
			callLater(changeText);
		}
		
		/**粗体类型*/
		public function get bold():Object {
			return _format.bold;
		}
		
		public function set bold(value:Object):void {
			_format.bold = value;
			callLater(changeText);
		}
		
		/**垂直间距*/
		public function get leading():Object {
			return _format.leading;
		}
		
		public function set leading(value:Object):void {
			_format.leading = value;
			callLater(changeText);
		}
		
		/**第一个字符的缩进*/
		public function get indent():Object {
			return _format.indent;
		}
		
		public function set indent(value:Object):void {
			_format.indent = value;
			callLater(changeText);
		}
		
		/**字体大小*/
		public function get size():Object {
			return _format.size;
		}
		
		public function set size(value:Object):void {
			_format.size = value;
			callLater(changeText);
		}
		
		/**下划线类型*/
		public function get underline():Object {
			return _format.underline;
		}
		
		public function set underline(value:Object):void {
			_format.underline = value;
			callLater(changeText);
		}
		
		/**左侧间距*/
		public function get leftMargin():Object {
			return _format.leftMargin;
		}
		
		public function set leftMargin(value:Object):void {
			_format.leftMargin = value;
			callLater(changeText);
		}
		
		/**右侧间距*/
		public function get rightMargin():Object {
			return _format.rightMargin;
		}
		
		public function set rightMargin(value:Object):void {
			_format.rightMargin = value;
			callLater(changeText);
		}
		
		/**文本控件*/
		public function get textField():TextField {
			return _textField;
		}
		
		/**将指定的字符串追加到文本的末尾*/
		public function appendText(newText:String):void {
			_text += newText;
			callLater(changeText);
		}
	}
}