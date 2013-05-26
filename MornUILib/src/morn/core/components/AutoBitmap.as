/**
 * Morn UI Version 2.0.0526 http://code.google.com/p/morn https://github.com/yungzhu/morn
 * Feedback yungzhu@gmail.com http://weibo.com/newyung
 */
package morn.core.components {
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import morn.core.utils.BitmapUtils;
	
	/**增强的Bitmap，封装了位置，宽高及9宫格的处理，供组件使用*/
	public final class AutoBitmap extends Bitmap {
		private var _x:Number = 0;
		private var _y:Number = 0;
		private var _width:Number;
		private var _height:Number;
		private var _sizeGrid:Array;
		private var _source:BitmapData;
		
		private var _isClip:Boolean;
		private var _clips:Vector.<BitmapData>;
		private var _clipSource:Vector.<BitmapData>;
		private var _clipIndex:int;
		
		public function AutoBitmap(isClip:Boolean) {
			_isClip = isClip;
		}
		
		/**X坐标(显示时四舍五入)*/
		override public function get x():Number {
			return _x;
		}
		
		override public function set x(value:Number):void {
			_x = value;
			super.x = Math.round(value);
		}
		
		/**Y坐标(显示时四舍五入)*/
		override public function get y():Number {
			return _y;
		}
		
		override public function set y(value:Number):void {
			_y = value;
			super.y = Math.round(value);
		}
		
		/**宽度(显示时四舍五入)*/
		override public function get width():Number {
			return !isNaN(_width) ? _width : super.width;
		}
		
		override public function set width(value:Number):void {
			if (_width != value) {
				_width = value;
				callChange();
			}
		}
		
		/**高度(显示时四舍五入)*/
		override public function get height():Number {
			return !isNaN(_height) ? _height : super.height;
		}
		
		override public function set height(value:Number):void {
			if (_height != value) {
				_height = value;
				callChange();
			}
		}
		
		override public function set bitmapData(value:BitmapData):void {
			_source = super.bitmapData = value;
			App.render.callLater(changeSize);
			if (_clips && value == null) {
				_clips.length = 0;
				_clipSource.length = 0;
			}
		}
		
		/**9宫格(格式：左间距,上间距,右间距,下间距)*/
		public function get sizeGrid():Array {
			return _sizeGrid;
		}
		
		public function set sizeGrid(value:Array):void {
			_sizeGrid = value;
			callChange();
		}
		
		private function callChange():void {
			if (_isClip) {
				App.render.callLater(changeClips);
			} else {
				App.render.callLater(changeSize);
			}
		}
		
		private function changeSize():void {
			if (super.bitmapData) {
				var w:int = Math.round(width);
				var h:int = Math.round(height);
				if (_sizeGrid == null) {
					super.width = w;
					super.height = h;
				} else {
					//清理临时位图数据
					if (super.bitmapData != _source) {
						super.bitmapData.dispose();
					}
					super.bitmapData = BitmapUtils.scale9Bmd(_source, _sizeGrid, w, h);
				}
			}
		}
		
		/**位图切片集合*/
		public function get clips():Vector.<BitmapData> {
			return _clips;
		}
		
		public function set clips(value:Vector.<BitmapData>):void {
			_clipSource = _clips = value;
			if (_clips) {
				super.bitmapData = _clipSource[0];
			}
			App.render.callLater(changeClips);
		}
		
		/**当前切片索引*/
		public function get clipIndex():int {
			return _clipIndex;
		}
		
		public function set clipIndex(value:int):void {
			_clipIndex = value;
			if (_clips) {
				_clipIndex = (_clipIndex < _clips.length && _clipIndex > -1) ? _clipIndex : 0;
				super.bitmapData = _clips[_clipIndex];
			}
		}
		
		protected function changeClips():void {
			if (_clipSource) {
				var w:int = Math.round(width);
				var h:int = Math.round(height);
				var temp:Vector.<BitmapData> = new Vector.<BitmapData>();
				for (var i:int = 0, n:int = _clipSource.length; i < n; i++) {
					//清理临时位图数据
					if (_clips[i] != _clipSource[i]) {
						_clips[i].dispose();
					}
					if (_sizeGrid) {
						temp.push(BitmapUtils.scale9Bmd(_clipSource[i], _sizeGrid, w, h));
					} else {
						temp.push(_clipSource[i]);
					}
				}
				_clips = temp;
				clipIndex = _clipIndex;
				if (_sizeGrid == null) {
					super.width = w;
					super.height = h;
				}
			}
		}
	}
}