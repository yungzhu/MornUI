package {
	import flash.display.Sprite;
	
	public class Test extends Sprite {
		private var str:String = "<Dialog sceneWidth=\"600\" sceneHeight=\"450\" sceneColor=\"0xffffff\" layers=\"2,1,1;1,1,1\" compId=\"34\">"
			  +"<Image url=\"png.comp.bg\" x=\"0\" y=\"0\" layer=\"1\" sizeGrid=\"4,26,4,4\" width=\"530\" height=\"450\" compId=\"1\"/>"
			  +"<Image url=\"png.comp.blank\" x=\"0\" y=\"0\" layer=\"1\" height=\"26\" width=\"530\" name=\"drag\" compId=\"2\"/>"
			  +"<Button skin=\"png.comp.btn_close\" x=\"497\" y=\"4\" layer=\"1\" name=\"close\" compId=\"3\"/>"
			  +"<Button label=\"我被拉大了\" skin=\"png.comp.button\" x=\"346\" y=\"78\" layer=\"2\" width=\"150\" height=\"36\" var=\"btn2\" labelSize=\"20\" labelBold=\"true\" labelMargin=\"1,1,1,1\" compId=\"4\"/>"
			  +"<Label text=\"这里是标签\" x=\"34\" y=\"42.5\" layer=\"2\" name=\"label\" var=\"label\" compId=\"5\"/>"
			  +"<Button label=\"点我点我\" skin=\"png.comp.button\" x=\"421\" y=\"40.5\" layer=\"2\" var=\"btn1\" compId=\"6\"/>"
			  +"<ProgressBar skin=\"png.comp.progress\" x=\"248\" y=\"133\" layer=\"2\" width=\"100\" height=\"12\" sizeGrid=\"4,4,4,4\" var=\"progressBar\" compId=\"7\"/>"
			  +"<TextArea text=\"谷歌一直很重视Android系统缺乏足够的应用程序这方面的问题，公司认为新发布的Nexus平板将对这一问题的解决其促进作用。谷歌的Android产品经理雨果·巴拉（Hugo Barra）在接受科技网站the Verge的采访时表示，“公司投入大量精力推出Nexus 10平板，也是为了刺激开发者，让他们对Android应用的开发更有动力\" x=\"35\" y=\"324\" layer=\"2\" width=\"150\" height=\"100\" scrollBarSkin=\"png.comp.vscroll\" compId=\"8\"/>"
			  +"<CheckBox label=\"label\" skin=\"png.comp.checkbox\" x=\"34\" y=\"88.5\" layer=\"2\" var=\"checkbox\" name=\"checkbox\" compId=\"9\"/>"
			  +"<RadioGroup labels=\"label1,label2\" skin=\"png.comp.radiogroup\" x=\"125\" y=\"88.5\" layer=\"2\" layers=\"1,1,0\" var=\"radioGroup1\" compId=\"10\"/>"
			  +"<Tab labels=\"tab1,tab2\" skin=\"png.comp.tab\" x=\"356\" y=\"278\" layer=\"2\" var=\"tab\" layers=\"1,1,0\" compId=\"11\"/>"
			  +"<LinkButton label=\"我是LinkButton\" x=\"305\" y=\"42.5\" layer=\"2\" var=\"link\" compId=\"12\"/>"
			  +"<Clip url=\"png.comp.clip_num\" x=\"275\" y=\"82.5\" layer=\"2\" clipX=\"10\" clipY=\"1\" index=\"10\" var=\"clip\" compId=\"13\"/>"
			  +"<TextInput text=\"我是输入框\" x=\"173\" y=\"42\" layer=\"2\" width=\"100\" height=\"20\" skin=\"png.comp.textinput\" compId=\"14\"/>"
			  +"<HSlider skin=\"png.comp.hslider\" x=\"396\" y=\"135\" layer=\"2\" width=\"100\" var=\"hslider\" compId=\"15\"/>"
			  +"<List layer=\"2\" x=\"214\" y=\"274\" layers=\"1,1,0\" var=\"list\" repeatX=\"1\" repeatY=\"5\" spaceX=\"0\" spaceY=\"5\" compId=\"21\">"
			  +"  <Box layer=\"1\" x=\"0\" y=\"0\" name=\"render\" layers=\"1,1,0\" compId=\"19\">"
			  +"    <Clip url=\"png.other.clip_selectBox\" x=\"24\" y=\"4\" layer=\"1\" clipX=\"1\" clipY=\"2\" width=\"64\" height=\"20\" name=\"selectBox\" compId=\"16\"/>"
			  +"    <Label text=\"label\" x=\"27\" y=\"4\" layer=\"1\" name=\"label\" compId=\"17\"/>"
			  +"    <Clip url=\"png.comp.clip_num\" layer=\"1\" clipX=\"10\" clipY=\"1\" name=\"icon\" compId=\"18\"/>"
			  +"  </Box>"
			  +"  <VScrollBar skin=\"png.comp.vscroll\" x=\"89\" y=\"3\" layer=\"1\" width=\"15\" height=\"150\" name=\"scrollBar\" compId=\"20\"/>"
			  +"</List>"
			  +"<ViewStack layer=\"2\" x=\"364\" y=\"328\" layers=\"1,1,0\" var=\"viewStack\" compId=\"24\">"
			  +"  <Label text=\"view1\" layer=\"1\" name=\"item0\" y=\"0\" compId=\"22\"/>"
			  +"  <LinkButton label=\"view2\" x=\"47\" y=\"0\" layer=\"1\" name=\"item1\" compId=\"23\"/>"
			  +"</ViewStack>"
			  +"<FrameClip skin=\"assets.frameclip_Bear\" x=\"222\" y=\"180\" layer=\"2\" var=\"frame\" compId=\"25\"/>"
			  +"<Panel layer=\"2\" x=\"35\" y=\"182\" layers=\"1,1,0\" scrollBarSkin=\"png.comp.vscroll\" width=\"150\" height=\"100\" vScrollBarSkin=\"png.comp.vscroll\" compId=\"27\">"
			  +"  <Image url=\"png.comp.image\" layer=\"1\" compId=\"26\"/>"
			  +"</Panel>"
			  +"<ComboBox labels=\"label1,label2\" skin=\"png.comp.combobox\" x=\"346\" y=\"179\" layer=\"2\" var=\"combo\" sizeGrid=\"4,4,14,4\" compId=\"28\"/>"
			  +"<ComboBox labels=\"类可使用表示,位带符号整数的数据,这意味着无需对象,不需要使用构造函数,这意味着需要对象才能,不需要浮点数,如果您正在处理超过,无需使用构造函数\" skin=\"png.comp.combobox\" x=\"346\" y=\"228\" layer=\"2\" sizeGrid=\"4,4,14,4\" width=\"150\" height=\"23\" scrollBarSkin=\"png.comp.vscroll\" compId=\"29\"/>"
			  +"<RadioGroup layers=\"1,1,0\" layer=\"2\" x=\"34\" y=\"130.5\" var=\"radioGroup2\" compId=\"33\">"
			  +"  <RadioButton label=\"自定义\" skin=\"png.comp.radio\" layer=\"1\" name=\"item0\" compId=\"30\"/>"
			  +"  <RadioButton label=\"自定义\" skin=\"png.comp.radio\" x=\"55\" layer=\"1\" name=\"item1\" labelBold=\"true\" compId=\"31\"/>"
			  +"  <RadioButton label=\"自定义\" skin=\"png.comp.radio\" x=\"113\" layer=\"1\" name=\"item2\" labelColors=\"0xff0000\" compId=\"32\"/>"
			  +"</RadioGroup>"
			+"</Dialog>";
		public function Test() {
			var tool:LangExtractor = new LangExtractor();
			//测试查找
			trace(tool.seekLangPack(str));
		}
	}
}