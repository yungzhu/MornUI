/**
 * Morn UI Version 1.1.0313 http://code.google.com/p/morn https://github.com/yungzhu/morn
 * Feedback yungzhu@gmail.com http://weibo.com/newyung
 */
package morn.core.components {
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import morn.core.events.UIEvent;
	import morn.core.handlers.Handler;
	import morn.core.managers.ResLoader;
	import morn.core.utils.BitmapUtils;
	import morn.core.utils.StringUtils;
	
	/**图片被加载后触发*/
	[Event(name="imageLoaded",type="morn.core.events.UIEvent")]
	
	/**图像类*/
	public class Image extends Component {
		protected var _bitmap:Bitmap;
		protected var _sizeGrid:Array;
		protected var _url:String;
		
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
				if (App.asset.hasClass(_url)) {
					bitmapData = App.asset.getBitmapData(_url);
				} else {
					App.loader.loadBMD(_url, new Handler(setBitmapData));
				}
			}
		}
		
		/**源位图数据*/
		public function set bitmapData(value:BitmapData):void {
			if (value) {
				_contentWidth = value.width;
				_contentHeight = value.height;
				_bitmap.bitmapData = value;
				callLater(changeSize);
			}
		}
		
		protected function setBitmapData(bmd:BitmapData):void {
			bitmapData = bmd;
			sendEvent(UIEvent.IMAGE_LOADED);
		}
		
		override protected function changeSize():void {
			if (_bitmap.bitmapData) {
				if (_sizeGrid == null) {
					_bitmap.width = width;
					_bitmap.height = height;
				} else {
					var source:BitmapData = App.asset.getBitmapData(_url);
					//清理临时位图数据
					if (_bitmap.bitmapData && _bitmap.bitmapData != source) {
						_bitmap.bitmapData.dispose();
					}
					_bitmap.bitmapData = BitmapUtils.scale9Bmd(source, _sizeGrid, width, height);
				}
				super.changeSize();
			}
		}
		
		/**九宫格信息(格式:左边距,上边距,右边距,下边距)*/
		public function get sizeGrid():String {
			if (_sizeGrid) {
				return _sizeGrid.join(",");
			}
			return null;
		}
		
		public function set sizeGrid(value:String):void {
			_sizeGrid = StringUtils.fillArray([4, 4, 4, 4], value);
		}
		
		/**位图控件*/
		public function get bitmap():Bitmap {
			return _bitmap;
		}
		
		/**是否对位图进行平滑处理*/
		public function get smoothing():Boolean {
			return _bitmap.smoothing;
		}
		
		public function set smoothing(value:Boolean):void {
			_bitmap.smoothing = value;
		}
		
		override public function set dataSource(value:Object):void {
			if (value is String) {
				url = value as String;
			} else {
				super.dataSource = value;
			}
		}
		
		/**销毁资源*/
		public function destroy(clearFromLoader:Boolean = false):void {
			App.asset.destroyBitmapData(_url);
			_bitmap.bitmapData = null;
			if (clearFromLoader) {
				ResLoader.clearResLoaded(_url);
			}
		}
	}
}