/**
 * Morn UI Version 3.0 http://www.mornui.com/
 * Feedback yungvip@163.com weixin:yungzhu
 */
package morn.editor.core {
	
	/**动画接口，实现了编辑器动画类型*/
	public interface IClip {
		function get autoPlay():Boolean;
		function set autoPlay(value:Boolean):void;
	}
}