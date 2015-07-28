/**Created by the Morn,do not modify.*/
package game.ui.comps {
	import morn.core.components.*;
	import game.ui.comps.ListItemRenderUI;
	public class ListTestUI extends Dialog {
		public var pageList:List = null;
		public var boxList:List = null;
		public var autoList:List = null;
		public var vlist:List = null;
		public var hlist:List = null;
		public var checkList:List = null;
		public var prePage:Button = null;
		public var nextPage:Button = null;
		public var renderList:List = null;
		protected static var uiXML:XML =
			<Dialog space="10">
			  <Image url="png.comp.bg" x="0" y="0" sizeGrid="4,30,4,4" width="600" height="600"/>
			  <Button skin="png.comp.btn_close" x="560" y="3" name="close"/>
			  <Image url="png.comp.blank" x="0" y="0" width="550" height="26" name="drag"/>
			  <List x="45" y="79" repeatX="1" repeatY="5" spaceX="4" spaceY="4" var="pageList">
			    <ListItemRender name="render" runtime="game.ui.comps.ListItemRenderUI"/>
			    <VScrollBar skin="png.comp.vscroll" x="115" y="0" height="155" name="scrollBar"/>
			  </List>
			  <List x="226" y="79" repeatX="1" repeatY="5" spaceX="4" spaceY="4" var="boxList">
			    <VScrollBar skin="png.comp.vscroll" x="115" height="155" name="scrollBar"/>
			    <Box name="render">
			      <Clip url="png.comp.clip_selectBox" x="26" y="3" clipY="2" width="84" name="selectBox"/>
			      <Clip url="png.comp.clip_num" clipX="10" name="icon"/>
			      <Label text="label" x="31" y="3" width="80" name="label"/>
			    </Box>
			  </List>
			  <List x="398" y="79" repeatX="1" repeatY="3" var="autoList">
			    <Box name="item0" y="0">
			      <Label text="label" x="31" y="3" width="80" name="label"/>
			      <Clip url="png.comp.clip_num" clipX="10" name="icon"/>
			    </Box>
			    <Box name="item1" x="30" y="40">
			      <Label text="label" x="31" y="3" width="80" name="label"/>
			      <Clip url="png.comp.clip_num" clipX="10" name="icon"/>
			    </Box>
			    <Box name="item2" x="0" y="80">
			      <Label text="label" x="31" y="3" width="80" name="label"/>
			      <Clip url="png.comp.clip_num" clipX="10" name="icon"/>
			    </Box>
			  </List>
			  <Label text="页面嵌套作为render" x="48" y="51" width="125" height="18"/>
			  <Label text="Box为render" x="228" y="51" width="125" height="18"/>
			  <Label text="自定义位置" x="399" y="51" width="125" height="18"/>
			  <List x="45" y="275" repeatX="3" repeatY="5" spaceX="4" spaceY="4" var="vlist">
			    <VScrollBar skin="png.comp.vscroll" x="350" height="155" y="3" name="scrollBar"/>
			    <Box name="render">
			      <Label text="label" x="31" y="3" width="80" name="label"/>
			      <Clip url="png.comp.clip_num" clipX="10" name="icon"/>
			    </Box>
			  </List>
			  <Label text="多行多列list" x="48" y="250" width="125" height="18"/>
			  <List x="45" y="496" repeatX="3" repeatY="2" spaceX="4" spaceY="4" var="hlist">
			    <Box name="render">
			      <Label text="label" x="31" y="3" width="80" name="label"/>
			      <Clip url="png.comp.clip_num" clipX="10" name="icon"/>
			    </Box>
			    <HScrollBar skin="png.comp.hscroll" x="3" y="60" width="345" name="scrollBar"/>
			  </List>
			  <Label text="横向滚动list" x="48" y="461" width="125" height="18"/>
			  <List x="483" y="275" repeatX="1" repeatY="6" spaceX="4" spaceY="4" var="checkList">
			    <VScrollBar skin="png.comp.vscroll" x="76" height="156" name="scrollBar"/>
			    <Box name="render" y="1" height="22">
			      <CheckBox skin="png.comp.checkbox" y="3" x="0" name="check"/>
			      <Label text="label" x="22" y="0" width="43" height="18" name="label"/>
			    </Box>
			  </List>
			  <Button label="上一页" skin="png.comp.button" x="402" y="204" width="50" var="prePage"/>
			  <Button label="下一页" skin="png.comp.button" x="462" y="204" width="50" var="nextPage"/>
			  <Label text="带选择框的list" x="480" y="250" width="89" height="18"/>
			  <List x="439" y="480" repeatX="1" repeatY="3" spaceX="4" spaceY="4" var="renderList">
			    <VScrollBar skin="png.comp.vscroll" x="102" height="93" name="scrollBar" y="0"/>
			    <Box name="render">
			      <Clip url="png.comp.clip_num" clipX="10" name="icon"/>
			      <Label text="label" x="31" y="3" width="70" name="label" height="18"/>
			    </Box>
			  </List>
			  <Label text="自定义渲染逻辑" x="443" y="458" width="125" height="18"/>
			</Dialog>;
		public function ListTestUI(){}
		override protected function createChildren():void {
			viewClassMap["game.ui.comps.ListItemRenderUI"] = ListItemRenderUI;
			super.createChildren();
			createView(uiXML);
		}
	}
}