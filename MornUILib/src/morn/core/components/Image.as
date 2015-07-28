/**
 * Morn UI Version 3.2 http://www.mornui.com/
 * Feedback yungvip@163.com weixin:yungzhu
 */
package morn.core.components {
	import flash.display.BitmapData;
	import morn.core.events.UIEvent;
	import morn.core.handlers.Handler;
	import morn.core.utils.StringUtils;
	
	/**图片被加载后触发*/
	[Event(name="imageLoaded",type="morn.core.events.UIEvent")]
	
	/**图像类*/
	public class Image extends Component {
		protected var _bitmap:AutoBitmap;
		protected var _url:String;
		
		public function Image(url:String = null) {
			this.url = url;
		}
		
		override protected function createChildren():void {
			addChild(_bitmap = new AutoBitmap());
		}
		
		/**图片地址，如果值为已加载资源，会马上显示，否则会先加载后显示，加载后图片会自动进行缓存
		 * 举例：url="png.comp.bg" 或者 url="assets/img/face.png"*/
		public function get url():String {
			return _url;
		}
		
		public function set url(value:String):void {
			if (_url != value) {
				_url = value;
				if (Boolean(value)) {
					if (App.asset.hasClass(_url)) {
						bitmapData = App.asset.getBitmapData(_url);
					} else {
						App.mloader.loadBMD(_url, 1, new Handler(setBitmapData, [_url]));
					}
				} else {
					bitmapData = null;
				}
			}
		}
		
		/**图片地址，等同于url*/
		public function get skin():String {
			return _url;
		}
		
		public function set skin(value:String):void {
			url = value;
		}
		
		/**源位图数据*/
		public function get bitmapData():BitmapData {
			return _bitmap.bitmapData;
		}
		
		public function set bitmapData(value:BitmapData):void {
			if (value) {
				_contentWidth = value.width;
				_contentHeight = value.height;
			}
			_bitmap.bitmapData = value;
			sendEvent(UIEvent.IMAGE_LOADED);
		}
		
		protected function setBitmapData(url:String, bmd:BitmapData):void {
			if (url == _url) {
				bitmapData = bmd;
			}
		}
		
		override public function set width(value:Number):void {
			super.width = value;
			_bitmap.width = width;
		}
		
		override public function set height(value:Number):void {
			super.height = value;
			_bitmap.height = height;
		}
		
		/**九宫格信息，格式：左边距,上边距,右边距,下边距,是否重复填充(值为0或1)，例如：4,4,4,4,1*/
		public function get sizeGrid():String {
			if (_bitmap.sizeGrid) {
				return _bitmap.sizeGrid.join(",");
			}
			return null;
		}
		
		public function set sizeGrid(value:String):void {
			_bitmap.sizeGrid = StringUtils.fillArray(Styles.defaultSizeGrid, value, int);
		}
		
		/**位图控件实例*/
		public function get bitmap():AutoBitmap {
			return _bitmap;
		}
		
		/**是否对位图进行平滑处理*/
		public function get smoothing():Boolean {
			return _bitmap.smoothing;
		}
		
		public function set smoothing(value:Boolean):void {
			_bitmap.smoothing = value;
		}
		
		/**X锚点，值为0-1*/
		public function get anchorX():Number {
			return _bitmap.anchorX;
		}
		
		public function set anchorX(value:Number):void {
			_bitmap.anchorX = value;
		}
		
		/**Y锚点，值为0-1*/
		public function get anchorY():Number {
			return _bitmap.anchorY;
		}
		
		public function set anchorY(value:Number):void {
			_bitmap.anchorY = value;
		}
		
		override public function set dataSource(value:Object):void {
			_dataSource = value;
			if (value is String) {
				url = String(value);
			} else {
				super.dataSource = value;
			}
		}
		
		/**销毁资源，从位图缓存中销毁掉
		 * @param	clearFromLoader 是否同时删除加载缓存*/
		public function destory(clearFromLoader:Boolean = false):void {
			App.asset.disposeBitmapData(_url);
			if (clearFromLoader) {
				App.mloader.clearResLoaded(_url);
			}
			dispose();
		}
		
		/**销毁*/
		override public function dispose():void {
			super.dispose();
			_bitmap && _bitmap.dispose();
			_bitmap = null;
		}
	}
}