/**
 * Morn UI Version 3.0 http://www.mornui.com/
 * Feedback yungzhu@gmail.com http://weibo.com/newyung
 */
package morn.core.components {
	import flash.display.DisplayObject;
	
	/**单选按钮组，默认selectedIndex=-1*/
	public class RadioGroup extends Group {
		/**横向的*/
		public static const HORIZENTAL:String = "horizontal";
		/**纵向的*/
		public static const VERTICAL:String = "vertical";
		
		public function RadioGroup(labels:String = null, skin:String = null) {
			super(labels, skin);
			_direction = HORIZENTAL;
		}
		
		override protected function createItem(skin:String, label:String):DisplayObject {
			return new RadioButton(skin, label);
		}
		
		override protected function changeLabels():void {
			if (_items) {
				var left:Number = 0
				for (var i:int = 0, n:int = _items.length; i < n; i++) {
					var radio:RadioButton = _items[i] as RadioButton;
					if (_skin)
						radio.skin = _skin;
					if (_labelColors)
						radio.labelColors = _labelColors;
					if (_labelStroke)
						radio.labelStroke = _labelStroke;
					if (_labelSize)
						radio.labelSize = _labelSize;
					if (_labelBold)
						radio.labelBold = _labelBold;
					if (_labelMargin)
						radio.labelMargin = _labelMargin;
					if (_direction == HORIZENTAL) {
						radio.y = 0;
						radio.x = left;
						left += radio.width + _space;
					} else {
						radio.x = 0;
						radio.y = left;
						left += radio.height + _space;
					}
				}
			}
		}
		
		/**被选择单选按钮的值*/
		public function get selectedValue():Object {
			return _selectedIndex > -1 && _selectedIndex < _items.length ? RadioButton(_items[_selectedIndex]).value : null;
		}
		
		public function set selectedValue(value:Object):void {
			if (_items) {
				for (var i:int = 0, n:int = _items.length; i < n; i++) {
					var item:RadioButton = _items[i] as RadioButton;
					if (item.value == value) {
						selectedIndex = i;
						break;
					}
				}
			}
		}
	}
}