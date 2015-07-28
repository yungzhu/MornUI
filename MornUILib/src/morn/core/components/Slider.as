/**
 * Morn UI Version 3.0 http://www.mornui.com/
 * Feedback yungvip@163.com weixin:yungzhu
 */
package morn.core.components {
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	import morn.core.handlers.Handler;
	
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
		protected var _bar:Button;
		protected var _label:Label;
		protected var _showLabel:Boolean = true;
		protected var _changeHandler:Handler;
		
		public function Slider(skin:String = null):void {
			this.skin = skin;
		}
		
		/**销毁*/
		override public function dispose():void {
			super.dispose();
			_back && _back.dispose();
			_bar && _bar.dispose();
			_label && _label.dispose();
			_back = null;
			_bar = null;
			_label = null;
			_changeHandler = null;
		}
		
		override protected function preinitialize():void {
			mouseChildren = true;
		}
		
		override protected function createChildren():void {
			addChild(_back = new Image());
			addChild(_bar = new Button());
			addChild(_label = new Label());
		}
		
		override protected function initialize():void {
			_bar.addEventListener(MouseEvent.MOUSE_DOWN, onButtonMouseDown);
			_back.sizeGrid = _bar.sizeGrid = "4,4,4,4";
			allowBackClick = true;
		}
		
		protected function onButtonMouseDown(e:MouseEvent):void {
			App.stage.addEventListener(MouseEvent.MOUSE_UP, onStageMouseUp);
			App.stage.addEventListener(MouseEvent.MOUSE_MOVE, onStageMouseMove);
			if (_direction == VERTICAL) {
				_bar.startDrag(false, new Rectangle(_bar.x, 0, 0, height - _bar.height));
			} else {
				_bar.startDrag(false, new Rectangle(0, _bar.y, width - _bar.width, 0));
			}
			//显示提示
			showValueText();
		}
		
		protected function showValueText():void {
			if (_showLabel) {
				_label.text = _value + "";
				if (_direction == VERTICAL) {
					_label.x = _bar.x + 20;
					_label.y = (_bar.height - _label.height) * 0.5 + _bar.y;
				} else {
					_label.y = _bar.y - 20;
					_label.x = (_bar.width - _label.width) * 0.5 + _bar.x;
				}
			}
		}
		
		protected function hideValueText():void {
			_label.text = "";
		}
		
		protected function onStageMouseUp(e:MouseEvent):void {
			App.stage.removeEventListener(MouseEvent.MOUSE_UP, onStageMouseUp);
			App.stage.removeEventListener(MouseEvent.MOUSE_MOVE, onStageMouseMove);
			_bar.stopDrag();
			hideValueText();
		}
		
		protected function onStageMouseMove(e:MouseEvent):void {
			var oldValue:Number = _value;
			if (_direction == VERTICAL) {
				_value = _bar.y / (height - _bar.height) * (_max - _min) + _min;
			} else {
				_value = _bar.x / (width - _bar.width) * (_max - _min) + _min;
			}
			_value = Math.round(_value / _tick) * _tick;
			if (_value != oldValue) {
				showValueText();
				sendChangeEvent();
			}
		}
		
		protected function sendChangeEvent():void {
			sendEvent(Event.CHANGE);
			if (_changeHandler != null) {
				_changeHandler.executeWith([_value]);
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
				_bar.skin = _skin + "$bar";
				_contentWidth = _back.width;
				_contentHeight = _back.height;
				setBarPoint();
			}
		}
		
		override protected function changeSize():void {
			super.changeSize();
			_back.width = width;
			_back.height = height;
			setBarPoint();
		}
		
		protected function setBarPoint():void {
			if (_direction == VERTICAL) {
				_bar.x = (_back.width - _bar.width) * 0.5;
			} else {
				_bar.y = (_back.height - _bar.height) * 0.5;
			}
		}
		
		/**九宫格信息，格式：左边距,上边距,右边距,下边距,是否重复填充(值为0或1)，例如：4,4,4,4,1*/
		public function get sizeGrid():String {
			return _back.sizeGrid;
		}
		
		public function set sizeGrid(value:String):void {
			_back.sizeGrid = value;
			_bar.sizeGrid = value;
		}
		
		protected function changeValue():void {
			_value = Math.round(_value / _tick) * _tick;
			_value = _value > _max ? _max : _value < _min ? _min : _value;
			if (_direction == VERTICAL) {
				_bar.y = (_value - _min) / (_max - _min) * (height - _bar.height);
			} else {
				_bar.x = (_value - _min) / (_max - _min) * (width - _bar.width);
			}
		}
		
		/**设置滑动条*/
		public function setSlider(min:Number, max:Number, value:Number):void {
			_value = -1;
			_min = min;
			_max = max > min ? max : min;
			this.value = value < min ? min : value > max ? max : value;
		}
		
		/**刻度值，默认值为1*/
		public function get tick():Number {
			return _tick;
		}
		
		public function set tick(value:Number):void {
			_tick = value;
			callLater(changeValue);
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
			if (_value != num) {
				_value = num;
				//callLater(changeValue);
				//callLater(sendChangeEvent);
				changeValue();
				sendChangeEvent();
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
			if (_direction == VERTICAL) {
				value = _back.mouseY / (height - _bar.height) * (_max - _min) + _min;
			} else {
				value = _back.mouseX / (width - _bar.width) * (_max - _min) + _min;
			}
		}
		
		override public function set dataSource(value:Object):void {
			_dataSource = value;
			if (value is Number || value is String) {
				this.value = Number(value);
			} else {
				super.dataSource = value;
			}
		}
		
		/**控制按钮*/
		public function get bar():Button {
			return _bar;
		}
		
		/**数据变化处理器*/
		public function get changeHandler():Handler {
			return _changeHandler;
		}
		
		public function set changeHandler(value:Handler):void {
			_changeHandler = value;
		}
	}
}