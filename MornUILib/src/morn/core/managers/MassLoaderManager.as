/**
 * Morn UI Version 3.0 http://www.mornui.com/
 * Feedback yungvip@163.com weixin:yungzhu
 */
package morn.core.managers {
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import morn.core.handlers.Handler;
	
	/**队列全部加载后触发*/
	[Event(name="complete",type="flash.events.Event")]
	
	/**批量加载器 多线程(默认3个线程)，5个优先级(0最快，4最慢,默认为1)*/
	public class MassLoaderManager extends EventDispatcher {
		private var _resLoaders:Vector.<ResLoader> = new Vector.<ResLoader>();
		private var _maxLoader:int = 3;
		private var _loaderCount:int = 0;
		private var _resInfos:Array = [];
		private var _resMap:Object = {};
		private var _maxPriority:uint = 5;
		private var _failRes:Object = {};
		private var _retryNum:int = 1;
		
		public function MassLoaderManager() {
			for (var i:int = 0; i < _maxPriority; i++) {
				_resInfos[i] = [];
			}
		}
		
		private function load(url:String, type:uint, priority:uint = 1, complete:Handler = null, progress:Handler = null, error:Handler = null, isCacheContent:Boolean = true):void {
			var resInfo:ResInfo = new ResInfo();
			resInfo.url = url;
			resInfo.type = type;
			resInfo.completeHandlers.push(complete);
			resInfo.progressHandlers.push(progress);
			resInfo.errorHandlers.push(error);
			resInfo.isCacheContent = isCacheContent;
			
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
					info.errorHandlers.push(error);
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
			//如果加载后为空，放入队列末尾重试
			if (content == null) {
				var errorCount:int = _failRes[resInfo.url] || 0;
				if (errorCount < _retryNum) {
					_failRes[resInfo.url] = errorCount + 1;
					_resInfos[_maxPriority - 1].push(resInfo);
					return;
				} else {
					App.log.warn("mass load error:", resInfo.url);
					for each (var error:Handler in resInfo.errorHandlers) {
						if (error != null) {
							error.executeWith([resInfo.url]);
						}
					}
				}
			}
			delete _resMap[resInfo.url];
			for each (var handler:Handler in resInfo.completeHandlers) {
				if (handler != null) {
					handler.executeWith([content]);
				}
			}
		}
		
		/**加载SWF，返回1*/
		public function loadSWF(url:String, priority:uint = 1, complete:Handler = null, progress:Handler = null, error:Handler = null, isCacheContent:Boolean = true):void {
			load(url, ResLoader.SWF, priority, complete, progress, error, isCacheContent);
		}
		
		/**加载位图，返回Bitmapdata*/
		public function loadBMD(url:String, priority:uint = 1, complete:Handler = null, progress:Handler = null, error:Handler = null, isCacheContent:Boolean = true):void {
			load(url, ResLoader.BMD, priority, complete, progress, error, isCacheContent);
		}
		
		/**加载AMF，返回Object*/
		public function loadAMF(url:String, priority:uint = 1, complete:Handler = null, progress:Handler = null, error:Handler = null, isCacheContent:Boolean = true):void {
			load(url, ResLoader.AMF, priority, complete, progress, error, isCacheContent);
		}
		
		/**加载TXT,XML，返回String*/
		public function loadTXT(url:String, priority:uint = 1, complete:Handler = null, progress:Handler = null, error:Handler = null, isCacheContent:Boolean = true):void {
			load(url, ResLoader.TXT, priority, complete, progress, error, isCacheContent);
		}
		
		/**加载二进制数据，返回Object*/
		public function loadDB(url:String, priority:uint = 1, complete:Handler = null, progress:Handler = null, error:Handler = null, isCacheContent:Boolean = true):void {
			load(url, ResLoader.DB, priority, complete, progress, error, isCacheContent);
		}
		
		/**加载BYTE，返回ByteArray*/
		public function loadBYTE(url:String, priority:uint = 1, complete:Handler = null, progress:Handler = null, error:Handler = null, isCacheContent:Boolean = true):void {
			load(url, ResLoader.BYTE, priority, complete, progress, error, isCacheContent);
		}
		
		/**最大下载线程，默认为3个*/
		public function get maxLoader():int {
			return _maxLoader;
		}
		
		public function set maxLoader(value:int):void {
			_maxLoader = value;
		}
		
		/**获得已加载的资源*/
		public function getResLoaded(url:String):* {
			return ResLoader.getResLoaded(url);
		}
		
		/**删除已加载的资源*/
		public function clearResLoaded(url:String):void {
			ResLoader.clearResLoaded(url);
		}
		
		/**停止并清理当前未完成的加载*/
		public function stopAndClearLoad():void {
			_resInfos.length = 0;
			for each (var loader:ResLoader in _resLoaders) {
				loader.tryToCloseLoad();
			}
			_loaderCount = 0;
			_resMap = {};
		}
		
		/**加载出错后的重试次数，默认重试一次*/
		public function get retryNum():int {
			return _retryNum;
		}
		
		public function set retryNum(value:int):void {
			_retryNum = value;
		}
		
		/**加载数组里面的资源
		 * @param arr 简单：["a.swf","b.swf"]，复杂[{url:"a.swf",type:ResLoader.SWF,size:100,priority:1},{url:"a.png",type:ResLoader.BMD,size:50,priority:1}]*/
		public function loadAssets(arr:Array, complete:Handler = null, progress:Handler = null, error:Handler = null, isCacheContent:Boolean = true):void {
			var itemCount:int = arr.length;
			var itemloaded:int = 0;
			var totalSize:int = 0;
			var items:Array = [];
			for (var i:int = 0; i < itemCount; i++) {
				var item:Object = arr[i];
				if (item is String) {
					item = {url: item, type: ResLoader.SWF, size: 1, priority: 1};
				}
				item.progress = 0;
				totalSize += item.size;
				items.push(item);
				load(item.url, item.type, item.priority, new Handler(loadAssetsComplete, [item]), new Handler(loadAssetsProgress, [item]), error, isCacheContent);
			}
			
			function loadAssetsComplete(item:Object, content:*):void {
				itemloaded++;
				item.progress = 1;
				if (itemloaded == itemCount) {
					if (complete != null) {
						complete.execute();
					}
				}
			}
			
			function loadAssetsProgress(item:Object, value:Number):void {
				if (progress != null) {
					item.progress = value;
					var num:Number = 0;
					for (var j:int = 0; j < itemCount; j++) {
						var item1:Object = items[j];
						num += item1.size * item1.progress;
					}
					progress.executeWith([num / totalSize]);
				}
			}
		}
	}
}
import morn.core.handlers.Handler;

class ResInfo {
	public function ResInfo() {
	}
	public var url:String;
	public var type:int;
	public var completeHandlers:Vector.<Handler> = new Vector.<Handler>();
	public var progressHandlers:Vector.<Handler> = new Vector.<Handler>();
	public var errorHandlers:Vector.<Handler> = new Vector.<Handler>();
	public var isCacheContent:Boolean;
}