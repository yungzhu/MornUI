/**
 * Version 1.0.0203 https://github.com/yungzhu/morn
 * Feedback yungzhu@gmail.com http://weibo.com/newyung
 */
package morn.core.components {
	import flash.events.Event;
	import morn.core.handlers.Handler;
	
	/**值改变后触发*/
	[Event(name="change",type="flash.events.Event")]
	
	/**进度条*/
	public class ProgressBar extends Component {
		protected var _bg:Image;
		protected var _bar:Image;
		protected var _skin:String;
		protected var _value:Number = 0.5;
		protected var _label:String;
		protected var _barLabel:Label;
		protected var _changeHandler:Handler;
		
		public function ProgressBar(skin:String = null) {
			this.skin = skin;
		}
		
		override protected function createChildren():void {
			addChild(_bg = new Image());
			addChild(_bar = new Image());
			addChild(_barLabel = new Label());
		}
		
		override protected function initialize():void {
			_barLabel.width = 200;
			_barLabel.height = 18;
			_barLabel.align = "center";
			_barLabel.stroke = "0x004080";
			_barLabel.color = 0xffffff;
		}
		
		/**皮肤*/
		public function get skin():String {
			return _skin;
		}
		
		public function set skin(value:String):void {
			if (_skin != value) {
				_skin = value;
				_bg.url = _skin;
				_bar.url = _skin + "$bar";
				width = _width == 0 ? _bg.width : _width;
				height = _height == 0 ? _bg.height : _height;
			}
		}
		
		/**当前值(0-1)*/
		public function get value():Number {
			return _value;
		}
		
		public function set value(value:Number):void {
			if (_value != value) {
				value = value > 1 ? 1 : value < 0 ? 0 : value;
				_value = value;
				sendEvent(Event.CHANGE);
				if (_changeHandler != null) {
					_changeHandler.executeWith([_value]);
				}
				callLater(changeValue);
			}
		}
		
		protected function changeValue():void {
			_bar.width = _width * _value;
		}
		
		/**标签*/
		public function get label():String {
			return _label;
		}
		
		public function set label(value:String):void {
			if (_label != value) {
				_label = value;
				_barLabel.text = _label;
			}
		}
		
		/**进度条*/
		public function get bar():Image {
			return _bar;
		}
		
		/**标签实体*/
		public function get barLabel():Label {
			return _barLabel;
		}
		
		/**九宫格信息(格式:左边距,上边距,右边距,下边距)*/
		public function get sizeGrid():String {
			return _bg.sizeGrid;
		}
		
		public function set sizeGrid(value:String):void {
			_bg.sizeGrid = _bar.sizeGrid = value;
		}
		
		override public function set width(value:Number):void {
			super.width = value;
			_bg.width = _width;
			_barLabel.x = (_width - _barLabel.width) * 0.5;
			callLater(changeValue);
		}
		
		override public function set height(value:Number):void {
			super.height = value;
			_bg.height = _height;
			_bar.height = _height;
			_barLabel.y = (_height - _barLabel.height) * 0.5 - 2;
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