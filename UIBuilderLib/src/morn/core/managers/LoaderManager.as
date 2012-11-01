/**
 * Version 0.9.9 https://github.com/yungzhu/morn
 * Feedback yungzhu@gmail.com http://weibo.com/newyung
 * Copyright 2012, yungzhu. All rights reserved.
 * This program is free software. You can redistribute and/or modify it
 * in accordance with the terms of the accompanying license agreement.
 */
package morn.core.managers {
	import morn.core.handlers.Handler;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	
	/**加载管理器*/
	public class LoaderManager extends EventDispatcher {
		private var _resInfos:Array = [];
		private var _resLoader:ResLoader = new ResLoader();
		private var _isLoading:Boolean;
		private var _failRes:Object = {};
		
		private function load(url:String, type:uint, complete:Handler = null, progress:Handler = null):void {
			var resInfo:ResInfo = new ResInfo();
			resInfo.url = url;
			resInfo.type = type;
			resInfo.complete = complete;
			resInfo.progress = progress;
			
			var content:* = ResLoader.getResLoaded(resInfo.url);
			if (content != null) {
				endLoad(resInfo, content);
			} else {
				_resInfos.push(resInfo);
				checkNext();
			}
		}
		
		private function checkNext():void {
			if (_isLoading) {
				return;
			}
			while (_resInfos.length > 0) {
				var resInfo:ResInfo = _resInfos.shift();
				var content:* = ResLoader.getResLoaded(resInfo.url);
				if (content != null) {
					endLoad(resInfo, content);
				} else {
					doLoad(resInfo);
					return;
				}
			}
			if (hasEventListener(Event.COMPLETE)) {
				dispatchEvent(new Event(Event.COMPLETE));
			}
		}
		
		private function doLoad(resInfo:ResInfo):void {
			_isLoading = true;
			_resLoader.load(resInfo.url, resInfo.type, new Handler(loadComplete, [resInfo]), resInfo.progress);
		}
		
		private function loadComplete(resInfo:ResInfo, content:*):void {
			endLoad(resInfo, content);
			_isLoading = false;
			checkNext();
		}
		
		private function endLoad(resInfo:ResInfo, content:*):void {
			//如果加载后为空，放入队列末尾重试一次
			if (content == null) {
				if (_failRes[resInfo.url] == null) {
					_failRes[resInfo.url] = 1;
					_resInfos.push(resInfo);
				} else {
					trace("load error:", resInfo.url);
				}
				return;
			}
			if (resInfo.complete != null) {
				resInfo.complete.executeWith([content]);
			}
		}
		
		/**加载SWF*/
		public function loadSWF(url:String, complete:Handler = null, progress:Handler = null):void {
			load(url, ResLoader.SWF, complete, progress);
		}
		
		/**加载位图*/
		public function loadBMD(url:String, complete:Handler = null, progress:Handler = null):void {
			load(url, ResLoader.BMD, complete, progress);
		}
		
		/**加载AMF*/
		public function loadAMF(url:String, complete:Handler = null, progress:Handler = null):void {
			load(url, ResLoader.AMF, complete, progress);
		}
		
		/**加载TXT*/
		public function loadTXT(url:String, complete:Handler = null, progress:Handler = null):void {
			load(url, ResLoader.TXT, complete, progress);
		}
		
		/**加载DB*/
		public function loadDB(url:String, complete:Handler = null, progress:Handler = null):void {
			load(url, ResLoader.DB, complete, progress);
		}
	}
}
import morn.core.handlers.Handler;

class ResInfo {
	public var url:String;
	public var type:int;
	public var complete:Handler;
	public var progress:Handler;
}