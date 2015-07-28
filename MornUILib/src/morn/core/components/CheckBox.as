/**
 * Morn UI Version 3.0 http://www.mornui.com/
 * Feedback yungvip@163.com weixin:yungzhu
 */
package morn.core.components {
	import flash.events.Event;
	
	/**多选按钮*/
	public class CheckBox extends Button {
		
		public function CheckBox(skin:String = null, label:String = "") {
			super(skin, label);
		}
		
		override protected function preinitialize():void {
			super.preinitialize();
			_toggle = true;
			_autoSize = false;
		}
		
		override protected function initialize():void {
			super.initialize();
			_btnLabel.autoSize = "left";
		}
		
		override protected function changeLabelSize():void {
			exeCallLater(changeClips);
			_btnLabel.x = _bitmap.width + _labelMargin[0];
			_btnLabel.y = (_bitmap.height - _btnLabel.height) * 0.5 + _labelMargin[1];
		}
		
		override public function commitMeasure():void {
			exeCallLater(changeLabelSize);
		}
		
		override public function set dataSource(value:Object):void {
			_dataSource = value;
			if (value is Boolean) {
				selected = value;
			} else if (value is String) {
				selected = value == "true";
			} else {
				super.dataSource = value;
			}
		}
	}
}