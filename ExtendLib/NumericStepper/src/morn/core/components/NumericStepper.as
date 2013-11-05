package morn.core.components 
{
	import flash.events.Event;
	import flash.events.MouseEvent;
	import morn.core.handlers.Handler;
	import morn.core.utils.ObjectUtils;
	/**
	 * ...
	 * @author handylee
	 */
	public class NumericStepper extends Component {
		public static const LEFT:String = "left";
		public static const RIGHT:String = "right";
		public static const SERPERATE:String = "serperate";
		
		protected var _skin:String;
		protected var _input:TextInput;
		protected var _upButton:Button;
		protected var _downButton:Button;
		protected var _changeHandler:Handler;
		protected var _direction:String = RIGHT;
		protected var _color:Object = 0x0;
		protected var _value:Number = 1;
		protected var _serperate:Boolean = false;
		
		public var step:Number = 1;
		public var min:Number= 0;
		public var max:Number = 100;
		public var fixedNum:int = 0;
		
		public function NumericStepper(skin:String = null) {
			this._skin = skin;
		}
		
		override protected function preinitialize():void {
			mouseChildren = true;
		}
		
		override protected function createChildren():void {
			addChild(_input = new TextInput());
			addChild(_upButton = new Button());
			addChild(_downButton = new Button());
		}
		
		override protected function initialize():void {
			_input.restrict = "0-9\\.";
			_input.color = color;
			_input.text = _value.toString();
			_input.width = int(fontSize) * 3;
			_input.addEventListener(Event.CHANGE, onChange);
			_upButton.addEventListener(MouseEvent.MOUSE_DOWN, onButtonMouseDown);
			_downButton.addEventListener(MouseEvent.MOUSE_DOWN, onButtonMouseDown);
			_upButton.buttonMode = _downButton.buttonMode = true;
		}
		
		
		protected function onChange(e:Event = null):void {
			sendEvent(Event.CHANGE);
			if (_changeHandler != null) {
				_changeHandler.executeWith([value]);
			}
		}
		
		protected function onButtonMouseDown(e:MouseEvent):void {
			var isUp:Boolean = e.currentTarget == _upButton;
			changeValue(isUp);
		}
		
		private function changeValue(isUp:Boolean):void {
			var c:Number = Number(_input.text);
			if (isUp) {
				c+=step;
			}else {
				c-=step;
			}
			value = Math.max(Math.min(c,max),min);
		}
		
		public function get color():Object {
			return _color;
		}
		
		public function set color(v:Object):void {
			_color = v;
			_input.color = _color;
		}
		
		public function get fontSize():Object {
			return _input.size;
		}
		
		public function set fontSize(v:Object):void {
			_input.size = int(v);
		}
		
		public function get bold():Object {
			return _input.bold;
		}
		
		public function set bold(v:Object):void {
			_input.bold = v;
		}
		
		public function get value():Number {
			return _value;
		}
		
		public function set value(v:Number):void {
			_value = Number(v.toFixed(fixedNum));
			_input.text = _value.toString();
		}
		
		public function get stroke():String {
			return _input.stroke;
		}
		
		
		public function set stroke(v:String):void {
			_input.stroke = v;
		}
		
		public function set changeHandler(v:Handler):void {
			_changeHandler = v;
		}
		
		public function get direction():String {
			return _direction;
		}
		
		public function set direction(v:String):void {
			if (_direction == v) return;
			_direction = v;
			if (_direction == SERPERATE) {
				if (_skin) {
					_upButton.skin = _skin + "$right";
					_downButton.skin = _skin + "$left";
					_upButton.height = _downButton.height = _height;
				}else {
					drawDefaultStyle();
				}
			}else {
				if (_skin) {
					_upButton.skin = _skin + "$up";
					_downButton.skin = _skin + "$down";
					_upButton.height = _downButton.height = _height/2;
				}else {
					drawDefaultStyle();
				}
			}
			callLater(changeSize);
		}
		
		
		/**皮肤*/
		public function get skin():String {
			return _skin;
		}
		
		public function set skin(value:String):void {
			if (value && _skin != value) {
				_upButton.graphics.clear();
				_downButton.graphics.clear();
				_input.graphics.clear();
				_skin = value;
				_input.skin = _skin;
				if(_direction!=SERPERATE){
					_upButton.skin = _skin + "$up";
					_downButton.skin = _skin + "$down";
					_width = _input.width + _upButton.width;
					_height = _upButton.height + _downButton.height;
				}else {
					_upButton.skin = _skin + "$right";
					_downButton.skin = _skin + "$left";
					_width = _input.width + _upButton.width + _downButton.width;
					_height = _upButton.height;
				};
			}else {
				_width = 40;
				_height = 20;
				drawDefaultStyle();
			}
			callLater(changeSize);
		}
		
		private function drawDefaultStyle():void {
			if (skin) return;
			var w:int = 15;
			var h:Number = (_direction == SERPERATE?_height:_height / 2);
			color = 0x000000;
			_input.height = _height;
			_input.graphics.clear();
			_input.graphics.lineStyle(1, 0x00CCFF);
			_input.graphics.beginFill(0xFFFFFF);
			_input.graphics.drawRect(0, 0, _width - w, _height);
			_input.graphics.endFill();
			//_upButton.label = "↑";
			//_downButton.label = "↓";
			
			_upButton.width = _downButton.width = w;
			_upButton.height = _downButton.height = h;
			
			_upButton.graphics.clear();
			_upButton.graphics.lineStyle(1, 0x222222);
			_upButton.graphics.beginFill(0x222222);
			_upButton.graphics.drawRect(0, 0, w, h);
			_upButton.graphics.endFill();
			_upButton.graphics.lineStyle();
			
			_upButton.graphics.beginFill(0x00CCFF);
			if(_direction !=SERPERATE){
				_upButton.graphics.moveTo(w / 2, 3);
				_upButton.graphics.lineTo(3, h-3);
				_upButton.graphics.lineTo(w - 3, h-3);
				_upButton.graphics.lineTo(w / 2, 3);
			}else {
				_upButton.graphics.moveTo(3, 3);
				_upButton.graphics.lineTo(w-3, h/2);
				_upButton.graphics.lineTo(3, h-3);
				_upButton.graphics.lineTo(3, 3);
			}
			_upButton.graphics.endFill();
			
			_downButton.graphics.clear();
			_downButton.graphics.lineStyle(1, 0x222222);
			_downButton.graphics.beginFill(0x222222);
			_downButton.graphics.drawRect(0, 0, w,h);
			_downButton.graphics.endFill();
			_downButton.graphics.lineStyle();
			
			_downButton.graphics.beginFill(0x00CCFF);
			if (_direction != SERPERATE) {
				_downButton.graphics.moveTo(w / 2, h - 3);
				_downButton.graphics.lineTo(3, 3);
				_downButton.graphics.lineTo(w - 3, 3);
				_downButton.graphics.lineTo(w / 2, h - 3);
			}else {
				_downButton.graphics.moveTo(3, h/2);
				_downButton.graphics.lineTo(w-3, 3);
				_downButton.graphics.lineTo(w-3, h-3);
				_downButton.graphics.lineTo(3, h/2);
			}
			_downButton.graphics.endFill();
		}
		
		
		
		//private function 
		
		protected function resetButtonPosition():void {
			//_input.height = _height;
			if (_direction == RIGHT) {
				_input.x = 0;
				_upButton.x = _downButton.x = _input.width;
				_downButton.y = _upButton.height;
			}else if (_direction == LEFT) {
				_upButton.x = _downButton.x = 0;
				_input.x = width - _input.width;
				_downButton.y = _upButton.height;
			}else {
				_downButton.x = 0;
				_input.align = "center";
				_input.x = _downButton.width;
				_upButton.x = _downButton.width + _input.width;
				_upButton.y = _downButton.y = 0;
			}
			
			
			
		}
		
		
		
		override protected function changeSize():void {
			super.changeSize();
			if (_skin == null) drawDefaultStyle();
			_input.width = _direction!=SERPERATE ? _width - _upButton.width:_width-_upButton.width*2;
			_input.height = _height;
			_upButton.height = _downButton.height = _direction != SERPERATE?_height / 2:_height;
			_input.margin = "1,"+(_height/2  - int(fontSize)+2);
			resetButtonPosition();
		}
	}

}