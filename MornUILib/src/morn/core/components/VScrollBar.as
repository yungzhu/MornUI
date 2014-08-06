/**
 * Morn UI Version 3.0 http://www.mornui.com/
 * Feedback yungzhu@gmail.com http://weibo.com/newyung
 */
package morn.core.components {
	
	/**垂直滚动条*/
	public class VScrollBar extends ScrollBar {
		
		public function VScrollBar(skin:String = null) {
			super(skin);
		}
		
		override protected function initialize():void {
			super.initialize();
			_slider.direction = VERTICAL;
		}
	}
}