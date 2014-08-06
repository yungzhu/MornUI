/**
 * Morn UI Version 3.0 http://www.mornui.com/
 * Feedback yungzhu@gmail.com http://weibo.com/newyung
 */
package morn.core.components {
	
	/**垂直滑动条*/
	public class VSlider extends Slider {
		
		public function VSlider(skin:String = null) {
			super(skin);
		}
		
		override protected function preinitialize():void {
			super.preinitialize();
			direction = VERTICAL;
		}
	}
}