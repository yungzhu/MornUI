package morn.editor {
	import flash.display.Sprite;
	
	/**编辑器插件基类，扩展插件请继承此类并实现start方法*/
	public class PluginBase extends Sprite {
		public function PluginBase() {
		
		}
		
		/**开始执行，插件运行的起点*/
		public function start():void {
		
		}
		
		//======================文件操作======================
		/**读取文本*/
		public static function readTxt(path:String):String {
			return "";
		}
		
		/**写文本*/
		public static function writeTxt(path:String, value:String):void {
		
		}
		
		/**编辑器目录*/
		public static function get appPath():String {
			return "";
		}
		
		/**项目目录*/
		public static function get workPath():String {
			return "";
		}
		
		/**插件目录*/
		public static function get pluginPath():String {
			return "";
		}
		
		/**获得绝对路径
		* @param basePath 基础的物理地址
		* @param relativePath 相对地址*/	
		public static function getPath(basePath:String, relativePath:String):String {
			return "";
		}
		
		/**获得相对路径
		 * @param basePath 基础的物理地址
		 * @param targetPath 目标的物理地址*/		
		public static function getRelativePath(basePath:String, targetPath:String):String {
			return "";
		}
		
		/**返回path下的所有文件*/
		public static function getFileList(path:String):Array {
			return [];
		}
		
		//======================界面操作======================		
		/**显示等待框*/
		public static function showWaiting(title:String, msg:String):void {
		
		}
		
		/**关闭等待框*/
		public static function closeWaiting():void {
		
		}
		
		/**提示弹框*/
		public static function alert(title:String, text:String, flags:uint = 0x4, closeHandler:Function = null):void {
		
		}
		
		/**日志，方便调试，在编辑器内(ctrl+L)可见*/
		public static function log(value:String):void {
			trace(value);
		}
		
		//======================页面视图======================
		
		/**当前页面内容*/
		public static function get viewXml():XML {
			return null;
		}
		
		/**改变当前页面内容 
		 * @param refresh 是否刷新当前视图*/
		public static function changeViewXml(xml:XML, refresh:Boolean = false):void {
		
		}
		
		/**获得当前页被选择的组件*/
		public static function get selectedXmls():Array {
			return null;
		}
		
		/**根据compId获得当前组件*/
		public static function getCompById(compId:int):Sprite {
			return null;
		}
		
		/**打开页面
		 *  @param path 页面的物理地址*/
		public static function openPage(path:String):void{
			
		}
	}
}