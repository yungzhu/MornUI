/**
 * Morn UI Version 3.2 http://www.mornui.com/
 * Feedback yungvip@163.com weixin:yungzhu
 */
package morn.editor {
	
	public class Builder {
		public static var isEditor:Boolean = false;
		
		/**对UI类库进行初始化(编辑器导入UI类库后，会默认调用此方法)
		 * 这里可以针对编辑器对UI库做特殊改变*/
		public static function init():void {
			App.stage = Sys.stage;
			App.asset = new BuilderResManager();
			isEditor = true;
		}
		
		/**编辑器回传数据，用来动态更改组件内容*/
		public static function callBack(data:Object):void {
			if (data) {
				if (data.lang != null) {
					setLang(data.lang);
				}
			}
		}
		
		/**配置UI语言*/
		private static function setLang(text:String):void {
			try {
				var obj:Object = {};
				if (Boolean(text)) {
					var xml:XML = new XML(text);
					for each (var item:XML in xml.item) {
						obj[item.@key] = String(item.@value);
					}
				}
				//设置语言包
				App.lang.data = obj;
			} catch (e:Error) {
				Sys.log("加载语言包失败");
			}
		}
	}
}