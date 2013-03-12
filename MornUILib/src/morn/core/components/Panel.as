/**
 * Morn UI Version 1.2.0312 http://code.google.com/p/morn https://github.com/yungzhu/morn
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
		protected var _vScrollBar:VScrollBar;
		protected var _hScrollBar:HScrollBar;
		
		public function Panel() {
			width = height = 100;
		}
		
		override protected function createChildren():void {
			super.addChild(_content = new Sprite());
			super.addChild(_mask = new Bitmap(new BitmapData(1, 1, false, 0x000000)));
		}
		
		override protected function initialize():void {
			_content.mask = _mask;
		}
		
		override public function addChild(child:DisplayObject):DisplayObject {
			callLater(changeScroll);
			return _content.addChild(child);
		}
		
		override public function addChildAt(child:DisplayObject, index:int):DisplayObject {
			callLater(changeScroll);
			return _content.addChildAt(child, index);
		}
		
		override public function removeChild(child:DisplayObject):DisplayObject {
			callLater(changeScroll);
			return _content.removeChild(child);
		}
		
		override public function removeChildAt(index:int):DisplayObject {
			callLater(changeScroll);
			return _content.removeChildAt(index);
		}
		
		override public function getChildAt(index:int):DisplayObject {
			return _content.getChildAt(index);
		}
		
		override public function getChildByName(name:String):DisplayObject {
			return _content.getChildByName(name);
		}
		
		override public function getChildIndex(child:DisplayObject):int {
			return _content.getChildIndex(child);
		}
		
		override public function get numChildren():int {
			return _content.numChildren;
		}
		
		private function changeScroll():void {
			var vShow:Boolean = _vScrollBar && _content.height > _height;
			var hShow:Boolean = _hScrollBar && _content.width > _width;
			_mask.width = vShow ? _width - _vScrollBar.width : _width;
			_mask.height = hShow ? _height - _hScrollBar.height : _height;
			if (_vScrollBar) {
				_vScrollBar.visible = _content.height > _height;
				if (_vScrollBar.visible) {
					_vScrollBar.x = _width - _vScrollBar.width;
					_vScrollBar.y = 0;
					_vScrollBar.height = _height - (hShow ? _hScrollBar.height : 0);
					_vScrollBar.setScroll(0, _content.height - _mask.height, 0);
				}
			}
			if (_hScrollBar) {
				_hScrollBar.visible = _content.width > _width;
				if (_hScrollBar.visible) {
					_hScrollBar.x = 0;
					_hScrollBar.y = _height - _hScrollBar.height;
					_hScrollBar.width = _width - (vShow ? _vScrollBar.width : 0);
					_hScrollBar.setScroll(0, _content.width - _mask.width, 0);
				}
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
		
		/**垂直滚动条皮肤*/
		public function get vScrollBarSkin():String {
			return _vScrollBar.skin;
		}
		
		public function set vScrollBarSkin(value:String):void {
			if (_vScrollBar == null) {
				super.addChild(_vScrollBar = new VScrollBar());
				_vScrollBar.addEventListener(Event.CHANGE, onScrollBarChange);
				addEventListener(MouseEvent.MOUSE_WHEEL, onMouseWheel);
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
				super.addChild(_hScrollBar = new HScrollBar());
				_hScrollBar.addEventListener(Event.CHANGE, onScrollBarChange);
				callLater(changeScroll);
			}
			_hScrollBar.skin = value;
		}
		
		/**垂直滚动条*/
		public function get vScrollBar():ScrollBar {
			return _vScrollBar;
		}
		
		/**水平滚动条*/
		public function get hScrollBar():ScrollBar {
			return _hScrollBar;
		}
		
		protected function onScrollBarChange(e:Event):void {
			var scroll:ScrollBar = e.currentTarget as ScrollBar;
			var start:int = Math.round(scroll.value);
			if (scroll.direction == ScrollBar.VERTICAL) {
				_content.y = -start;
			} else {
				_content.x = -start;
			}
		}
		
		protected function onMouseWheel(e:MouseEvent):void {
			_vScrollBar.value -= e.delta;
		}
		
		override public function removeAllChild(except:DisplayObject = null):void {
			for (var i:int = _content.numChildren - 1; i > -1; i--) {
				if (except != _content.getChildAt(i)) {
					_content.removeChildAt(i);
				}
			}
			callLater(changeScroll);
		}
	}
}