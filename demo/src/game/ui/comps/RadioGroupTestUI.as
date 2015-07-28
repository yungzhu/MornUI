/**Created by the Morn,do not modify.*/
package game.ui.comps {
	import morn.core.components.*;
	public class RadioGroupTestUI extends Dialog {
		public var radioGroup1:RadioGroup = null;
		public var radioGroup2:RadioGroup = null;
		protected static var uiXML:XML =
			<Dialog>
			  <Image url="png.comp.bg" x="0" y="0" sizeGrid="4,30,4,4" width="400" height="350"/>
			  <Button skin="png.comp.btn_close" x="365" y="3" name="close"/>
			  <Image url="png.comp.blank" x="0" y="0" width="360" height="26" name="drag"/>
			  <RadioGroup labels="label1,label2,label3" skin="png.comp.radiogroup" x="63" y="91" labelSize="16" labelColors="0xff0000,0x5eb10c,0xfe9705" var="radioGroup1"/>
			  <Label text="设置labels的单选框" x="60" y="62"/>
			  <Label text="自定义单选框，可以自定义位置，大小，颜色等等" x="59" y="179"/>
			  <RadioGroup x="60" y="212" var="radioGroup2" selectedIndex="1">
			    <RadioButton label="自定义1" skin="png.comp.radio" name="item0"/>
			    <RadioButton label="自定义2" skin="png.comp.radio" x="58" y="25" labelBold="true" name="item1"/>
			    <RadioButton label="自定义3" skin="png.comp.radio" x="118" labelColors="0xff0000,0x5eb10c,0xfe9705" labelSize="16" name="item2"/>
			    <RadioButton label="自定义4" skin="png.comp.radio" x="192" y="24" labelSize="16" name="item3"/>
			  </RadioGroup>
			</Dialog>;
		public function RadioGroupTestUI(){}
		override protected function createChildren():void {
			super.createChildren();
			createView(uiXML);
		}
	}
}