/**
 * Morn UI Version 3.0 http://www.mornui.com/
 * Feedback yungzhu@gmail.com http://weibo.com/newyung
 */
package morn.core.components {
	import flash.events.Event;
	import morn.core.events.UIEvent;
	
	/**当滚动内容时调用*/
	[Event(name="scroll",type="morn.core.events.UIEvent")]
	
	/**文本域*/
	public class TextArea extends TextInput {
		protected var _vScrollBar:VScrollBar;
		protected var _hScrollBar:HScrollBar;
		
		public function TextArea(text:String = "") {
			super(text);
		}
		
		override protected function initialize():void {
			super.initialize();
			width = 180;
			height = 150;
			_textField.wordWrap = true;
			_textField.multiline = true;
			_textField.addEventListener(Event.SCROLL, onTextFieldScroll);
		}
		
		override public function set width(value:Number):void {
			super.width = value;
			callLater(changeScroll);
		}
		
		override public function set height(value:Number):void {
			super.height = value;
			callLater(changeScroll);
		}
		
		protected function onTextFieldScroll(e:Event):void {
			changeScroll();
			sendEvent(UIEvent.SCROLL);
		}
		
		/**垂直滚动条皮肤(兼容老版本，建议使用vScrollBarSkin)*/
		public function get scrollBarSkin():String {
			return _vScrollBar.skin;
		}
		
		public function set scrollBarSkin(value:String):void {
			vScrollBarSkin = value;
		}
		
		/**垂直滚动条皮肤*/
		public function get vScrollBarSkin():String {
			return _vScrollBar.skin;
		}
		
		public function set vScrollBarSkin(value:String):void {
			if (_vScrollBar == null) {
				addChild(_vScrollBar = new VScrollBar());
				_vScrollBar.addEventListener(Event.CHANGE, onScrollBarChange);
				_vScrollBar.target = _textField;
				callLater(changeScroll);
			}
			_vScrollBar.skin = value;
		}
		
		/**水平滚动条皮肤*/
		public function get hScrollBarSkin():String {
			return _hScrollBar.skin;
		}
		
		public function set hScrollBarSkin(value:String):void {
			if (_hScrollBar == null) {
				addChild(_hScrollBar = new HScrollBar());
				_hScrollBar.addEventListener(Event.CHANGE, onScrollBarChange);
				_hScrollBar.mouseWheelEnable = false;
				_hScrollBar.target = _textField;
				callLater(changeScroll);
			}
			_hScrollBar.skin = value;
		}
		
		/**垂直滚动条实体，(兼容老版本，建议用vScrollBar)*/
		public function get scrollBar():VScrollBar {
			return _vScrollBar;
		}
		
		/**垂直滚动条实体*/
		public function get vScrollBar():VScrollBar {
			return _vScrollBar;
		}
		
		/**水平滚动条实体*/
		public function get hScrollBar():HScrollBar {
			return _hScrollBar;
		}
		
		/**垂直滚动最大值*/
		public function get maxScrollV():int {
			return _textField.maxScrollV;
		}
		
		/**垂直滚动值*/
		public function get scrollV():int {
			return _textField.scrollV;
		}
		
		/**水平滚动最大值*/
		public function get maxScrollH():int {
			return _textField.maxScrollH;
		}
		
		/**水平滚动值*/
		public function get scrollH():int {
			return _textField.scrollH;
		}
		
		protected function onScrollBarChange(e:Event):void {
			if (e.currentTarget == _vScrollBar) {
				if (_textField.scrollV != _vScrollBar.value) {
					_textField.removeEventListener(Event.SCROLL, onTextFieldScroll);
					_textField.scrollV = _vScrollBar.value;
					_textField.addEventListener(Event.SCROLL, onTextFieldScroll);
					sendEvent(UIEvent.SCROLL);
				}
			} else {
				if (_textField.scrollH != _hScrollBar.value) {
					_textField.removeEventListener(Event.SCROLL, onTextFieldScroll);
					_textField.scrollH = _hScrollBar.value;
					_textField.addEventListener(Event.SCROLL, onTextFieldScroll);
					sendEvent(UIEvent.SCROLL);
				}
			}
		}
		
		private function changeScroll():void {
			var vShow:Boolean = _vScrollBar && _textField.maxScrollV > 1;
			var hShow:Boolean = _hScrollBar && _textField.maxScrollH > 0;
			var showWidth:Number = vShow ? _width - _vScrollBar.width : _width;
			var showHeight:Number = hShow ? _height - _hScrollBar.height : _height;
			
			_textField.width = showWidth - _margin[0] - _margin[2];
			_textField.height = showHeight - _margin[1] - _margin[3];
			
			if (_vScrollBar) {
				_vScrollBar.x = _width - _vScrollBar.width - _margin[2];
				_vScrollBar.y = _margin[1];
				_vScrollBar.height = _height - (hShow ? _hScrollBar.height : 0) - _margin[1] - _margin[3];
				_vScrollBar.scrollSize = 1;
				_vScrollBar.thumbPercent = (_textField.numLines - _textField.maxScrollV + 1) / _textField.numLines;
				_vScrollBar.setScroll(1, _textField.maxScrollV, _textField.scrollV)
			}
			if (_hScrollBar) {
				_hScrollBar.x = _margin[0];
				_hScrollBar.y = _height - _hScrollBar.height - _margin[3];
				_hScrollBar.width = _width - (vShow ? _vScrollBar.width : 0) - _margin[0] - _margin[2];
				_hScrollBar.scrollSize = Math.max(showWidth * 0.033, 1);
				_hScrollBar.thumbPercent = showWidth / Math.max(_textField.textWidth, showWidth);
				_hScrollBar.setScroll(0, maxScrollH, scrollH);
			}
		}
		
		/**滚动到某个位置，单位是行*/
		public function scrollTo(line:int):void {
			commitMeasure();
			_textField.scrollV = line;
		}
	}
}