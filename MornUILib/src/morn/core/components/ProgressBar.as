/**
 * Morn UI Version 3.0 http://www.mornui.com/
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
				_contentWidth = _bg.width;
				_contentHeight = _bg.height;
				callLater(changeLabelPoint);
				callLater(changeValue);
			}
		}
		
		protected function changeLabelPoint():void {
			_barLabel.x = (width - _barLabel.width) * 0.5;
			_barLabel.y = (height - _barLabel.height) * 0.5 - 2;
		}
		
		/**当前值(0-1)*/
		public function get value():Number {
			return _value;
		}
		
		public function set value(num:Number):void {
			if (_value != num) {
				num = num > 1 ? 1 : num < 0 ? 0 : num;
				_value = num;
				callLater(changeValue);
				sendEvent(Event.CHANGE);
				if (_changeHandler != null) {
					_changeHandler.executeWith([num]);
				}
			}
		}
		
		protected function changeValue():void {
			if (sizeGrid) {
				var grid:Array = sizeGrid.split(",");
				var left:Number = grid[0];
				var right:Number = grid[2];
				var max:Number = width - left - right;
				var sw:Number = max * _value;
				_bar.width = left + right + sw;
				_bar.visible = _bar.width > left + right;
			} else {
				_bar.width = width * _value;
			}
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
		
		/**九宫格信息，格式：左边距,上边距,右边距,下边距,是否重复填充(值为0或1)，例如：4,4,4,4,1*/
		public function get sizeGrid():String {
			return _bg.sizeGrid;
		}
		
		public function set sizeGrid(value:String):void {
			_bg.sizeGrid = _bar.sizeGrid = value;
		}
		
		override public function set width(value:Number):void {
			super.width = value;
			_bg.width = _width;
			_barLabel.width = _width;
			callLater(changeLabelPoint);
			callLater(changeValue);
		}
		
		override public function set height(value:Number):void {
			super.height = value;
			_bg.height = _height;
			_bar.height = _height;
			callLater(changeLabelPoint);
		}
		
		override public function set dataSource(value:Object):void {
			_dataSource = value;
			if (value is Number || value is String) {
				this.value = Number(value);
			} else {
				super.dataSource = value;
			}
		}
	}
}