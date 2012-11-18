/**
 * Version 0.9.2 https://github.com/yungzhu/morn
 * Feedback yungzhu@gmail.com http://weibo.com/newyung
 * Copyright 2012, yungzhu. All rights reserved.
 * This program is free software. You can redistribute and/or modify it
 * in accordance with the terms of the accompanying license agreement.
 */
package {
	
	/**全局配置*/
	public class Config {
		//------------------静态配置------------------		
		/**游戏帧率*/
		public static const GAME_FPS:int = 50;
		/**动画默认播放间隔*/
		public static const MOVIE_INTERVAL:int = 200;
		//------------------动态配置------------------
		/**是否是调试模式*/
		public static var debug:int = 1;
		/**游戏宽度*/
		public static var gameWidth:int = 1000;
		/**游戏高度*/
		public static var gameHeight:int = 550;
		/**资源路径*/
		public static var resPath:String = "";
		/**UI路径(UI加载模式可用)*/
		public static var uiPath:String = "ui.swf";
	}
}