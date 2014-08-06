/**
 * Morn UI Version 3.0 http://www.mornui.com/
 * Feedback yungzhu@gmail.com http://weibo.com/newyung
 */
package morn.core.components {
	import flash.events.Event;
	
	/**文本按钮*/
	public class LinkButton extends Button {
		
		public function LinkButton(label:String = "") {
			super(null, label);
		}
		
		override protected function preinitialize():void {
			super.preinitialize();
			_labelColors = Styles.linkLabelColors;
			_autoSize = false;
			buttonMode = true;
		}
		
		override protected function initialize():void {
			super.initialize();
			_btnLabel.underline = true;
			_btnLabel.autoSize = "left";
		}
		
		override protected function changeLabelSize():void {
		}
	}
}