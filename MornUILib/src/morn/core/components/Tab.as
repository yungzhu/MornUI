/**
 * Morn UI Version 3.0 http://www.mornui.com/
 * Feedback yungvip@163.com weixin:yungzhu
 */
package morn.core.components {
	import flash.display.DisplayObject;
	
	/**Tab标签，默认selectedIndex=-1*/
	public class Tab extends Group {
		/**横向的*/
		public static const HORIZENTAL:String = "horizontal";
		/**纵向的*/
		public static const VERTICAL:String = "vertical";
		
		public function Tab(labels:String = null, skin:String = null) {
			super(labels, skin);
			_direction = HORIZENTAL;
		}
		
		override protected function createItem(skin:String, label:String):DisplayObject {
			return new Button(skin, label);
		}
		
		override protected function changeLabels():void {
			if (_items) {
				var left:Number = 0
				for (var i:int = 0, n:int = _items.length; i < n; i++) {
					var btn:Button = _items[i] as Button;
					if (_skin)
						btn.skin = _skin;
					if (_labelColors)
						btn.labelColors = _labelColors;
					if (_labelStroke)
						btn.labelStroke = _labelStroke;
					if (_labelSize)
						btn.labelSize = _labelSize;
					if (_labelBold)
						btn.labelBold = _labelBold;
					if (_labelMargin)
						btn.labelMargin = _labelMargin;
					if (_direction == HORIZENTAL) {
						btn.y = 0;
						btn.x = left;
						left += btn.width + _space;
					} else {
						btn.x = 0;
						btn.y = left;
						left += btn.height + _space;
					}
				}
			}
		}
	}
}