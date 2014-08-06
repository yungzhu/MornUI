/**
 * Morn UI Version 3.0 http://www.mornui.com/
 * Feedback yungzhu@gmail.com http://weibo.com/newyung
 */
package morn.editor.core {
	
	/**组件接口，实现了编辑器组件类型*/
	public interface IComponent {
		function get comXml():XML;
		function set comXml(value:XML):void;
	}
}