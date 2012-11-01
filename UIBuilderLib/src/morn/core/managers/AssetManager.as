/**
 * Version 0.9.9 https://github.com/yungzhu/morn
 * Feedback yungzhu@gmail.com http://weibo.com/newyung
 * Copyright 2012, yungzhu. All rights reserved.
 * This program is free software. You can redistribute and/or modify it
 * in accordance with the terms of the accompanying license agreement.
 */
package morn.core.managers {
	import morn.core.utils.BitmapUtils;
	import flash.display.BitmapData;
	import flash.system.ApplicationDomain;
	
	/**资源管理器*/
	public class AssetManager {
		private var _bmdMap:Object = {};
		private var _clipsMap:Object = {};
		
		/**判断是否有类的定义*/
		public function hasClass(name:String):Boolean {
			return Sys.hasRes(name);
		}
		
		/**获取类*/
		public function getClass(name:String):Class {
			return Sys.getResClass(name);
		}
		
		/**获取资源*/
		public function getAsset(name:String):* {
			return Sys.getRes(name);
		}
		
		/**获取位图数据*/
		public function getBitmapData(name:String, cache:Boolean = true):BitmapData {
			return Sys.getResBitmapData(name);
		}
		
		/**获取切片资源*/
		public function getClips(name:String, xNum:int, yNum:int, cache:Boolean = true):Vector.<BitmapData> {
			return BitmapUtils.createClips(getBitmapData(name,false), xNum, yNum);
		}
		
		/**缓存位图数据*/
		public function cacheBitmapData(name:String, bmd:BitmapData):void {
			
		}
		
		/**缓存切片资源*/
		public function cacheClips(name:String, clips:Vector.<BitmapData>):void {
			
		}
	}
}