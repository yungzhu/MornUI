/**
 * Morn UI Version 1.1.0224 http://code.google.com/p/morn https://github.com/yungzhu/morn
 * Feedback yungzhu@gmail.com http://weibo.com/newyung
 */
package morn.core.utils {
	import flash.geom.Rectangle;
	
	/**文本工具集*/
	public class StringUtils {
		/**判断文本为非空*/
		public static function isNotEmpty(str:String):Boolean {
			if (str == null || str == "") {
				return false;
			}
			return true;
		}
		
		/**用字符串填充数组，并返回数组副本*/
		public static function fillArray(arr:Array, str:String, type:Class = null):Array {
			var temp:Array = ObjectUtils.clone(arr);
			if (isNotEmpty(str)) {
				var a:Array = str.split(",");
				for (var i:int = 0, n:int = Math.min(temp.length, a.length); i < n; i++) {
					var value:String = a[i];
					temp[i] = (value == "true" ? true : (value == "false" ? false : value));
					if (type != null) {
						temp[i] = type(value);
					}
				}
			}
			return temp;
		}
		
		/**转换Rectangle为逗号间隔的字符串*/
		public static function rectToString(rect:Rectangle):String {
			if (rect) {
				return rect.x + "," + rect.y + "," + rect.width + "," + rect.height;
			}
			return null;
		}
	}
}