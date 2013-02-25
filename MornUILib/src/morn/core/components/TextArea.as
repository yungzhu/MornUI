/**
 * Morn UI Version 1.1.0224 http://code.google.com/p/morn https://github.com/yungzhu/morn
 * Feedback yungzhu@gmail.com http://weibo.com/newyung
 */
package morn.core.components {
	import flash.events.Event;
	
	/**文本域*/
	public class TextArea extends TextInput {
		protected var _scrollBar:VScrollBar;
		
		public function TextArea(text:String = null) {
			super(text);
		}
		
		override protected function preinitialize():void {
			super.preinitialize();
			width = 180;
			height = 150;
		}
		
		override protected function createChildren():void {
			super.createChildren();
			addChild(_scrollBar = new VScrollBar());
		}
		
		override protected function initialize():void {
			super.initialize();
			_textField.wordWrap = true;
			_textField.multiline = true;
			_textField.addEventListener(Event.SCROLL, onTextFieldScroll);
			_scrollBar.addEventListener(Event.CHANGE, onScrollBarChange);
		}
		
		override protected function changeSize():void {
			_textField.width = _width - _scrollBar.width - 4;
			_textField.height = _height;
			_scrollBar.height = _height;
			_scrollBar.x = _width - _scrollBar.width;
		}
		
		protected function onScrollBarChange(e:Event):void {
			_textField.scrollV = Math.round(_scrollBar.value);
		}
		
		protected function onTextFieldScroll(e:Event):void {
			_scrollBar.setScroll(1, _textField.maxScrollV, _textField.scrollV);
		}
		
		/**滚动条皮肤*/
		public function get scrollBarSkin():String {
			return _scrollBar.skin;
		}
		
		public function set scrollBarSkin(value:String):void {
			_scrollBar.skin = value;
		}
	}
}