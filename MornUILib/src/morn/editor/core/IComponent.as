/**
 * Morn UI Version 3.2 http://www.mornui.com/
 * Feedback yungvip@163.com weixin:yungzhu
 */
package morn.editor.core {
	
	/**组件接口，实现了编辑器组件类型*/
	public interface IComponent {
		function get comXml():XML;
		function set comXml(value:XML):void;
	}
}