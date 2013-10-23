/**
 * Morn UI Version 2.0.0526 http://www.mornui.com/
 * Feedback yungzhu@gmail.com http://weibo.com/newyung
 */
package morn.core.components {
	import morn.core.handlers.Handler;
	
	/**ISelect接口，实现可选择属性*/
	public interface ISelect {
		function get selected():Boolean;
		function set selected(value:Boolean):void
		function get clickHandler():Handler;
		function set clickHandler(value:Handler):void;
	}
}