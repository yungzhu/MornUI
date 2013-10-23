/**
 * Morn UI Version 2.4.1020 http://www.mornui.com/
 * Feedback yungzhu@gmail.com http://weibo.com/newyung
 */
package morn.core.components {
	import morn.core.utils.StringUtils;
	
	/**HBox容器*/
	public class HBox extends LayoutBox {
		public static const NONE:String = "none";
		public static const TOP:String = "top";
		public static const MIDDLE:String = "middle";
		public static const BOTTOM:String = "bottom";
		
		public function HBox() {
		}
		
		override protected function changeItems():void {
			var left:Number = 0;
			var maxHeight:Number = 0;
			var count:int = numChildren;
			for (var i:int = 0; i < count; i++) {
				var item:Component = getChildAt(i) as Component;
				if (item) {
					item.x = left;
					left += item.width * item.scaleX + _space;
					maxHeight = Math.max(maxHeight, item.height * item.scaleY);
				}
			}
			
			if (_align != NONE) {
				for (i = 0; i < count; i++) {
					item = getChildAt(i) as Component;
					if (item) {
						if (_align == TOP) {
							item.y = 0;
						} else if (_align == MIDDLE) {
							item.y = (maxHeight - item.height * item.scaleY) * 0.5;
						} else if (_align == BOTTOM) {
							item.y = maxHeight - item.height * item.scaleY;
						}
					}
				}
			}
			changeSize();
		}
	}
}