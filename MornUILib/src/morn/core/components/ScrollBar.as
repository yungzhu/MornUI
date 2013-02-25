/**
 * Morn UI Version 1.1.0224 http://code.google.com/p/morn https://github.com/yungzhu/morn
 * Feedback yungzhu@gmail.com http://weibo.com/newyung
 */
package morn.core.components {
	import flash.events.Event;
	import flash.events.MouseEvent;
	import morn.core.handlers.Handler;
	import morn.core.utils.StringUtils;
	
	/**滚动位置变化后触发*/
	[Event(name="change",type="flash.events.Event")]
	
	/**滚动条*/
	public class ScrollBar extends Component {
		/**水平移动*/
		public static const HORIZONTAL:String = "horizontal";
		/**垂直移动*/
		public static const VERTICAL:String = "vertical";
		/**长按按钮，等待时间，使其可激活连续滚动*/
		protected static const DELAY_TIME:int = 500;
		protected var _scrollSize:Number = 1;
		protected var _skin:String;
		protected var _upButton:Button;
		protected var _downButton:Button;
		protected var _slider:Slider;
		protected var _changeHandler:Handler;
		
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
			App.timer.doOnce(DELAY_TIME, startLoop, [isUp]);
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
			if (_slider.direction == HORIZONTAL) {
				_slider.x = _upButton.width;
			} else {
				_slider.y = _upButton.height;
			}
			this
			resetButtonPosition();
		}
		
		protected function resetButtonPosition():void {
			if (_slider.direction == HORIZONTAL) {
				_downButton.x = _slider.x + _slider.width;
				_contentWidth = _downButton.x + _downButton.width;
				_contentHeight = _downButton.height;
			} else {
				_downButton.y = _slider.y + _slider.height;
				_contentWidth = _downButton.width;
				_contentHeight = _downButton.y + _downButton.height;
			}
		}
		
		override protected function changeSize():void {
			super.changeSize();
			if (_slider.direction == HORIZONTAL) {
				_slider.width = width - _upButton.width - _downButton.width;
			} else {
				_slider.height = height - _upButton.height - _downButton.height;
			}
			resetButtonPosition();
		}
		
		/**设置滚动条*/
		public function setScroll(min:Number, max:Number, value:Number):void {
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
		}
		
		override public function set dataSource(value:Object):void {
			if (value is Number) {
				this.value = value as Number;
			} else {
				super.dataSource = value;
			}
		}
		
		override public function get width():Number {
			if (StringUtils.isNotEmpty(_skin)) {
				return super.width;
			}
			return 0;
		}
		
		override public function get height():Number {
			if (StringUtils.isNotEmpty(_skin)) {
				return super.height;
			}
			return 0;
		}
	}
}