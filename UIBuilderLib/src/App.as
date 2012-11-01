/**
 * Version 0.9.9 https://github.com/yungzhu/morn
 * Feedback yungzhu@gmail.com http://weibo.com/newyung
 * Copyright 2012, yungzhu. All rights reserved.
 * This program is free software. You can redistribute and/or modify it
 * in accordance with the terms of the accompanying license agreement.
 */
package {
	import flash.display.Stage;
	
	import morn.core.managers.AssetManager;
	import morn.core.managers.LoaderManager;
	import morn.core.managers.TimerManager;
	
	/**全局引用入口*/
	public class App {
		/**资源管理器*/
		public static var asset:AssetManager = new AssetManager();
		/**加载管理器*/
		public static var loader:LoaderManager = new LoaderManager();
		/**时钟管理器*/
		public static var timer:TimerManager = new TimerManager();

		/**全局stage引用*/
		public static function get stage():Stage{
			return Sys.stage;
		}

	}
}