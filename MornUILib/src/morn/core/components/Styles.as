/**
 * Morn UI Version 3.0 http://www.mornui.com/
 * Feedback yungvip@163.com weixin:yungzhu
 */
package morn.core.components {
	
	/**组件默认样式*/
	public class Styles {
		
		/**默认九宫格信息[左边距,上边距,右边距,下边距,是否重复填充]*/
		public static var defaultSizeGrid:Array = [4, 4, 4, 4, 0];
		
		//-----------------文本-----------------
		/**字体名称*/
		public static var fontName:String = "Arial";
		/**字体大小*/
		public static var fontSize:int = 12;
		/**是否是嵌入字体*/
		public static var embedFonts:Boolean = false;
		
		//-----------------Label-----------------
		/**标签颜色*/
		public static var labelColor:uint = 0x000000;
		/**标签描边[color,alpha,blurX,blurY,strength,quality]*/
		public static var labelStroke:Array = [0x170702, 0.8, 2, 2, 10, 1];
		/**按钮标签边缘[左距离,上距离,又距离,下距离]*/
		public static var labelMargin:Array = [0, 0, 0, 0];
		
		//-----------------Button-----------------
		/**按钮皮肤的状态数，支持1,2,3三种状态值*/
		public static var buttonStateNum:int = 3;
		/**按钮标签颜色[upColor,overColor,downColor,disableColor]*/
		public static var buttonLabelColors:Array = [0x32556b, 0x32556b, 0x32556b, 0xC0C0C0];
		/**按钮标签边缘[左距离,上距离,又距离,下距离]*/
		public static var buttonLabelMargin:Array = [0, 0, 0, 0];
		
		//-----------------LinkButton-----------------
		/**连接标签颜色[upColor,overColor,downColor,disableColor]*/
		public static var linkLabelColors:Array = [0x0080C0, 0xFF8000, 0x800000, 0xC0C0C0];
		
		//-----------------ComboBox-----------------
		/**下拉框项颜色[overBgColor,overLabelColor,outLabelColor,borderColor,bgColor]*/
		public static var comboBoxItemColors:Array = [0x5e95b6, 0xffffff, 0x000000, 0x8fa4b1, 0xffffff];
		/**单元格大小*/
		public static var comboBoxItemHeight:int = 22;
		
		//-----------------ScrollBar-----------------
		/**滚动条最小值*/
		public static var scrollBarMinNum:int = 15;
		/**长按按钮，等待时间，使其可激活连续滚动*/
		public static var scrollBarDelayTime:int = 500;
		
		//-----------------DefaultToolTip-----------------
		/**默认鼠标提示文本颜色*/
		public static var tipTextColor:uint = 0x000000;
		/**默认鼠标提示边框颜色*/
		public static var tipBorderColor:uint = 0xC0C0C0;
		/**默认鼠标提示背景颜色*/
		public static var tipBgColor:uint = 0xFFFFFF;
		
		/**默认图片是否平滑处理*/
		public static var smoothing:Boolean = false;
	}
}