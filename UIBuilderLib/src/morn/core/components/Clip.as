/**
 * Version 0.9.9 https://github.com/yungzhu/morn
 * Feedback yungzhu@gmail.com http://weibo.com/newyung
 * Copyright 2012, yungzhu. All rights reserved.
 * This program is free software. You can redistribute and/or modify it
 * in accordance with the terms of the accompanying license agreement.
 */
package morn.core.components {
	import editor.core.IClip;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.events.Event;
	
	import morn.core.handlers.Handler;
	import morn.core.utils.BitmapUtils;
	import morn.core.utils.StringUtils;
	
	/**位图剪辑*/
	public class Clip extends Component implements IClip {
		private var _autoStopAtRemoved:Boolean = true;
		private var _bitmap:Bitmap;
		private var _clips:Vector.<BitmapData>;
		private var _clipX:int = 1;
		private var _clipY:int = 1;
		private var _url:String;
		private var _index:int;
		private var _autoPlay:Boolean;
		private var _interval:int = 200;
		
		public function Clip(url:String = null, clipX:int = 1, clipY:int = 1) {
			_clipX = clipX;
			_clipY = clipY;
			this.url = url;
		}
		
		override protected function createChildren():void {
			addChild(_bitmap = new Bitmap());
		}
		
		override protected function initialize():void {
			addEventListener(Event.REMOVED_FROM_STAGE, onRemovedFromStage);
		}
		
		private function onRemovedFromStage(e:Event):void {
			if (_autoStopAtRemoved) {
				stop();
			}
		}
		
		/**位图剪辑地址*/
		public function get url():String {
			return _url;
		}
		
		public function set url(value:String):void {
			if (_url != value && StringUtils.isNotEmpty(value)) {
				_url = value;
				callLater(changeClip);
			}
		}
		
		private function changeClip():void {	
			if(App.asset.hasClass(_url)){
				_clips = App.asset.getClips(_url, _clipX, _clipY, false);
				index = _index;
				_width = _width == 0 ? _bitmap.bitmapData.width : _width;
				_height = _height == 0 ? _bitmap.bitmapData.height : _height;
				changeSize();
			}else{
				var fullUrl:String = _url;
				App.loader.loadBMD(fullUrl, new Handler(loadComplete));
			}
		}
		
		private function loadComplete(bmd:BitmapData):void {
			if (bmd != null) {
				_clips = BitmapUtils.createClips(bmd,_clipX,_clipY);
				index = _index;
				_width = _width == 0 ? _bitmap.bitmapData.width : _width;
				_height = _height == 0 ? _bitmap.bitmapData.height : _height;
				changeSize();
			}
			sendEvent(UIEvent.IMAGE_LOADED);
		}
		
		override protected function changeSize():void {
			_bitmap.width = _width;
			_bitmap.height = _height;
			super.changeSize();
		}
		
		/**切片宽度*/
		public function get clipX():int {
			return _clipX;
		}
		
		public function set clipX(value:int):void {
			if (_clipX != value) {
				_clipX = value;
				callLater(changeClip);
			}
		}
		
		/**切片高度*/
		public function get clipY():int {
			return _clipY;
		}
		
		public function set clipY(value:int):void {
			if (_clipY != value) {
				_clipY = value;
				callLater(changeClip);
			}
		}
		
		/**切片索引*/
		public function get index():int {
			return _index;
		}
		
		public function set index(value:int):void {
			_index = value;
			if (_clips != null) {
				_index = (_index < _clips.length && _index > -1) ? _index : 0;
				_bitmap.bitmapData = _clips[_index];
			}
		}
		
		/**从显示列表删除后是否自动停止播放*/
		public function get autoStopAtRemoved():Boolean {
			return _autoStopAtRemoved;
		}
		
		public function set autoStopAtRemoved(value:Boolean):void {
			_autoStopAtRemoved = value;
		}
		
		/**自动播放*/
		public function get autoPlay():Boolean {
			return _autoPlay;
		}
		
		public function set autoPlay(value:Boolean):void {
			if (_autoPlay != value) {
				_autoPlay = value;
				callLater(changePlay);
			}
		}
		
		private function changePlay():void {
			_autoPlay ? play() : stop();
		}
		
		/**动画播放间隔(单位毫秒)*/
		public function get interval():int {
			return _interval;
		}
		
		public function set interval(value:int):void {
			if (_interval != value) {
				_interval = value;
				callLater(changePlay);
			}
		}
		
		/**开始播放*/
		public function play():void {
			_autoPlay = true;
			App.timer.doLoop(_interval, loop);
		}
		
		private function loop():void {
			index++;
		}
		
		/**停止播放*/
		public function stop():void {
			_autoPlay = false;
			App.timer.clearTimer(loop);
		}
	}
}