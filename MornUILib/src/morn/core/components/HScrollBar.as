/**
 * Morn UI Version 3.0 http://www.mornui.com/
 * Feedback yungzhu@gmail.com http://weibo.com/newyung
 */
package morn.core.components {
	
	/**水平滚动条*/
	public class HScrollBar extends ScrollBar {
		
		public function HScrollBar(skin:String = null) {
			super(skin);
		}
		
		override protected function initialize():void {
			super.initialize();
			_slider.direction = HORIZONTAL;
		}
	}
}