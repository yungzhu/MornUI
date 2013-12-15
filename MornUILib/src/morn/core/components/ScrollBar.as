/**
 * Morn UI Version 2.5.1215 http://www.mornui.com/
 * Feedback yungzhu@gmail.com http://weibo.com/newyung
 */
package morn.core.components {
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import morn.core.handlers.Handler;
	
	/**滚动位置变化后触发*/
	[Event(name="change",type="flash.events.Event")]
	
	/**滚动条*/
	public class ScrollBar extends Component {
		/**水平移动*/
		public static const HORIZONTAL:String = "horizontal";
		/**垂直移动*/
		public static const VERTICAL:String = "vertical";
		protected var _scrollSize:Number = 1;
		protected var _skin:String;
		protected var _upButton:Button;
		protected var _downButton:Button;
		protected var _slider:Slider;
		protected var _changeHandler:Handler;
		protected var _thumbPercent:Number = 1;
		protected var _target:Component;
		protected var _touchScrollEnable:Boolean = Config.touchScrollEnable;
		protected var _lastPoint:Point;
		protected var _lastOffset:Number;
		
		public function ScrollBar(skin:String = null):void {
			this.skin = skin;
		}
		
		override protected function preinitialize():void {
			mouseChildren = true;
		}
		
		override protected function createChildren():void {
			addChild(_slider = new Slider());
			addChild(_upButton = new Button());
			addChild(_downButton = new Button());
		}
		
		override protected function initialize():void {
			_slider.showLabel = false;
			_slider.addEventListener(Event.CHANGE, onSliderChange);
			_slider.setSlider(0, 0, 0);
			_upButton.addEventListener(MouseEvent.MOUSE_DOWN, onButtonMouseDown);
			_downButton.addEventListener(MouseEvent.MOUSE_DOWN, onButtonMouseDown);
		}
		
		protected function onSliderChange(e:Event):void {
			sendEvent(Event.CHANGE);
			if (_changeHandler != null) {
				_changeHandler.executeWith([value]);
			}
		}
		
		protected function onButtonMouseDown(e:MouseEvent):void {
			var isUp:Boolean = e.currentTarget == _upButton;
			slide(isUp);
			App.timer.doOnce(Styles.scrollBarDelayTime, startLoop, [isUp]);
			App.stage.addEventListener(MouseEvent.MOUSE_UP, onStageMouseUp);
		}
		
		protected function startLoop(isUp:Boolean):void {
			App.timer.doFrameLoop(1, slide, [isUp]);
		}
		
		protected function slide(isUp:Boolean):void {
			if (isUp) {
				value -= _scrollSize;
			} else {
				value += _scrollSize;
			}
		}
		
		protected function onStageMouseUp(e:MouseEvent):void {
			App.stage.removeEventListener(MouseEvent.MOUSE_UP, onStageMouseUp);
			App.timer.clearTimer(startLoop);
			App.timer.clearTimer(slide);
		}
		
		/**皮肤*/
		public function get skin():String {
			return _skin;
		}
		
		public function set skin(value:String):void {
			if (_skin != value) {
				_skin = value;
				_slider.skin = _skin;
				_upButton.skin = _skin + "$up";
				_downButton.skin = _skin + "$down";
				callLater(changeScrollBar);
			}
		}
		
		protected function changeScrollBar():void {
			if (_slider.direction == VERTICAL) {
				_slider.y = _upButton.height;
			} else {
				_slider.x = _upButton.width;
			}
			resetButtonPosition();
		}
		
		protected function resetButtonPosition():void {
			if (_slider.direction == VERTICAL) {
				_downButton.y = _slider.y + _slider.height;
				_contentWidth = _downButton.width;
				_contentHeight = _downButton.y + _downButton.height;
			} else {
				_downButton.x = _slider.x + _slider.width;
				_contentWidth = _downButton.x + _downButton.width;
				_contentHeight = _downButton.height;
			}
		}
		
		override protected function changeSize():void {
			super.changeSize();
			if (_slider.direction == VERTICAL) {
				_slider.height = height - _upButton.height - _downButton.height;
			} else {
				_slider.width = width - _upButton.width - _downButton.width;
			}
			resetButtonPosition();
		}
		
		/**设置滚动条*/
		public function setScroll(min:Number, max:Number, value:Number):void {
			exeCallLater(changeSize);
			_slider.setSlider(min, max, value);
			_upButton.disabled = max <= 0;
			_downButton.disabled = max <= 0;
			_slider.bar.visible = max > 0;
		}
		
		/**最大滚动位置*/
		public function get max():Number {
			return _slider.max;
		}
		
		public function set max(value:Number):void {
			_slider.max = value;
		}
		
		/**最小滚动位置*/
		public function get min():Number {
			return _slider.min;
		}
		
		public function set min(value:Number):void {
			_slider.min = value;
		}
		
		/**当前滚动位置*/
		public function get value():Number {
			return _slider.value;
		}
		
		public function set value(value:Number):void {
			_slider.value = value;
		}
		
		/**滚动方向*/
		public function get direction():String {
			return _slider.direction;
		}
		
		public function set direction(value:String):void {
			_slider.direction = value;
		}
		
		/**9宫格(格式[4,4,4,4]，分别为[左边距,上边距,右边距,下边距])*/
		public function get sizeGrid():String {
			return _slider.sizeGrid;
		}
		
		public function set sizeGrid(value:String):void {
			_slider.sizeGrid = value;
		}
		
		/**点击按钮滚动量*/
		public function get scrollSize():Number {
			return _scrollSize;
		}
		
		public function set scrollSize(value:Number):void {
			_scrollSize = value;
			//_slider.tick = value;
		}
		
		override public function set dataSource(value:Object):void {
			_dataSource = value;
			if (value is Number || value is String) {
				this.value = Number(value);
			} else {
				super.dataSource = value;
			}
		}
		
		/**滑条长度比例(0-1)*/
		public function get thumbPercent():Number {
			return _thumbPercent;
		}
		
		public function set thumbPercent(value:Number):void {
			exeCallLater(changeSize);
			_thumbPercent = value;
			if (_slider.direction == VERTICAL) {
				_slider.bar.height = Math.max(int(_slider.height * value), Styles.scrollBarMinNum);
			} else {
				_slider.bar.width = Math.max(int(_slider.width * value), Styles.scrollBarMinNum);
			}
		}
		
		/**滚动对象*/
		public function get target():Component {
			return _target;
		}
		
		public function set target(value:Component):void {
			if (_target) {
				_target.removeEventListener(MouseEvent.MOUSE_WHEEL, onMouseWheel);
				_target.removeEventListener(MouseEvent.MOUSE_DOWN, onTargetMouseDown);
			}
			_target = value;
			if (value) {
				_target.addEventListener(MouseEvent.MOUSE_WHEEL, onMouseWheel);
				if (_touchScrollEnable) {
					_target.addEventListener(MouseEvent.MOUSE_DOWN, onTargetMouseDown);
				}
			}
		}
		
		/**是否触摸滚动，默认为true*/
		public function get touchScrollEnable():Boolean {
			return _touchScrollEnable;
		}
		
		public function set touchScrollEnable(value:Boolean):void {
			_touchScrollEnable = value;
		}
		
		protected function onTargetMouseDown(e:MouseEvent):void {
			_target.mouseChildren = true;
			App.timer.clearTimer(tweenMove);
			if (!this.contains(e.target as DisplayObject)) {
				App.stage.addEventListener(MouseEvent.MOUSE_UP, onStageMouseUp2);
				App.stage.addEventListener(Event.ENTER_FRAME, onStageEnterFrame);
				_lastPoint = new Point(App.stage.mouseX, App.stage.mouseY);
			}
		}
		
		protected function onStageEnterFrame(e:Event):void {
			_lastOffset = _slider.direction == VERTICAL ? App.stage.mouseY - _lastPoint.y : App.stage.mouseX - _lastPoint.x;
			if (Math.abs(_lastOffset) >= 1) {
				_lastPoint.x = App.stage.mouseX;
				_lastPoint.y = App.stage.mouseY;
				_target.mouseChildren = false;
				value -= _lastOffset;
			}
		}
		
		protected function onStageMouseUp2(e:MouseEvent):void {
			App.stage.removeEventListener(MouseEvent.MOUSE_UP, onStageMouseUp2);
			App.stage.removeEventListener(Event.ENTER_FRAME, onStageEnterFrame);
			if (Math.abs(_lastOffset) > 50) {
				_lastOffset = 50 * (_lastOffset > 0 ? 1 : -1);
			}
			App.timer.doFrameLoop(1, tweenMove);
		}
		
		private function tweenMove():void {
			_lastOffset = _lastOffset * 0.92;
			value -= _lastOffset;
			if (Math.abs(_lastOffset) < 0.5) {
				_target.mouseChildren = true;
				App.timer.clearTimer(tweenMove);
			}
		}
		
		protected function onMouseWheel(e:MouseEvent):void {
			value += (e.delta < 0 ? 1 : -1) * _thumbPercent * (max - min);
			if (value < max && value > min) {
				e.stopPropagation();
			}
		}
	}
}