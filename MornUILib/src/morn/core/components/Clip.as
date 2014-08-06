/**
 * Morn UI Version 3.0 http://www.mornui.com/
 * Feedback yungzhu@gmail.com http://weibo.com/newyung
 */
package morn.core.components {
	import flash.display.BitmapData;
	import flash.events.Event;
	import morn.core.events.UIEvent;
	import morn.core.handlers.Handler;
	import morn.core.utils.StringUtils;
	import morn.editor.core.IClip;
	
	/**图片加载后触发*/
	[Event(name="imageLoaded",type="morn.core.events.UIEvent")]
	/**当前帧发生变化后触发*/
	[Event(name="frameChanged",type="morn.core.events.UIEvent")]
	
	/**位图剪辑*/
	public class Clip extends Component implements IClip {
		protected var _autoStopAtRemoved:Boolean = true;
		protected var _bitmap:AutoBitmap;
		protected var _clipX:int = 1;
		protected var _clipY:int = 1;
		protected var _clipWidth:Number;
		protected var _clipHeight:Number;
		protected var _url:String;
		protected var _autoPlay:Boolean;
		protected var _interval:int = Config.MOVIE_INTERVAL;
		protected var _from:int = -1;
		protected var _to:int = -1;
		protected var _complete:Handler;
		protected var _isPlaying:Boolean;
		
		/**位图切片
		 * @param url 资源类库名或者地址
		 * @param clipX x方向个数
		 * @param clipY y方向个数*/
		public function Clip(url:String = null, clipX:int = 1, clipY:int = 1) {
			_clipX = clipX;
			_clipY = clipY;
			this.url = url;
		}
		
		override protected function createChildren():void {
			addChild(_bitmap = new AutoBitmap());
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
		
		/**位图剪辑地址，如果值为已加载资源，会马上显示，否则会先加载后显示
		 * 举例：url="png.comp.clip" 或者 url="assets/img/clip.png"*/
		public function get url():String {
			return _url;
		}
		
		public function set url(value:String):void {
			if (_url != value && Boolean(value)) {
				_url = value;
				callLater(changeClip);
			}
		}
		
		/**图片地址，等同于url*/
		public function get skin():String {
			return _url;
		}
		
		public function set skin(value:String):void {
			url = value;
		}
		
		/**切片X轴数量*/
		public function get clipX():int {
			return _clipX;
		}
		
		public function set clipX(value:int):void {
			if (_clipX != value) {
				_clipX = value;
				callLater(changeClip);
			}
		}
		
		/**切片Y轴数量*/
		public function get clipY():int {
			return _clipY;
		}
		
		public function set clipY(value:int):void {
			if (_clipY != value) {
				_clipY = value;
				callLater(changeClip);
			}
		}
		
		/**单切片宽度，同时设置优先级高于clipX*/
		public function get clipWidth():Number {
			return _clipWidth;
		}
		
		public function set clipWidth(value:Number):void {
			_clipWidth = value;
			callLater(changeClip);
		}
		
		/**单切片高度，同时设置优先级高于clipY*/
		public function get clipHeight():Number {
			return _clipHeight;
		}
		
		public function set clipHeight(value:Number):void {
			_clipHeight = value;
			callLater(changeClip);
		}
		
		protected function changeClip():void {
			if (App.asset.hasClass(_url)) {
				loadComplete(_url, false, App.asset.getBitmapData(_url, false));
			} else {
				App.mloader.loadBMD(_url, 1, new Handler(loadComplete, [_url, true]));
			}
		}
		
		protected function loadComplete(url:String, isLoad:Boolean, bmd:BitmapData):void {
			if (url == _url && bmd) {
				if (!isNaN(_clipWidth)) {
					_clipX = Math.ceil(bmd.width / _clipWidth);
				}
				if (!isNaN(_clipHeight)) {
					_clipY = Math.ceil(bmd.height / _clipHeight);
				}
				clips = App.asset.getClips(url, _clipX, _clipY, true, isLoad ? bmd.clone() : bmd);
			}
		}
		
		/**源位图数据*/
		public function get clips():Vector.<BitmapData> {
			return _bitmap.clips;
		}
		
		public function set clips(value:Vector.<BitmapData>):void {
			if (value) {
				_bitmap.clips = value;
				_contentWidth = _bitmap.width;
				_contentHeight = _bitmap.height;
			}
			sendEvent(UIEvent.IMAGE_LOADED);
		}
		
		override public function set width(value:Number):void {
			super.width = value;
			_bitmap.width = value;
		}
		
		override public function set height(value:Number):void {
			super.height = value;
			_bitmap.height = value;
		}
		
		override public function commitMeasure():void {
			exeCallLater(changeClip);
		}
		
		/**九宫格信息，格式：左边距,上边距,右边距,下边距,是否重复填充(值为0或1)，例如：4,4,4,4,1*/
		public function get sizeGrid():String {
			if (_bitmap.sizeGrid) {
				return _bitmap.sizeGrid.join(",");
			}
			return null;
		}
		
		public function set sizeGrid(value:String):void {
			_bitmap.sizeGrid = StringUtils.fillArray(Styles.defaultSizeGrid, value);
		}
		
		/**当前帧*/
		public function get frame():int {
			return _bitmap.index;
		}
		
		public function set frame(value:int):void {
			_bitmap.index = value;
			sendEvent(UIEvent.FRAME_CHANGED);
			if (_bitmap.index == _to) {
				stop();
				_to = -1;
				if (_complete != null) {
					var handler:Handler = _complete;
					_complete = null;
					handler.execute();
				}
			}
		}
		
		/**当前帧，等同于frame*/
		public function get index():int {
			return _bitmap.index;
		}
		
		public function set index(value:int):void {
			frame = value;
		}
		
		/**切片帧的总数*/
		public function get totalFrame():int {
			exeCallLater(changeClip);
			return _bitmap.clips ? _bitmap.clips.length : 0;
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
			frame = _bitmap.index;
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
		 * @param to 结束帧(为-1时默认为最后一帧) */
		public function playFromTo(from:int = -1, to:int = -1, complete:Handler = null):void {
			_from = from == -1 ? 0 : from;
			_to = to == -1 ? _clipX * _clipY - 1 : to;
			_complete = complete;
			gotoAndPlay(_from);
		}
		
		override public function set dataSource(value:Object):void {
			_dataSource = value;
			if (value is int || value is String) {
				frame = int(value);
			} else {
				super.dataSource = value;
			}
		}
		
		/**是否对位图进行平滑处理*/
		public function get smoothing():Boolean {
			return _bitmap.smoothing;
		}
		
		public function set smoothing(value:Boolean):void {
			_bitmap.smoothing = value;
		}
		
		/**X锚点，值为0-1*/
		public function get anchorX():Number {
			return _bitmap.anchorX;
		}
		
		public function set anchorX(value:Number):void {
			_bitmap.anchorX = value;
		}
		
		/**Y锚点，值为0-1*/
		public function get anchorY():Number {
			return _bitmap.anchorY;
		}
		
		public function set anchorY(value:Number):void {
			_bitmap.anchorY = value;
		}
		
		/**位图实体*/
		public function get bitmap():AutoBitmap {
			return _bitmap;
		}
		
		/**销毁资源
		 * @param	clearFromLoader 是否同时删除加载缓存*/
		public function dispose(clearFromLoader:Boolean = false):void {
			_bitmap.bitmapData = null;
			App.asset.destroyClips(_url);
			if (clearFromLoader) {
				App.mloader.clearResLoaded(_url);
			}
		}
	}
}