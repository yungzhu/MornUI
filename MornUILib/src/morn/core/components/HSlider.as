/**
 * Morn UI Version 2.0.0526 http://code.google.com/p/morn https://github.com/yungzhu/morn
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