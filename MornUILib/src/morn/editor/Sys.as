/**
 * Morn UI Version 3.0 http://www.mornui.com/
 * Feedback yungzhu@gmail.com http://weibo.com/newyung
 */
package morn.editor {
	import flash.display.BitmapData;
	import flash.display.Stage;
	
	/**编辑器系统类，提供扩展插件使用(不要修改此类)*/
	public class Sys {
		/**全局stage引用*/
		public static var stage:Stage;
		
		/**加载资源*/
		public static function loadRes(url:String, loaded:Function = null):void {
		
		}
		
		/**资源是否存在*/
		public static function hasRes(name:String):Boolean {
			return false;
		}
		
		/**获取资源类*/
		public static function getResClass(name:String):Class {
			return null;
		}
		
		/**获取资源*/
		public static function getRes(name:String):* {
			return null;
		}
		
		/**获取资源位图*/
		public static function getResBitmapData(name:String):BitmapData {
			return null;
		}
		
		/**在编辑器中输入日志*/
		public static function log(... args):void {
			trace(args.join(","));
		}
	}
}
