/**
 * Morn UI Version 3.0 http://www.mornui.com/
 * Feedback yungvip@163.com weixin:yungzhu
 */
package morn.core.components {
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	/**单选框按钮*/
	public class RadioButton extends Button {
		protected var _value:Object;
		
		public function RadioButton(skin:String = null, label:String = "") {
			super(skin, label);
		}
		
		/**销毁*/
		override public function dispose():void {
			super.dispose();
			_value = null;
		}
		
		override protected function preinitialize():void {
			super.preinitialize();
			_toggle = false;
			_autoSize = false;
		}
		
		override protected function initialize():void {
			super.initialize();
			_btnLabel.autoSize = "left";
			addEventListener(MouseEvent.CLICK, onClick);
		}
		
		override protected function changeLabelSize():void {
			exeCallLater(changeClips);
			_btnLabel.x = _bitmap.width + _labelMargin[0];
			_btnLabel.y = (_bitmap.height - _btnLabel.height) * 0.5 + _labelMargin[1];
		}
		
		override public function commitMeasure():void {
			exeCallLater(changeLabelSize);
		}
		
		protected function onClick(e:Event):void {
			selected = true;
		}
		
		/**组件关联的可选用户定义值*/
		public function get value():Object {
			return _value != null ? _value : label;
		}
		
		public function set value(obj:Object):void {
			_value = obj;
		}
	}
}