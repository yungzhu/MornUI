/**
 * Morn UI Version 3.0 http://www.mornui.com/
 * Feedback yungvip@163.com weixin:yungzhu
 */
package morn.core.components {
	import morn.core.handlers.Handler;
	
	/**ISelect接口，实现可选择属性*/
	public interface ISelect {
		function get selected():Boolean;
		function set selected(value:Boolean):void;
		function get clickHandler():Handler;
		function set clickHandler(value:Handler):void;
	}
}