/**
 * Morn UI Version 3.0 http://www.mornui.com/
 * Feedback yungzhu@gmail.com http://weibo.com/newyung
 */
package morn.core.components {
	
	/**水平滚动条*/
	public class HSlider extends Slider {
		
		public function HSlider(skin:String = null) {
			super(skin);
		}
		
		override protected function preinitialize():void {
			super.preinitialize();
			direction = HORIZONTAL;
		}
	}
}