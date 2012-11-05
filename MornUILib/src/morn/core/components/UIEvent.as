/**
 * Version 0.9.0 https://github.com/yungzhu/morn
 * Feedback yungzhu@gmail.com http://weibo.com/newyung
 * Copyright 2012, yungzhu. All rights reserved.
 * This program is free software. You can redistribute and/or modify it
 * in accordance with the terms of the accompanying license agreement.
 */
package morn.core.components {
	
	/**UI事件类*/
	public class UIEvent {
		//-----------------Component-----------------			
		/**预初始化*/
		//public static const PRE_INITIALIZE:String = "preinitialize";
		/**初始化*/
		//public static const INITIALIZE:String = "initialize";
		/**更新完毕*/
		public static const RENDER_COMPLETED:String = "renderCompleted";
		//-----------------Image-----------------
		/**图片加载完毕*/
		public static const IMAGE_LOADED:String = "imageLoaded";
		//-----------------View-----------------
		/**视图创建完毕*/
		public static const VIEW_CREATED:String = "viewCreated";
		//-----------------FrameClip-----------------
		/**播放完毕*/
		public static const PLAY_COMPLETED:String = "playCompleted";
	}
}