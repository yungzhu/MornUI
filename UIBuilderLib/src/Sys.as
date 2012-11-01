package {
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.net.URLRequest;
	import flash.system.ApplicationDomain;
	import flash.system.LoaderContext;
	
	/**
	 * 编辑器系统类，提供扩展插件使用
	 */
	public class Sys {
		/**全局stage引用*/
		public static var stage:Stage;		
		private static var resDomainMap:Object={};
		
		public static function init(stage:Stage):void {
			Sys.stage=stage;
		}
		
		/**加载资源*/
		public static function loadRes(url:String, loaded:Function=null):void {
			var domain:ApplicationDomain=new ApplicationDomain();
			resDomainMap[url]=domain;
			var loader:Loader=new Loader();
			loader.load(new URLRequest(url),new LoaderContext(false, domain));
			if (loaded != null) {  
				loader.contentLoaderInfo.addEventListener(Event.COMPLETE, loaded);
			}
		}
		
		/**资源是否存在*/
		public static function hasRes(name:String):Boolean{
			for each (var domain:ApplicationDomain in resDomainMap) {
				if (domain.hasDefinition(name)) {
					return true;
				}
			}
			return false;
		}
		
		/**获取资源类*/
		public static function getResClass(name:String):Class {
			for each (var domain:ApplicationDomain in resDomainMap) {
				if (domain.hasDefinition(name)) {
					return domain.getDefinition(name) as Class;
				}
			}
			return null;
		}
		
		/**获取资源*/
		public static function getRes(name:String):* {
			var resClass:Class=getResClass(name);
			if (resClass) {
				return new resClass();
			}
			return null;
		}
		
		/**获取资源位图*/
		public static function getResBitmapData(name:String):BitmapData {
			var resClass:Class=getResClass(name);
			if (resClass) {
				return new resClass(1, 1);
			}
			return null;
		}
	}
}
