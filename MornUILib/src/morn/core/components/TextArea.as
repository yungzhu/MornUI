/**
 * Morn UI Version 2.3.0810 http://code.google.com/p/morn https://github.com/yungzhu/morn
 * Feedback yungzhu@gmail.com http://weibo.com/newyung
 */
package morn.core.components {
	import flash.events.Event;
	import morn.core.events.UIEvent;
	
	/**当滚动内容时调用*/
	[Event(name="scroll",type="morn.core.events.UIEvent")]
	
	/**文本域*/
	public class TextArea extends TextInput {
		protected var _scrollBar:VScrollBar;
		
		public function TextArea(text:String = null) {
			super(text);
		}
		
		override protected function createChildren():void {
			super.createChildren();
			addChild(_scrollBar = new VScrollBar());
		}
		
		override protected function initialize():void {
			super.initialize();
			width = 180;
			height = 150;
			_textField.wordWrap = true;
			_textField.multiline = true;
			_textField.addEventListener(Event.SCROLL, onTextFieldScroll);
			_scrollBar.addEventListener(Event.CHANGE, onScrollBarChange);
		}
		
		override protected function changeSize():void {
			_textField.width = _width - _margin[0] - _margin[2];
			_textField.height = _height - _margin[1] - _margin[3];
			if (Boolean(_scrollBar.skin)) {
				_textField.width = _width - _scrollBar.width - 4 - _margin[0] - _margin[2];
				_scrollBar.height = _height - 2;
				_scrollBar.x = _width - _scrollBar.width - 2;
				_scrollBar.y = 1;
				App.timer.doFrameOnce(1, onTextFieldScroll, [null]);
			}
		}
		
		protected function onScrollBarChange(e:Event):void {
			_textField.scrollV = Math.round(_scrollBar.value);
			sendEvent(UIEvent.SCROLL);
		}
		
		protected function onTextFieldScroll(e:Event):void {
			if (Boolean(_scrollBar.skin)) {
				if (_textField.maxScrollV < 2) {
					_scrollBar.visible = false;
				} else {
					_scrollBar.visible = true;
					_scrollBar.thumbPercent = (_textField.numLines - _textField.maxScrollV + 1) / _textField.numLines;
					_scrollBar.setScroll(1, _textField.maxScrollV, _textField.scrollV);
				}
			}
		}
		
		/**滚动条皮肤*/
		public function get scrollBarSkin():String {
			return _scrollBar.skin;
		}
		
		public function set scrollBarSkin(value:String):void {
			_scrollBar.skin = value;
			callLater(changeSize);
		}
		
		/**滚动条实体*/
		public function get scrollBar():VScrollBar {
			return _scrollBar;
		}
		
		/**垂直滚动最大值*/
		public function get maxScrollV():int {
			return _textField.maxScrollV;
		}
		
		/**滚动到某个位置*/
		public function scroll(value:int):void {
			commitMeasure();
			_scrollBar.value = value;
		}
	}
}