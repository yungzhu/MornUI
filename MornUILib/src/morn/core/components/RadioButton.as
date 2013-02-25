/**
 * Morn UI Version 1.1.0224 http://code.google.com/p/morn https://github.com/yungzhu/morn
 * Feedback yungzhu@gmail.com http://weibo.com/newyung
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
			exeCallLater(changeState);
			_btnLabel.x = _bitmap.width + _labelMargin[0];
			_btnLabel.y = (_bitmap.height - _btnLabel.height) * 0.5 + _labelMargin[1];
		}
		
		protected function onClick(e:Event):void {
			selected = true;
		}
		
		/**组件关联的可选用户定义值*/
		public function get value():Object {
			return _value != null ? _value : name;
		}
		
		public function set value(obj:Object):void {
			_value = obj;
		}
	}
}