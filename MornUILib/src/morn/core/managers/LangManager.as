/**
 * Morn UI Version 3.0 http://www.mornui.com/
 * Feedback yungzhu@gmail.com http://weibo.com/newyung
 */
package morn.core.managers {
	
	/**语言管理器*/
	public class LangManager {
		
		private var _data:Object = {};
		
		public function LangManager() {
		}
		
		/**语言包(key:value方式)*/
		public function get data():Object {
			return _data;
		}
		
		public function set data(value:Object):void {
			_data = value;
		}
		
		/**获取语言
		 * @param code 索引key
		 * @param ...args 参数*/
		public function getLang(code:String, ... args):String {
			var str:String = _data[code] || code;
			if (args.length > 0) {
				for (var i:int = 0, n:int = args.length; i < n; i++) {
					str = str.replace("{" + i + "}", args[i]);
				}
			}
			return str;
		}
	}
}