/**
 * Version 0.9.4.1.3 https://github.com/yungzhu/morn
 * Feedback yungzhu@gmail.com http://weibo.com/newyung
 */
package morn.core.components {
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	
	/**滑动条变化后触发*/
	[Event(name="change",type="flash.events.Event")]
	
	/**滑动条*/
	public class Slider extends Component {
		/**水平移动*/
		public static const HORIZONTAL:String = "horizontal";
		/**垂直移动*/
		public static const VERTICAL:String = "vertical";
		protected var _allowBackClick:Boolean;
		protected var _max:Number = 100;
		protected var _min:Number = 0;
		protected var _tick:Number = 1;
		protected var _value:Number = 0;
		protected var _direction:String = VERTICAL;
		protected var _skin:String;
		protected var _back:Image;
		protected var _button:Button;
		protected var _label:Label;
		protected var _showLabel:Boolean = true;
		
		public function Slider(skin:String = null):void {
			this.skin = skin;
		}
		
		override protected function preinitialize():void {
			mouseChildren = true;
		}
		
		override protected function createChildren():void {
			addChild(_back = new Image());
			addChild(_button = new Button());
			addChild(_label = new Label());
		}
		
		override protected function initialize():void {
			_button.addEventListener(MouseEvent.MOUSE_DOWN, onButtonMouseDown);
			_back.sizeGrid = "4,4,4,4";
			allowBackClick = true;
		}
		
		protected function onButtonMouseDown(e:MouseEvent):void {
			App.stage.addEventListener(MouseEvent.MOUSE_UP, onStageMouseUp);
			App.stage.addEventListener(MouseEvent.MOUSE_MOVE, onStageMouseMove);
			if (_direction == HORIZONTAL) {
				_button.startDrag(false, new Rectangle(0, _button.y, _width - _button.width, 0));
			} else {
				_button.startDrag(false, new Rectangle(_button.x, 0, 0, _height - _button.height));
			}
			//显示提示
			showValueText();
		}
		
		protected function showValueText():void {
			if (_showLabel) {
				_label.text = _value + "";
				if (_direction == HORIZONTAL) {
					_label.y = _button.y - 20;
					_label.x = (_button.width - _label.width) * 0.5 + _button.realX;
				} else {
					_label.x = _button.x + 20;
					_label.y = (_button.height - _label.height) * 0.5 + _button.realY;
				}
			}
		}
		
		protected function hideValueText():void {
			_label.text = "";
		}
		
		protected function onStageMouseUp(e:MouseEvent):void {
			App.stage.removeEventListener(MouseEvent.MOUSE_UP, onStageMouseUp);
			App.stage.removeEventListener(MouseEvent.MOUSE_MOVE, onStageMouseMove);
			_button.stopDrag();
			hideValueText();
		}
		
		protected function onStageMouseMove(e:MouseEvent):void {
			var oldValue:Number = _value;
			if (_direction == HORIZONTAL) {
				_value = _button.realX / (_width - _button.width) * (_max - _min) + _min;
			} else {
				_value = _button.realY / (_height - _button.height) * (_max - _min) + _min;
			}
			_value = Math.round(_value / _tick) * _tick;
			if (_value != oldValue) {
				showValueText();
				sendEvent(Event.CHANGE);
			}
		}
		
		/**皮肤*/
		public function get skin():String {
			return _skin;
		}
		
		public function set skin(value:String):void {
			if (_skin != value) {
				_skin = value;
				_back.url = _skin;
				_button.skin = _skin + "$bar";
				width = _width == 0 ? _back.width : _width;
				height = _height == 0 ? _back.height : _height;
			}
		}
		
		override protected function changeSize():void {
			super.changeSize();
			_back.width = _width;
			_back.height = _height;
			if (_direction == HORIZONTAL) {
				_button.y = (_height - _button.height) * 0.5;
			} else {
				_button.x = (_width - _button.width) * 0.5;
			}
		}
		
		/**九宫格信息(格式:左边距,上边距,右边距,下边距)*/
		public function get sizeGrid():String {
			return _back.toString();
		}
		
		public function set sizeGrid(value:String):void {
			_back.sizeGrid = value;
		}
		
		protected function changeValue():void {
			_value = _value > _max ? _max : _value < _min ? _min : _value;
			if (_direction == HORIZONTAL) {
				_button.x = (_value - _min) / (_max - _min) * (_width - _button.width);
			} else {
				_button.y = (_value - _min) / (_max - _min) * (_height - _button.height);
			}
		}
		
		/**设置滑动条*/
		public function setSlider(min:Number, max:Number, value:Number):void {
			_min = min;
			_max = max;
			this.value = value;
		}
		
		/**刻度值*/
		public function get tick():Number {
			return _tick;
		}
		
		public function set tick(value:Number):void {
			_tick = value;
		}
		
		/**滑块上允许的最大值*/
		public function get max():Number {
			return _max;
		}
		
		public function set max(value:Number):void {
			if (_max != value) {
				_max = value;
				callLater(changeValue);
			}
		}
		
		/**滑块上允许的最小值*/
		public function get min():Number {
			return _min;
		}
		
		public function set min(value:Number):void {
			if (_min != value) {
				_min = value;
				callLater(changeValue);
			}
		}
		
		/**当前值*/
		public function get value():Number {
			return _value;
		}
		
		public function set value(num:Number):void {
			num = Math.round(num / _tick) * _tick;
			num = num > _max ? _max : num < _min ? _min : num;
			if (_value != num) {
				_value = num;
				//callLater(changeValue);
				changeValue();
				sendEvent(Event.CHANGE);
			}
		}
		
		/**滑动方向*/
		public function get direction():String {
			return _direction;
		}
		
		public function set direction(value:String):void {
			_direction = value;
		}
		
		/**是否显示标签*/
		public function get showLabel():Boolean {
			return _showLabel;
		}
		
		public function set showLabel(value:Boolean):void {
			_showLabel = value;
		}
		
		/**允许点击后面*/
		public function get allowBackClick():Boolean {
			return _allowBackClick;
		}
		
		public function set allowBackClick(value:Boolean):void {
			if (_allowBackClick != value) {
				_allowBackClick = value;
				if (_allowBackClick) {
					_back.addEventListener(MouseEvent.MOUSE_DOWN, onBackBoxMouseDown);
				} else {
					_back.removeEventListener(MouseEvent.MOUSE_DOWN, onBackBoxMouseDown);
				}
			}
		}
		
		protected function onBackBoxMouseDown(e:MouseEvent):void {
			if (_direction == HORIZONTAL) {
				value = _back.mouseX / (_width - _button.width) * (_max - _min) + _min;
			} else {
				value = _back.mouseY / (_height - _button.height) * (_max - _min) + _min;
			}
		}
		
		override public function set dataSource(value:Object):void {
			if (value is Number) {
				this.value = value as Number;
			} else {
				super.dataSource = value;
			}
		}
	}
}