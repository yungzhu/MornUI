/**
 * Morn UI Version 2.1.0623 http://code.google.com/p/morn https://github.com/yungzhu/morn
 * Feedback yungzhu@gmail.com http://weibo.com/newyung
 */
package {
	
	/**全局配置*/
	public class Config {
		//------------------静态配置------------------		
		/**游戏帧率*/
		public static var GAME_FPS:int = 50;
		/**动画默认播放间隔*/
		public static var MOVIE_INTERVAL:int = 100;
		//------------------动态配置------------------
		/**资源路径*/
		public static var resPath:String = "";
		/**UI路径(UI加载模式可用)*/
		public static var uiPath:String = "";
		/**鼠标提示延迟(毫秒)*/
		public static var tipDelay:int = 200;
		/**提示是否跟随鼠标移动*/
		public static var tipFollowMove:Boolean = true;				
	}
}