/**
 * Version 0.9.0 https://github.com/yungzhu/morn
 * Feedback yungzhu@gmail.com http://weibo.com/newyung
 * Copyright 2012, yungzhu. All rights reserved.
 * This program is free software. You can redistribute and/or modify it
 * in accordance with the terms of the accompanying license agreement.
 */
package morn.core.components {
	import morn.core.handlers.Handler;
	import morn.core.utils.BitmapUtils;
	import morn.core.utils.StringUtils;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	
	/**图像类*/
	public class Image extends Component {
		private var _bitmap:Bitmap;
		private var _sizeGrid:Array;
		private var _url:String;
		
		public function Image(url:String = null) {
			this.url = url;
		}
		
		override protected function createChildren():void {
			addChild(_bitmap = new Bitmap());
		}
		
		/**图片地址*/
		public function get url():String {
			return _url;
		}
		
		public function set url(value:String):void {
			if (_url != value && StringUtils.isNotEmpty(value)) {
				_url = value;
				var bmd:BitmapData = App.asset.getBitmapData(_url);
				if (bmd) {
					setBitmapData(bmd);
				} else {
					var fullUrl:String = Config.resUrl + _url;
					App.loader.loadBMD(fullUrl, new Handler(setBitmapData));
				}
			}
		}
		
		private function setBitmapData(bmd:BitmapData):void {
			if (bmd != null) {
				_width = _width == 0 ? bmd.width : _width;
				_height = _height == 0 ? bmd.height : _height;
				_bitmap.bitmapData = bmd;
				callLater(changeSize);
			}
			sendEvent(UIEvent.IMAGE_LOADED);
		}
		
		override protected function changeSize():void {
			if (_bitmap.bitmapData != null) {
				if (_sizeGrid == null) {
					_bitmap.width = _width;
					_bitmap.height = _height;
				} else {
					_bitmap.bitmapData = BitmapUtils.scale9Bmd(App.asset.getBitmapData(_url), _sizeGrid, _width, _height);
				}
				super.changeSize();
			}
		}
		
		/**九宫格信息*/
		public function get sizeGrid():String {
			return _sizeGrid.toString();
		}
		
		public function set sizeGrid(value:String):void {
			_sizeGrid = StringUtils.fillArray([4, 4, 4, 4], value);
		}
		
		/**位图控件*/
		public function get bitmap():Bitmap {
			return _bitmap;
		}
	}
}