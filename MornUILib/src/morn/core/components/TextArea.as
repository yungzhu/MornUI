/**
 * Morn UI Version 2.4.1027 http://www.mornui.com/
 * Feedback yungzhu@gmail.com http://weibo.com/newyung
 */
package morn.core.components {
	import flash.events.Event;
	import morn.core.events.UIEvent;
	import morn.core.utils.ObjectUtils;
	
	/**当滚动内容时调用*/
	[Event(name="scroll",type="morn.core.events.UIEvent")]
	
	/**文本域*/
	public class TextArea extends TextInput {
		protected var _scrollBar:VScrollBar;
		protected var _lineHeight:Number;
		
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
				_textField.width = _textField.width - _scrollBar.width - 2;
				_scrollBar.height = _height - _margin[1] - _margin[3];
				_scrollBar.x = _width - _scrollBar.width - _margin[2];
				_scrollBar.y = _margin[1];
				App.timer.doFrameOnce(1, onTextFieldScroll, [null]);
			}
		}
		
		override protected function changeText():void {
			super.changeText();
			_lineHeight = ObjectUtils.getTextField(_format).textHeight;
		}
		
		protected function onScrollBarChange(e:Event):void {
			var scrollValue:int = _scrollBar.value / _lineHeight;
			if (_textField.scrollV != scrollValue) {
				_textField.removeEventListener(Event.SCROLL, onTextFieldScroll);
				_textField.scrollV = scrollValue;
				_textField.addEventListener(Event.SCROLL, onTextFieldScroll);
				sendEvent(UIEvent.SCROLL);
			}
		}
		
		protected function onTextFieldScroll(e:Event):void {
			if (Boolean(_scrollBar.skin)) {
				if (_textField.maxScrollV < 2) {
					_scrollBar.visible = false;
				} else {
					_scrollBar.visible = true;
					_scrollBar.target = this;
					_scrollBar.thumbPercent = (_textField.numLines - _textField.maxScrollV + 1) / _textField.numLines;
					_scrollBar.scrollSize = _lineHeight;
					_scrollBar.setScroll(_lineHeight, _textField.maxScrollV * _lineHeight, _textField.scrollV * _lineHeight);
				}
			}
			sendEvent(UIEvent.SCROLL);
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
		
		/**滚动到某个位置，单位是行*/
		public function scrollTo(line:int):void {
			commitMeasure();
			_textField.scrollV = line;
		}
	}
}