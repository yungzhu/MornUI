/**Created by the Morn,do not modify.*/
package game.ui {
	import morn.core.components.*;
	public class GameStageUI extends View {
		protected static var uiXML:XML =
			<View>
			  <Button label="按钮" skin="png.comp.button" x="35" y="60"/>
			  <Button label="多选框" skin="png.comp.button" x="35" y="98"/>
			  <Button label="位图切片" skin="png.comp.button" x="35" y="136"/>
			  <Button label="矢量动画" skin="png.comp.button" x="35" y="174"/>
			  <Button label="下拉框" skin="png.comp.button" x="35" y="212"/>
			  <Button label="相对定位" skin="png.comp.button" x="35" y="250"/>
			  <Button label="文本" skin="png.comp.button" x="35" y="288"/>
			  <Button label="布局容器" skin="png.comp.button" x="35" y="326"/>
			  <Button label="列表" skin="png.comp.button" x="35" y="364"/>
			  <Button label="面板" skin="png.comp.button" x="139" y="60"/>
			  <Button label="进度条" skin="png.comp.button" x="139" y="98"/>
			  <Button label="滑动条" skin="png.comp.button" x="139" y="136"/>
			  <Button label="单选框" skin="png.comp.button" x="139" y="174"/>
			  <Button label="标签" skin="png.comp.button" x="139" y="212"/>
			  <Button label="输入框" skin="png.comp.button" x="139" y="250"/>
			  <Button label="文本域" skin="png.comp.button" x="139" y="288"/>
			  <Button label="多视图" skin="png.comp.button" x="139" y="326"/>
			  <Label text="Morn UI测试Demo" x="34" y="22" size="16" color="0xff0000"/>
			  <Button label="赋值" skin="png.comp.button" x="269" y="60"/>
			  <Button label="鼠标提示" skin="png.comp.button" x="269" y="98"/>
			  <Button label="多语言" skin="png.comp.button" x="269" y="136"/>
			</View>;
		public function GameStageUI(){}
		override protected function createChildren():void {
			super.createChildren();
			createView(uiXML);
		}
	}
}