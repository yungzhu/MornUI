/**
 * Version 0.9.0 https://github.com/yungzhu/morn
 * Feedback yungzhu@gmail.com http://weibo.com/newyung
 * Copyright 2012, yungzhu. All rights reserved.
 * This program is free software. You can redistribute and/or modify it
 * in accordance with the terms of the accompanying license agreement.
 */
package morn.core.components {
	import editor.core.IClip;
	
	import flash.display.MovieClip;
	import flash.events.Event;
	
	import morn.core.handlers.Handler;
	
	/**
	 * 矢量动画类
	 */
	public class FrameClip extends Component implements IClip {
		private var _autoStopAtRemoved:Boolean = true;
		private var _mc:MovieClip;
		private var _skin:String;
		private var _from:Object;
		private var _to:Object;
		private var _replay:Boolean;
		private var _complete:Handler;
		private var _autoPlay:Boolean;
		
		public function FrameClip(skin:String = null) {
			this.skin = skin;
			addEventListener(Event.REMOVED_FROM_STAGE, onRemovedFromStage);
		}
		
		private function onRemovedFromStage(e:Event):void {
			if (_autoStopAtRemoved) {
				stop();
			}
		}
		
		/**从某帧播放到某帧，播放结束发送事件*/
		public function playFromTo(from:Object = null, to:Object = null, complete:Handler = null, replay:Boolean = false):void {
			if (_mc) {
				_from = from || 0;
				_to = to || _mc.totalFrames;
				_replay = replay;
				_complete = complete;
				gotoAndPlay(_from);
				if (!hasEventListener(Event.ENTER_FRAME)) {
					addEventListener(Event.ENTER_FRAME, onEnterFrame);
				}
			}
		}
		
		private function onEnterFrame(e:Event):void {
			if (_mc.currentFrame == _to || _mc.currentLabel == _to) {
				if (_replay) {
					gotoAndPlay(_from);
				} else {
					removeEventListener(Event.ENTER_FRAME, onEnterFrame);
					stop();
					sendEvent(UIEvent.PLAY_COMPLETED);
					if (_complete != null) {
						var handler:Handler = _complete;
						_complete = null;
						handler.execute();
					}
				}
			}
		}
		
		/**开始播放*/
		public function play():void {
			if (_mc) {
				_mc.play();
			}
		}
		
		/**停止播放*/
		public function stop():void {
			if (_mc) {
				_mc.stop();
			}
		}
		
		/**从某帧并开始播放*/
		public function gotoAndPlay(frame:Object):void {
			if (_mc) {
				_mc.gotoAndPlay(frame);
			}
		}
		
		/**停在某帧*/
		public function gotoAndStop(frame:Object):void {
			if (_mc) {
				_mc.gotoAndStop(frame);
			}
		}
		
		/**从显示列表里面删除时是否自动停止*/
		public function get autoStopAtRemoved():Boolean {
			return _autoStopAtRemoved;
		}
		
		public function set autoStopAtRemoved(value:Boolean):void {
			_autoStopAtRemoved = value;
		}
		
		/**资源*/
		public function get skin():String {
			return _skin;
		}
		
		public function set skin(value:String):void {
			if (_skin != value) {
				_skin = value;
				mc = App.asset.getAsset(value);
			}
		}
		
		/**矢量动画*/
		public function get mc():MovieClip {
			return _mc;
		}
		
		public function set mc(value:MovieClip):void {
			if (_mc != value) {
				if (_mc != null && _mc.parent) {
					_mc.stop();
					removeChild(_mc);
				}
				_mc = value;
				if (_mc != null) {
					_mc.stop();
					addChild(_mc);
					_width = mc.width;
					_height = mc.height;
				}
			}
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
		
		override protected function changeSize():void {
			if (_mc) {
				_mc.width = _width;
				_mc.height = _height;
			}
			super.changeSize();
		}
	}
}