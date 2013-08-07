/**
 * Project:		MornUILib 
 * Author:		醉人的烟圈(齐小伟)
 * QQ:			7379076
 * MSN:			gamefriends@hotmail.com
 * GTalk:		gamefriends.net@gmail.com 
 * Email:		gamefriends@qq.com
 * Created:		2013-7-22 
 */
package morn.core.components
{
	/**
	 * 复合组件接口
	 * 利用现有的组件加XML描述,生成一个新的带有功能的复合组件
	 * @author qixiaowei
	 * 
	 */
	public interface ICompositeComponent
	{
		/**
		 * 复合组件的描述
		 */
		function get compositeXML():XML;
		function set compositeXML(value:*):void;
	}
}