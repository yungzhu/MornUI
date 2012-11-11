/**
 * Version 0.9.2 https://github.com/yungzhu/morn
 * Feedback yungzhu@gmail.com http://weibo.com/newyung
 * Copyright 2012, yungzhu. All rights reserved.
 * This program is free software. You can redistribute and/or modify it
 * in accordance with the terms of the accompanying license agreement.
 */
package morn.core.components {
	import flash.events.Event;
	
	/**UI事件类*/
	public class UIEvent extends Event {
		//-----------------Component-----------------			
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
		
		private var _data:*;
		
		public function UIEvent(type:String, data:*, bubbles:Boolean = false, cancelable:Boolean = false) {
			super(type, bubbles, cancelable);
			_data = data;
		}
		
		/**事件数据*/
		public function get data():* {
			return _data;
		}
		
		public function set data(value:*):void {
			_data = value;
		}
		
		override public function clone():Event {
			return new UIEvent(type, _data, bubbles, cancelable);
		}
	}
}