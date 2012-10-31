/**
 * Version 0.9.0 https://github.com/yungzhu/morn
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
			return ApplicationDomain.currentDomain.hasDefinition(name);
		}
		
		/**获取类*/
		public function getClass(name:String):Class {
			if (hasClass(name)) {
				return ApplicationDomain.currentDomain.getDefinition(name) as Class;
			}
			App.log.error("Miss Asset:", name);
			return null;
		}
		
		/**获取资源*/
		public function getAsset(name:String):* {
			var assetClass:Class = getClass(name);
			if (assetClass != null) {
				return new assetClass();
			}
			return null;
		}
		
		/**获取位图数据*/
		public function getBitmapData(name:String, cache:Boolean = true):BitmapData {
			var bmd:BitmapData = _bmdMap[name];
			if (bmd == null) {
				var bmdClass:Class = getClass(name);
				if (bmdClass == null) {
					return null;
				}
				bmd = new bmdClass(1, 1);
				if (cache) {
					_bmdMap[name] = bmd;
				}
			}
			return bmd;
		}
		
		/**获取切片资源*/
		public function getClips(name:String, xNum:int, yNum:int, cache:Boolean = true):Vector.<BitmapData> {
			var clips:Vector.<BitmapData> = _clipsMap[name];
			if (clips == null) {
				var bmd:BitmapData = getBitmapData(name, false);
				if (bmd == null) {
					return null;
				}
				clips = BitmapUtils.createClips(bmd, xNum, yNum);
				if (cache) {
					_clipsMap[name] = clips;
				}
			}
			return clips;
		}
		
		/**缓存位图数据*/
		public function cacheBitmapData(name:String, bmd:BitmapData):void {
			if (bmd != null) {
				_bmdMap[name] = bmd;
			}
		}
		
		/**缓存切片资源*/
		public function cacheClips(name:String, clips:Vector.<BitmapData>):void {
			if (clips != null) {
				_clipsMap[name] = clips;
			}
		}
	}
}