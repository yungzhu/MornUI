package {
	import morn.editor.PluginBase;
	
	/**Morn UI 编辑器语言包自动导出插件yungzhu@gmail.com*/
	public class LangExtractor extends PluginBase {
		private static var labels:Array = ["text", "label", "labels"];
		
		public function LangExtractor() {
			//利用log判断是否加载插件成功
			log("语言包提取插件初始化完毕");
		}
		
		/**插件运行的起点*/
		override public function start():void {
			//利用log判断是否调用插件成功(配置内包名是否书写正确)
			log("开始提取语言包");
			//显示等待框
			showWaiting("请等待", "开始提取语言包，请等待");
			seekAll();
		}
		
		private function seekAll():void {
			//加载插件配置
			var configPath:String = getPath(pluginPath, "LangExtractor/config.xml");
			var config:XML = new XML(readTxt(configPath));
			//获得老的语言包
			var langPath:String = getPath(workPath, config.setting.langPath);
			var oldLang:XML = new XML(readTxt(langPath));
			var oldMap:Object = {};
			for each (var node:XML in oldLang.item) {
				oldMap[node.@key] = String(node.@value);
			}
			
			//准备新的语言包
			var map:Object = {};
			var str:String = "<?xml version=\"1.0\" encoding=\"utf-8\" ?><langs>";
			//获得所有页面
			var arr:Array = getDirectoryList(getPath(workPath, "morn/pages/"));
			log("找到了" + arr.length + "个页面");
			for each (var a:Array in arr) {
				var name:String = a[0];
				var path:String = a[1];
				var txt:String = readTxt(path);
				str += "<!-- " + name.replace(".xml", "") + " -->";
				var langs:Array = seekLangPack(txt);
				for each (var key:String in langs) {
					//过滤重复的语言
					if (map[key] != 1) {
						map[key] = 1;
						str += "<item key=\"" + key + "\" value=\"" + (oldMap[key] || key) + "\"/>";
					}
				}
			}
			str += "</langs>";
			
			//保存语言包
			XML.ignoreComments = false;
			writeTxt(langPath, new XML(str));
			XML.ignoreComments = true;
			log("语言包保存成功");
			//关闭等待框
			closeWaiting();
			//弹出成功提示
			alert("导出成功", "语言包导出成功，地址：\n"+langPath);
		}
		
		/**查找文件内所有文本*/
		public function seekLangPack(txt:String):Array {
			var arr:Array = [];
			var len:int = txt.length;
			var i:int = 0;
			var flag:Boolean = false;
			var start:int = 0;
			while (i < len) {
				var char:String = txt.charAt(i);
				if (char == " ") {
					for each (var item:String in labels) {
						start = i + item.length + 3;
						if (start < len && txt.substring(i + 1, start) == item + "=\"") {
							flag = true;
							break;
						}
					}
					if (flag) {
						flag = false;
						i = start;
						while (i < len) {
							char = txt.charAt(i);
							if (char == "\"" && txt.charAt(i - 1) != "\\") {
								break;
							} else {
								i++;
							}
						}
						var str:String = txt.substring(start, i);
						arr.push(str);
					} else {
						i++;
					}
				} else {
					i++;
				}
			}
			return arr;
		}
	}
}