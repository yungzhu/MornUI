/**
 * Morn UI Version 3.0 http://www.mornui.com/
 * Feedback yungzhu@gmail.com http://weibo.com/newyung
 */
package morn.core.components {
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import morn.core.utils.BitmapUtils;
	
	/**增强的Bitmap，封装了位置，宽高及九宫格的处理，供组件使用*/
	public final class AutoBitmap extends Bitmap {
		private var _width:Number;
		private var _height:Number;
		private var _sizeGrid:Array;
		private var _source:Vector.<BitmapData>;
		private var _clips:Vector.<BitmapData>;
		private var _index:int;
		private var _smoothing:Boolean = Styles.smoothing;
		private var _anchorX:Number;
		private var _anchorY:Number;
		
		public function AutoBitmap() {
		}
		
		/**宽度(显示时四舍五入)*/
		override public function get width():Number {
			return isNaN(_width) ? (super.bitmapData ? super.bitmapData.width : super.width) : _width;
		}
		
		override public function set width(value:Number):void {
			if (_width != value) {
				_width = value;
				App.render.callLater(changeSize);
			}
		}
		
		/**高度(显示时四舍五入)*/
		override public function get height():Number {
			return isNaN(_height) ? (super.bitmapData ? super.bitmapData.height : super.height) : _height;
		}
		
		override public function set height(value:Number):void {
			if (_height != value) {
				_height = value;
				App.render.callLater(changeSize);
			}
		}
		
		/**九宫格信息，格式：左边距,上边距,右边距,下边距,是否重复填充(值为0或1)，例如：4,4,4,4,1*/
		public function get sizeGrid():Array {
			return _sizeGrid;
		}
		
		public function set sizeGrid(value:Array):void {
			_sizeGrid = value;
			App.render.callLater(changeSize);
		}
		
		override public function set bitmapData(value:BitmapData):void {
			if (value) {
				clips = new <BitmapData>[value];
			} else {
				disposeTempBitmapdata();
				_source = _clips = null;
				super.bitmapData = null;
			}
		}
		
		/**位图切片集合*/
		public function get clips():Vector.<BitmapData> {
			return _source;
		}
		
		public function set clips(value:Vector.<BitmapData>):void {
			disposeTempBitmapdata();
			_source = value;
			if (value && value.length > 0) {
				super.bitmapData = value[0];
				App.render.callLater(changeSize);
			}
		}
		
		/**当前切片索引*/
		public function get index():int {
			return _index;
		}
		
		public function set index(value:int):void {
			_index = value;
			if (_clips && _clips.length > 0) {
				_index = (_index < _clips.length && _index > -1) ? _index : 0;
				super.bitmapData = _clips[_index];
				super.smoothing = _smoothing;
			}
		}
		
		private function changeSize():void {
			if (_source && _source.length > 0) {
				var w:int = Math.round(width);
				var h:int = Math.round(height);
				//清理临时位图数据
				disposeTempBitmapdata();
				//重新生成新位图
				var temp:Vector.<BitmapData> = new Vector.<BitmapData>();
				for (var i:int = 0, n:int = _source.length; i < n; i++) {
					if (_sizeGrid) {
						temp.push(BitmapUtils.scale9Bmd(_source[i], _sizeGrid, w, h));
					} else {
						temp.push(_source[i]);
					}
				}
				_clips = temp;
				index = _index;
				super.width = w;
				super.height = h;
			}
			if (!isNaN(_anchorX)) {
				super.x = -Math.round(_anchorX * width);
			}
			if (!isNaN(_anchorY)) {
				super.y = -Math.round(_anchorY * height);
			}
		}
		
		/**销毁临时位图*/
		private function disposeTempBitmapdata():void {
			if (_clips) {
				for (var i:int = _clips.length - 1; i > -1; i--) {
					if (_clips[i] != _source[i]) {
						_clips[i].dispose();
					}
				}
				_clips.length = 0;
			}
		}
		
		/**是否平滑处理*/
		override public function get smoothing():Boolean {
			return _smoothing;
		}
		
		override public function set smoothing(value:Boolean):void {
			super.smoothing = _smoothing = value;
		}
		
		/**X锚点，值为0-1*/
		public function get anchorX():Number {
			return _anchorX;
		}
		
		public function set anchorX(value:Number):void {
			_anchorX = value;
		}
		
		/**Y锚点，值为0-1*/
		public function get anchorY():Number {
			return _anchorY;
		}
		
		public function set anchorY(value:Number):void {
			_anchorY = value;
		}
		
		/**销毁*/
		public function dispose():void {
			bitmapData = null;
		}
	}
}