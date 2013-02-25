/**
 * Morn UI Version 1.1.0224 http://code.google.com/p/morn https://github.com/yungzhu/morn
 * Feedback yungzhu@gmail.com http://weibo.com/newyung
 */
package morn.core.components {
	
	/**组件默认样式*/
	public class Styles {
		//-----------------文本-----------------
		/**字体名称*/
		public static var fontName:String = "Arial";
		/**字体大小*/
		public static var fontSize:int = 12;
		
		//-----------------Label-----------------
		/**标签颜色*/
		public static var labelColor:uint = 0x000000;
		/**标签描边[color,alpha,blurX,blurY,strength,quality]*/
		public static var labelStroke:Array = [0x170702, 0.8, 2, 2, 10, 1];
		
		//-----------------Button-----------------
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
	}
}