/**
 * Version 0.9.4.1.3 https://github.com/yungzhu/morn
 * Feedback yungzhu@gmail.com http://weibo.com/newyung
 */
package morn.core.components {
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import morn.editor.core.IContent;
	
	/**面板*/
	public class Panel extends Box implements IContent {
		protected var _content:Sprite;
		protected var _mask:Bitmap;
		protected var _scrollBar:ScrollBar;
		
		public function Panel() {
			width = height = 100;
		}
		
		override protected function createChildren():void {
			super.addChild(_content = new Sprite());
			super.addChild(_scrollBar = new ScrollBar());
			super.addChild(_mask = new Bitmap(new BitmapData(1, 1, false, 0x000000)));
		}
		
		override protected function initialize():void {
			_content.mask = _mask;
			_scrollBar.addEventListener(Event.CHANGE, onScrollBarChange);
			addEventListener(MouseEvent.MOUSE_WHEEL, onMouseWheel);
		}
		
		protected function onScrollBarChange(e:Event):void {
			var start:int = Math.round(_scrollBar.value);
			if (_scrollBar.direction == ScrollBar.VERTICAL) {
				_content.y = -start;
			} else {
				_content.x = -start;
			}
		}
		
		protected function onMouseWheel(e:MouseEvent):void {
			_scrollBar.value -= e.delta;
		}
		
		override public function addChild(child:DisplayObject):DisplayObject {
			callLater(changeScroll);
			return _content.addChild(child);
		}
		
		override public function removeChild(child:DisplayObject):DisplayObject {
			callLater(changeScroll);
			return _content.removeChild(child);
		}
		
		override protected function changeSize():void {
			_mask.width = _width;
			_mask.height = _height;
			if (_scrollBar.direction == ScrollBar.VERTICAL) {
				_scrollBar.x = _width - _scrollBar.width;
				_scrollBar.y = 0;
				_scrollBar.height = _height;
			} else {
				_scrollBar.x = 0;
				_scrollBar.y = _height - _scrollBar.height;
				_scrollBar.width = _width;
			}
			super.changeSize();
		}
		
		private function changeScroll():void {
			if (_scrollBar.direction == ScrollBar.VERTICAL) {
				_scrollBar.visible = _content.height > _height;
				_scrollBar.setScroll(0, _content.height - _height, 0);
			} else {
				_scrollBar.visible = _content.width > _width;
				_scrollBar.setScroll(0, _content.width - _width, 0);
			}
		}
		
		override public function set width(value:Number):void {
			super.width = value;
			callLater(changeScroll);
		}
		
		override public function set height(value:Number):void {
			super.height = value;
			callLater(changeScroll);
		}
		
		/**内容容器*/
		public function get content():Sprite {
			return _content;
		}
		
		/**滚动条皮肤*/
		public function get scrollBarSkin():String {
			return _scrollBar.skin;
		}
		
		public function set scrollBarSkin(value:String):void {
			_scrollBar.skin = value;
		}
		
		/**滚动条*/
		public function get scrollBar():ScrollBar {
			return _scrollBar;
		}
		
		/**滚动方向*/
		public function get direction():String {
			return _scrollBar.direction;
		}
		
		public function set direction(value:String):void {
			_scrollBar.direction = value;
		}
		
		override public function removeAllChild():void {
			for (var i:int = _content.numChildren - 1; i > -1; i--) {
				_content.removeChildAt(i);
			}
			callLater(changeScroll);
		}
	}
}