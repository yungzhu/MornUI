/**
 * Version 1.0.0 Alpha https://github.com/yungzhu/morn
 * Feedback yungzhu@gmail.com http://weibo.com/newyung
 */
package {
	
	/**全局配置*/
	public class Config {
		//------------------静态配置------------------		
		/**游戏帧率*/
		public static const GAME_FPS:int = 50;
		/**动画默认播放间隔*/
		public static const MOVIE_INTERVAL:int = 100;		
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
		/**鼠标提示延迟(毫秒)*/
		public static var tipDelay:int = 200;
		/**鼠标是否跟随鼠标移动*/
		public static var tipFollowMove:Boolean = true;
	}
}