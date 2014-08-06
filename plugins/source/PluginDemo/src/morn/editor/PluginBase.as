package morn.editor {
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.system.ApplicationDomain;
	import flash.utils.ByteArray;
	
	/**编辑器插件基类，扩展插件请继承此类并实现start方法
	 * 本类提供的所有方法都会在编辑器内被重写*/
	public class PluginBase extends Sprite {
		public function PluginBase() {
		
		}
		
		/**开始执行，插件运行的起点*/
		public function start():void {
			//调用插件时，会执行此方法
		}
		
		/**页面切换时调用*/
		public function onPageChanged(e:Event):void {
		
		}
		
		/**页面保存时调用*/
		public function onPageSaved(e:Event):void {
		
		}
		
		//======================文件操作======================
		/**读取文本文件
		 * @param path 文件的物理地址*/
		public static function readTxt(path:String):String {
			return null;
		}
		
		/**写文本文件
		 * @param path 文件的物理地址
		 * @param value 文件的内容*/
		public static function writeTxt(path:String, value:String):void {
		
		}
		
		/**读取二进制文件
		 * @param path 文件的物理地址*/
		public static function readByte(path:String):ByteArray {
			return null;
		}
		
		/**写入二进制文件
		 * @param path 文件的物理地址
		 * @param bytes 文件的内容*/
		public static function writeByte(path:String, bytes:ByteArray):void {
		
		}
		
		/**编辑器目录物理地址*/
		public static function get appPath():String {
			return "";
		}
		
		/**项目目录物理地址*/
		public static function get workPath():String {
			return "";
		}
		
		/**插件目录物理地址*/
		public static function get pluginPath():String {
			return "";
		}
		
		/**获得绝对路径
		 * @param basePath 基础的物理地址
		 * @param relativePath 目标的相对地址*/
		public static function getPath(basePath:String, relativePath:String):String {
			return "";
		}
		
		/**获得相对路径
		 * @param basePath 基础的物理地址
		 * @param targetPath 目标的物理地址*/
		public static function getRelativePath(basePath:String, targetPath:String):String {
			return "";
		}
		
		/**返回path下的所有文件
		 * @param  path 物理路径
		 * @return 返回路径下所有文件，格式[[文件名,文件路径],[文件名,文件路径]]*/
		public static function getFileList(path:String):Array {
			return [];
		}
		
		/**加载swf,位图等
		 * @param path 页面的物理地址
		 * @param complete 回调函数，返回默认参数loader:Loader*/
		public static function loadByPath(path:String, complete:Function = null):void {
		
		}
		
		/**加载swf,位图等
		 * @param path 页面的物理地址
		 * @param complete 回调函数，返回默认参数loader:Loader*/
		public static function loadByContent(bytes:ByteArray, complete:Function = null):void {
		
		}
		
		//======================界面操作======================		
		/**stage引用*/
		public static function get builderStage():Stage {
			return null;
		}
		
		/**编辑器主程序引用*/
		public static function get builderMain():Sprite {
			return null;
		}
		
		/**插件所在的域*/
		public static function get pluginDomain():ApplicationDomain {
			//这里仅仅为测试方便，实际运行是插件所在的域
			return ApplicationDomain.currentDomain;
		}
		
		/**判断是否有类的定义*/
		public static function hasClass(name:String):Boolean {
			return pluginDomain.hasDefinition(name);
		}
		
		/**获取类*/
		public static function getClass(name:String):Class {
			if (hasClass(name)) {
				return pluginDomain.getDefinition(name) as Class;
			}
			log("Miss Asset:" + name);
			return null;
		}
		
		/**获取资源*/
		public static function getAsset(name:String):* {
			var bmdClass:Class = getClass(name);
			if (bmdClass == null) {
				return null;
			}
			return new bmdClass();
		}
		
		/**获取位图数据*/
		public static function getBitmapData(name:String):BitmapData {
			var bmdClass:Class = getClass(name);
			if (bmdClass == null) {
				return null;
			}
			return new bmdClass(1, 1);
		}
		
		/**内置的显示等待框*/
		public static function showWaiting(title:String, msg:String):void {
		
		}
		
		/**内置的关闭等待框*/
		public static function closeWaiting():void {
		
		}
		
		/**警示弹框*/
		public static function alert(title:String, text:String):void {
		}
		
		/**确认弹框
		 * @param	closeHandler 关闭回调，返回参数(sure:Boolean)*/
		public static function confirm(title:String, text:String, closeHandler:Function = null):void {
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
		
		/**当前页面地址*/
		public static function get viewPath():String {
			return null;
		}
		
		/**更改当前页面内容
		 * @param xml 页面的xml内容
		 * @param refresh 是否刷新编辑器视图*/
		public static function changeViewXml(xml:XML, refresh:Boolean = false):void {
		
		}
		
		/**获得当前页被选择的组件的XML列表 格式[{xml:组件的XML},{xml:组件的XML}]*/
		public static function get selectedXmls():Array {
			return null;
		}
		
		/**根据compId获得当前组件实例*/
		public static function getCompById(compId:int):Sprite {
			return null;
		}
		
		/**在编辑器内打开页面
		 *  @param path 页面的物理地址*/
		public static function openPage(path:String):void {
		
		}
		
		//======================执行cmd命令======================
		/**执行cmd命令
		 * @param cmds 命令行数组
		 * @param cmdComplete 执行完毕回调
		 * @param cmdProgress 执行进度回调 默认参数e:ProgressEvent
		 * @param cmdError    执行错误回调*/
		public static function exeCmds(cmds:Array, cmdComplete:Function = null, cmdProgress:Function = null, cmdError:Function = null):void {
		
		}
	}
}