/**
 * Morn UI Version 3.0 http://www.mornui.com/
 * Feedback yungzhu@gmail.com http://weibo.com/newyung
 */
package morn.core.utils {
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.filters.BitmapFilter;
	import flash.filters.ColorMatrixFilter;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.utils.ByteArray;
	
	/**对象工具集*/
	public class ObjectUtils {
		/**添加滤镜*/
		public static function addFilter(target:DisplayObject, filter:BitmapFilter):void {
			var filters:Array = target.filters || [];
			filters.push(filter);
			target.filters = filters;
		}
		
		/**清除滤镜*/
		public static function clearFilter(target:DisplayObject, filterType:Class):void {
			var filters:Array = target.filters;
			if (filters != null && filters.length > 0) {
				for (var i:int = filters.length - 1; i > -1; i--) {
					var filter:* = filters[i];
					if (filter is filterType) {
						filters.splice(i, 1);
					}
				}
				target.filters = filters;
			}
		}
		
		/**clone副本*/
		public static function clone(source:*):* {
			var bytes:ByteArray = new ByteArray();
			bytes.writeObject(source);
			bytes.position = 0;
			return bytes.readObject();
		}
		
		/**创建位图*/
		public static function createBitmap(width:int, height:int, color:uint = 0, alpha:Number = 1):Bitmap {
			var bitmap:Bitmap = new Bitmap(new BitmapData(1, 1, false, color));
			bitmap.alpha = alpha;
			bitmap.width = width;
			bitmap.height = height;
			return bitmap;
		}
		
		/**读取AMF*/
		public static function readAMF(bytes:ByteArray):Object {
			if (bytes && bytes.length > 0 && bytes.readByte() == 0x11) {
				return bytes.readObject();
			}
			return null;
		}
		
		/**写入AMF*/
		public static function writeAMF(obj:Object):ByteArray {
			var bytes:ByteArray = new ByteArray();
			bytes.writeByte(0x11);
			bytes.writeObject(obj);
			return bytes;
		}
		private static const grayFilter:ColorMatrixFilter = new ColorMatrixFilter([0.3086, 0.6094, 0.082, 0, 0, 0.3086, 0.6094, 0.082, 0, 0, 0.3086, 0.6094, 0.082, 0, 0, 0, 0, 0, 1, 0]);
		
		/**让显示对象变成灰色*/
		public static function gray(traget:DisplayObject, isGray:Boolean = true):void {
			if (isGray) {
				addFilter(traget, grayFilter);
			} else {
				clearFilter(traget, ColorMatrixFilter);
			}
		}
		
		private static var _tf:TextField = new TextField();
		
		/**获得实际文本*/
		public static function getTextField(format:TextFormat, text:String = "Test"):TextField {
			_tf.autoSize = "left";
			_tf.defaultTextFormat = format;
			_tf.text = text;
			return _tf;
		}
	}
}