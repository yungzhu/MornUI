/**
 * Morn UI Version 1.1.0224 http://code.google.com/p/morn https://github.com/yungzhu/morn
 * Feedback yungzhu@gmail.com http://weibo.com/newyung
 */
package morn.core.managers {
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import morn.core.handlers.Handler;
	
	/**加载管理器*/
	public class LoaderManager extends EventDispatcher {
		private var _resInfos:Array = [];
		private var _resLoader:ResLoader = new ResLoader();
		private var _isLoading:Boolean;
		private var _failRes:Object = {};
		
		public function load(url:String, type:uint, complete:Handler = null, progress:Handler = null):void {
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
					return;
				} else {
					App.log.warn("load error:", resInfo.url);
				}
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
		
		/**加载BYTE*/
		public function loadBYTE(url:String, complete:Handler = null, progress:Handler = null):void {
			load(url, ResLoader.BYTE, complete, progress);
		}
		
		/**
		 * 加载数组里面的资源
		 * @param arr 简单：["a.swf","b.swf"]，复杂[{url:"a.swf",type:ResLoader.SWF,size:100},{url:"a.png",type:ResLoader.BMD,size:50}]
		 */
		public function loadAssets(arr:Array, complete:Handler = null, progress:Handler = null):void {
			var itemCount:int = arr.length;
			var itemloaded:int = 0;
			var totalSize:int = 0;
			var totalLoaded:int = 0;
			for (var i:int = 0; i < itemCount; i++) {
				var item:Object = arr[i];
				if (item is String) {
					item = {url: item, type: ResLoader.SWF, size: 1};
				}
				totalSize += item.size;
				load(item.url, item.type, new Handler(loadAssetsComplete, [item.size]), new Handler(loadAssetsProgress, [item.size]));
			}
			
			function loadAssetsComplete(content:*, size:int):void {
				itemloaded++;
				totalLoaded += size;
				if (itemloaded == itemCount) {
					if (complete != null) {
						complete.execute();
					}
				}
			}
			
			function loadAssetsProgress(value:Number, size:int):void {
				if (progress != null) {
					value = (totalLoaded + size * value) / totalSize;
					progress.executeWith([value]);
				}
			}
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