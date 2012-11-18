/**
 * Version 0.9.2 https://github.com/yungzhu/morn
 * Feedback yungzhu@gmail.com http://weibo.com/newyung
 * Copyright 2012, yungzhu. All rights reserved.
 * This program is free software. You can redistribute and/or modify it
 * in accordance with the terms of the accompanying license agreement.
 */
package {
	import flash.display.LoaderInfo;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import morn.core.components.View;
	import morn.core.handlers.Handler;
	import morn.core.managers.AssetManager;
	import morn.core.managers.DialogManager;
	import morn.core.managers.LoaderManager;
	import morn.core.managers.LogManager;
	import morn.core.managers.TimerManager;
	import morn.core.utils.StringUtils;
	
	/**全局引用入口*/
	public class App {
		/**全局stage引用*/
		public static var stage:Stage;
		/**资源管理器*/
		public static var asset:AssetManager = new AssetManager();
		/**加载管理器*/
		public static var loader:LoaderManager = new LoaderManager();
		/**时钟管理器*/
		public static var timer:TimerManager = new TimerManager();
		/**对话框管理器*/
		public static var dialog:DialogManager = new DialogManager();
		/**日志管理器*/
		public static var log:LogManager = new LogManager();
		
		public static function init(main:Sprite):void {
			stage = main.stage;
			stage.frameRate = Config.GAME_FPS;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			stage.stageFocusRect = false;
			stage.tabChildren = false;
			
			//覆盖配置
			var loaderInfo:LoaderInfo = stage.loaderInfo;
			var gameVars:Object = loaderInfo.parameters;
			if (gameVars != null) {
				for (var s:String in gameVars) {
					Config[s] = gameVars[s];
				}
			}
			
			stage.addChild(dialog);
			stage.addChild(log);
			
			//如果UI视图是加载模式，则进行整体加载
			if (StringUtils.isNotEmpty(Config.uiPath)) {
				App.loader.loadDB(Config.uiPath, new Handler(onUIloadComplete));
			}		
		}
		
		private static function onUIloadComplete(content:*):void {
			View.xmlMap = content;
		}
	}
}