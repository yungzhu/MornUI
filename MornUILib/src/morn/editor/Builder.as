/**
 * Morn UI Version 2.0.0526 http://www.mornui.com/
 * Feedback yungzhu@gmail.com http://weibo.com/newyung
 */
package morn.editor{
	public class Builder{
		/**对UI类库进行初始化(编辑器导入UI类库后，会默认调用此方法)
		 * 这里可以针对编辑器对UI库做特殊改变
		 */
		public static function init():void {
			App.stage = Sys.stage;
			App.asset = new BuilderResManager();
		}
	}
}