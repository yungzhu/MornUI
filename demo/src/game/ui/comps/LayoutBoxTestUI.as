/**Created by the Morn,do not modify.*/
package game.ui.comps {
	import morn.core.components.*;
	public class LayoutBoxTestUI extends Dialog {
		public var vbox1:VBox = null;
		public var vbox3:VBox = null;
		public var hbox1:HBox = null;
		public var vbox2:VBox = null;
		public var hbox2:HBox = null;
		public var hbox3:HBox = null;
		protected static var uiXML:XML =
			<Dialog space="10">
			  <Image url="png.comp.bg" x="0" y="0" sizeGrid="4,30,4,4" width="600" height="580"/>
			  <Button skin="png.comp.btn_close" x="560" y="3" name="close"/>
			  <Image url="png.comp.blank" x="0" y="0" width="550" height="26" name="drag"/>
			  <VBox x="46" y="385" align="left" space="20" var="vbox1">
			    <Button label="label1" skin="png.comp.button" width="141" height="55"/>
			    <Button label="label2" skin="png.comp.button" y="72" width="87" height="29" x="89"/>
			    <Button label="label3" skin="png.comp.button" x="33" y="93" width="101" height="48"/>
			  </VBox>
			  <VBox x="423" y="385" align="right" space="20" var="vbox3">
			    <Button label="label1" skin="png.comp.button" x="0" y="0" width="141" height="55"/>
			    <Button label="label2" skin="png.comp.button" x="0" y="55" width="87" height="29"/>
			    <Button label="label3" skin="png.comp.button" x="0" y="84" width="101" height="48"/>
			  </VBox>
			  <HBox x="45" y="71" align="top" space="20" var="hbox1">
			    <Button label="label1" skin="png.comp.button" y="35"/>
			    <Button label="label3" skin="png.comp.button" y="26" x="226" width="98" height="60"/>
			    <Button label="label2" skin="png.comp.button" x="66" width="115" height="36"/>
			    <Button label="label4" skin="png.comp.button" y="31" x="354" width="147" height="53"/>
			  </HBox>
			  <VBox x="236" y="385" align="center" space="20" var="vbox2">
			    <Button label="label1" skin="png.comp.button" x="0" y="0" width="141" height="55"/>
			    <Button label="label2" skin="png.comp.button" x="0" y="55" width="87" height="29"/>
			    <Button label="label3" skin="png.comp.button" x="0" y="84" width="101" height="48"/>
			  </VBox>
			  <Label text="HBox" x="46" y="44"/>
			  <Label text="VBox" x="46" y="359"/>
			  <HBox x="45" y="165" align="middle" space="20" var="hbox2">
			    <Button label="label1" skin="png.comp.button" y="35"/>
			    <Button label="label3" skin="png.comp.button" y="26" x="226" width="98" height="60"/>
			    <Button label="label2" skin="png.comp.button" x="66" width="115" height="36"/>
			    <Button label="label4" skin="png.comp.button" y="31" x="354" width="147" height="53"/>
			  </HBox>
			  <HBox x="45" y="258" align="bottom" space="20" var="hbox3">
			    <Button label="label1" skin="png.comp.button" y="35"/>
			    <Button label="label3" skin="png.comp.button" y="26" x="226" width="98" height="60"/>
			    <Button label="label2" skin="png.comp.button" x="66" width="115" height="36"/>
			    <Button label="label4" skin="png.comp.button" y="31" x="354" width="147" height="53"/>
			  </HBox>
			</Dialog>;
		public function LayoutBoxTestUI(){}
		override protected function createChildren():void {
			super.createChildren();
			createView(uiXML);
		}
	}
}