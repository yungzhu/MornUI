/**
 * Morn UI Version 1.1.0313 http://code.google.com/p/morn https://github.com/yungzhu/morn
 * Feedback yungzhu@gmail.com http://weibo.com/newyung
 */
package morn.core.components {
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.events.Event;
	import morn.core.events.UIEvent;
	import morn.core.handlers.Handler;
	import morn.core.managers.ResLoader;
	import morn.core.utils.BitmapUtils;
	import morn.core.utils.StringUtils;
	import morn.editor.core.IClip;
	
	/**图片加载后触发(类库中已经存在不会触发)*/
	[Event(name="imageLoaded",type="morn.core.events.UIEvent")]
	/**当前帧发生变化后触发*/
	[Event(name="frameChanged",type="morn.core.events.UIEvent")]
	
	/**位图剪辑*/
	public class Clip extends Component implements IClip {
		protected var _autoStopAtRemoved:Boolean = true;
		protected var _bitmap:Bitmap;
		protected var _clips:Vector.<BitmapData>;
		protected var _clipX:int = 1;
		protected var _clipY:int = 1;
		protected var _url:String;
		protected var _frame:int;
		protected var _autoPlay:Boolean;
		protected var _interval:int = Config.MOVIE_INTERVAL;
		protected var _from:int = -1;
		protected var _to:int = -1;
		protected var _complete:Handler;
		protected var _isPlaying:Boolean;
		
		/**位图切片
		 * @param url 资源类库名或者地址
		 * @param clipX x方向个数
		 * @param clipY y方向个数
		 */
		public function Clip(url:String = null, clipX:int = 1, clipY:int = 1) {
			_clipX = clipX;
			_clipY = clipY;
			this.url = url;
		}
		
		override protected function createChildren():void {
			addChild(_bitmap = new Bitmap());
		}
		
		override protected function initialize():void {
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			addEventListener(Event.REMOVED_FROM_STAGE, onRemovedFromStage);
		}
		
		protected function onAddedToStage(e:Event):void {
			if (_autoPlay) {
				play();
			}
		}
		
		protected function onRemovedFromStage(e:Event):void {
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
		
		protected function changeClip():void {
			if (App.asset.hasClass(_url)) {
				bitmapData = App.asset.getBitmapData(_url, false);
			} else {
				App.loader.loadBMD(_url, new Handler(loadComplete));
			}
		}
		
		protected function loadComplete(bmd:BitmapData):void {
			bitmapData = bmd;
			sendEvent(UIEvent.IMAGE_LOADED);
		}
		
		/**源位图数据*/
		public function set bitmapData(value:BitmapData):void {
			if (value) {
				_clips = BitmapUtils.createClips(value, _clipX, _clipY);
				frame = _frame;
				_contentWidth = _clips[0].width;
				_contentHeight = _clips[0].height;
				_bitmap.width = width;
				_bitmap.height = height;
			}
		}
		
		override public function set width(value:Number):void {
			super.width = value;
			_bitmap.width = _width;
		}
		
		override public function set height(value:Number):void {
			super.height = value;
			_bitmap.height = _height;
		}
		
		/**当前帧*/
		public function get frame():int {
			return _frame;
		}
		
		public function set frame(value:int):void {
			_frame = value;
			if (_clips) {
				_frame = (_frame < _clips.length && _frame > -1) ? _frame : 0;
				_bitmap.bitmapData = _clips[_frame];
				sendEvent(UIEvent.FRAME_CHANGED);
				if (_frame == _to) {
					stop();
					_to = -1;
					if (_complete != null) {
						var handler:Handler = _complete;
						_complete = null;
						handler.execute();
					}
				}
			}
		}
		
		/**切片帧的总数*/
		public function get totalFrame():int {
			return _clips ? _clips.length : 0;
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
				_autoPlay ? play() : stop();
			}
		}
		
		/**动画播放间隔(单位毫秒)*/
		public function get interval():int {
			return _interval;
		}
		
		public function set interval(value:int):void {
			if (_interval != value) {
				_interval = value;
				if (_isPlaying) {
					play();
				}
			}
		}
		
		/**是否正在播放*/
		public function get isPlaying():Boolean {
			return _isPlaying;
		}
		
		public function set isPlaying(value:Boolean):void {
			_isPlaying = value;
		}
		
		/**开始播放*/
		public function play():void {
			_isPlaying = true;
			frame = _frame;
			App.timer.doLoop(_interval, loop);
		}
		
		protected function loop():void {
			frame++;
		}
		
		/**停止播放*/
		public function stop():void {
			App.timer.clearTimer(loop);
			_isPlaying = false;
		}
		
		/**从指定的位置播放*/
		public function gotoAndPlay(frame:int):void {
			this.frame = frame;
			play();
		}
		
		/**跳到指定位置并停止*/
		public function gotoAndStop(frame:int):void {
			stop();
			this.frame = frame;
		}
		
		/**从某帧播放到某帧，播放结束发送事件
		 * @param from 开始帧(为-1时默认为第一帧)
		 * @param to 结束帧(为-1时默认为最后一帧)
		 */
		public function playFromTo(from:int = -1, to:int = -1, complete:Handler = null):void {
			_from = from == -1 ? 0 : from;
			_to = to == -1 ? _clipX * _clipY - 1 : to;
			_complete = complete;
			gotoAndPlay(_from);
		}
		
		override public function set dataSource(value:Object):void {
			if (value is int) {
				frame = value as int;
			} else {
				super.dataSource = value;
			}
		}
		
		/**销毁资源*/
		public function destroy(clearFromLoader:Boolean = false):void {
			App.asset.destroyClips(_url);
			_bitmap.bitmapData = null;
			if (clearFromLoader) {
				ResLoader.clearResLoaded(_url);
			}
		}
	}
}