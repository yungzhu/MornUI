/**
 * Morn UI Version 2.0.0526 http://www.mornui.com/
 * Feedback yungzhu@gmail.com http://weibo.com/newyung
 */
package morn.editor.core {
	/**动画接口，实现了编辑器动画类型*/
	public interface IClip{
		function get autoPlay():Boolean;
		function set autoPlay(value:Boolean):void;
	}
}