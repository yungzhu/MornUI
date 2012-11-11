/**
 * Version 0.9.2 https://github.com/yungzhu/morn
 * Feedback yungzhu@gmail.com http://weibo.com/newyung
 * Copyright 2012, yungzhu. All rights reserved.
 * This program is free software. You can redistribute and/or modify it
 * in accordance with the terms of the accompanying license agreement.
 */
package morn.core.managers {
	import morn.core.handlers.Handler;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	
	/**
	 * 批量加载器 多线程，6个优先级(0最快，5最慢,默认为1)
	 */
	public class MassLoaderManager extends EventDispatcher {
		private var _resLoaders:Vector.<ResLoader> = new Vector.<ResLoader>();
		private var _maxLoader:int = 5;
		private var _loaderCount:int = 0;
		private var _resInfos:Array = [];
		private var _resMap:Object = {};
		private var _maxPriority:uint = 6;
		private var _failRes:Object = {};
		
		public function MassLoaderManager() {
			for (var i:int = 0; i < _maxPriority; i++) {
				_resInfos[i] = [];
			}
		}
		
		private function load(url:String, type:uint, priority:uint = 1, complete:Handler = null, progress:Handler = null):void {
			var resInfo:ResInfo = new ResInfo();
			resInfo.url = url;
			resInfo.type = type;
			resInfo.completeHandlers.push(complete);
			resInfo.progressHandlers.push(progress);
			
			var content:* = ResLoader.getResLoaded(resInfo.url);
			if (content != null) {
				endLoad(resInfo, content);
			} else {
				var info:ResInfo = _resMap[url];
				if (info == null) {
					_resMap[url] = resInfo;
					priority = priority < _maxPriority ? priority : _maxPriority - 1;
					_resInfos[priority].push(resInfo);
					checkNext();
				} else {
					info.completeHandlers.push(complete);
					info.progressHandlers.push(progress);
				}
			}
		}
		
		private function checkNext():void {
			if (_loaderCount >= _maxLoader) {
				return;
			}
			for (var i:int = 0; i < _maxPriority; i++) {
				var infos:Array = _resInfos[i];
				while (infos.length > 0) {
					var resInfo:ResInfo = infos.shift();
					var content:* = ResLoader.getResLoaded(resInfo.url);
					if (content != null) {
						endLoad(resInfo, content);
					} else {
						doLoad(resInfo);
						return;
					}
				}
			}
			if (hasEventListener(Event.COMPLETE)) {
				dispatchEvent(new Event(Event.COMPLETE));
			}
		}
		
		private function doLoad(resInfo:ResInfo):void {
			_loaderCount++;
			var resLoader:ResLoader = _resLoaders.length > 0 ? _resLoaders.pop() : new ResLoader();
			resLoader.load(resInfo.url, resInfo.type, new Handler(loadComplete, [resLoader, resInfo]), new Handler(loadProgress, [resInfo]));
		}
		
		private function loadProgress(resInfo:ResInfo, progress:Number):void {
			for each (var handler:Handler in resInfo.progressHandlers) {
				if (handler != null) {
					handler.executeWith([progress]);
				}
			}
		}
		
		private function loadComplete(resLoader:ResLoader, resInfo:ResInfo, content:*):void {
			_resLoaders.push(resLoader);
			endLoad(resInfo, content);
			_loaderCount--;
			checkNext();
		}
		
		private function endLoad(resInfo:ResInfo, content:*):void {
			//如果加载后为空，放入队列末尾重试一次
			if (content == null) {
				if (_failRes[resInfo.url] == null) {
					_failRes[resInfo.url] = 1;
					_resInfos[_maxPriority - 1].push(resInfo);
				} else {
					delete _resMap[resInfo.url];
					App.log.warn("mass load error:", resInfo.url);
				}
				return;
			}
			delete _resMap[resInfo.url];
			for each (var handler:Handler in resInfo.completeHandlers) {
				if (handler != null) {
					handler.executeWith([content]);
				}
			}
		}
		
		/**加载SWF*/
		public function loadSWF(url:String, priority:uint = 1, complete:Handler = null, progress:Handler = null):void {
			load(url, ResLoader.SWF, priority, complete, progress);
		}
		
		/**加载位图*/
		public function loadBMD(url:String, priority:uint = 1, complete:Handler = null, progress:Handler = null):void {
			load(url, ResLoader.BMD, priority, complete, progress);
		}
		
		/**加载AMF*/
		public function loadAMF(url:String, priority:uint = 1, complete:Handler = null, progress:Handler = null):void {
			load(url, ResLoader.AMF, priority, complete, progress);
		}
		
		/**加载TXT*/
		public function loadTXT(url:String, priority:uint = 1, complete:Handler = null, progress:Handler = null):void {
			load(url, ResLoader.TXT, priority, complete, progress);
		}
		
		/**加载DB*/
		public function loadDB(url:String, priority:uint = 1, complete:Handler = null, progress:Handler = null):void {
			load(url, ResLoader.DB, priority, complete, progress);
		}
		
		/**最大下载线程，默认为5个*/
		public function get maxLoader():int {
			return _maxLoader;
		}
		
		public function set maxLoader(value:int):void {
			_maxLoader = value;
		}
	}
}
import morn.core.handlers.Handler;

class ResInfo {
	public var url:String;
	public var type:int;
	public var completeHandlers:Vector.<Handler> = new Vector.<Handler>();
	public var progressHandlers:Vector.<Handler> = new Vector.<Handler>();
}