/**
 * Morn UI Version 1.1.0303 http://code.google.com/p/morn https://github.com/yungzhu/morn
 * Feedback yungzhu@gmail.com http://weibo.com/newyung
 */
package morn.core.components {
	import morn.core.handlers.Handler;
	
	/**
	 * ISelect接口，实现可选择属性
	 */
	public interface ISelect {
		function get selected():Boolean;
		function set selected(value:Boolean):void
		function get clickHandler():Handler;
		function set clickHandler(value:Handler):void;
	}
}