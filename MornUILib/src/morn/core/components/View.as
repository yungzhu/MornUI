/**
 * Morn UI Version 3.2 http://www.mornui.com/
 * Feedback yungvip@163.com weixin:yungzhu
 */
package morn.core.components {
	import morn.editor.core.IRender;
	
	/**视图*/
	public class View extends Box {
		/**存储UI配置数据(用于加载模式)*/
		public static var uiMap:Object = {};
		protected static var uiClassMap:Object = {"Box": Box, "Button": Button, "CheckBox": CheckBox, "Clip": Clip, "ComboBox": ComboBox, "Component": Component, "Container": Container, "FrameClip": FrameClip, "HScrollBar": HScrollBar, "HSlider": HSlider, "Image": Image, "Label": Label, "LinkButton": LinkButton, "List": List, "Panel": Panel, "ProgressBar": ProgressBar, "RadioButton": RadioButton, "RadioGroup": RadioGroup, "ScrollBar": ScrollBar, "Slider": Slider, "Tab": Tab, "TextArea": TextArea, "TextInput": TextInput, "View": View, "ViewStack": ViewStack, "VScrollBar": VScrollBar, "VSlider": VSlider, "HBox": HBox, "VBox": VBox, "Tree": Tree};
		protected static var viewClassMap:Object = {};
		
		protected function createView(uiView:Object):void {
			createComp(uiView, this, this);
		}
		
		/**加载UI(用于加载模式)*/
		protected function loadUI(path:String):void {
			var uiView:Object = uiMap[path];
			if (uiView) {
				createView(uiView);
			}
		}
		
		/** 根据UI数据实例组件
		 * @param	uiView UI数据
		 * @param	comp 组件本体，如果为空，会新创建一个
		 * @param	view 组件所在的视图实例，用来注册var全局变量，为空则不注册*/
		public static function createComp(uiView:Object, comp:Component = null, view:View = null):Component {
			if (uiView is XML) {
				return createCompByXML(uiView as XML, comp, view);
			} else {
				return createCompByJSON(uiView, comp, view);
			}			
		}
		
		protected static function createCompByJSON(json:Object, comp:Component = null, view:View = null):Component {
			comp = comp || getCompInstanceByJSON(json);
			comp.comJSON = json;
			var child:Array = json.child;
			if (child) {
				for each (var note:Object in child) {
					if (comp is IRender && note.props.name == "render") {
						IRender(comp).itemRender = note;
					} else {
						comp.addChild(createCompByJSON(note, null, view));
					}
				}
			}
			
			var props:Object = json.props;
			for (var prop:String in props) {
				var value:String = props[prop];
				setCompValue(comp, prop, value, view);
			}
			
			if (comp is IItem) {
				IItem(comp).initItems();
			}
			return comp;
		}
		
		protected static function createCompByXML(xml:XML, comp:Component = null, view:View = null):Component {
			comp = comp || getCompInstanceByXML(xml);
			comp.comXml = xml;
			var list:XMLList = xml.children();
			//[IF-SCRIPT]for (var i:int = 0, m:int = list.lengths(); i < m; i++) {			
			/*[IF-FLASH]*/for (var i:int = 0, m:int = list.length(); i < m; i++) {
				var node:XML = list[i];
				if (comp is IRender && node.@name == "render") {
					IRender(comp).itemRender = node;
				} else {
					comp.addChild(createComp(node, null, view));
				}
			}
			var list2:XMLList = xml.attributes();
			for each (var attrs:XML in list2) {
				var prop:String = attrs.name().toString();
				var value:String = attrs.toString();
				setCompValue(comp, prop, value, view);
			}
			if (comp is IItem) {
				IItem(comp).initItems();
			}
			return comp;
		}
		
		private static function setCompValue(comp:Component, prop:String, value:String, view:View = null):void {
			if (comp.hasOwnProperty(prop)) {
				/*[IF-SCRIPT-BEGIN]
				   if (prop=="width" || prop=="height" || comp[prop] is Number) {
				   comp[prop]=Number(value);
				   }else
				 [IF-SCRIPT-END]*/
				comp[prop] = (value == "true" ? true : (value == "false" ? false : value))
			} else if (prop == "var" && view && view.hasOwnProperty(value)) {
				view[value] = comp;
			}
		}
		
		/**获得组件实例*/
		protected static function getCompInstanceByJSON(json:Object):Component {
			var runtime:String = json.props ? json.props.runtime : "";
			var compClass:Class = Boolean(runtime) ? viewClassMap[runtime] : uiClassMap[json.type];
			return compClass ? new compClass() : null;
		}
		
		/**获得组件实例*/
		protected static function getCompInstanceByXML(xml:XML):Component {
			var runtime:String = xml.@runtime;
			var compClass:Class = Boolean(runtime) ? viewClassMap[runtime] : uiClassMap[xml.name()];
			return compClass ? new compClass() : null;
		}
		
		/**重新创建组件(通过修改组件的数据，实现动态更改UI视图)
		 * @param comp 需要重新生成的组件 comp为null时，重新创建整个视图*/
		public function reCreate(comp:Component = null):void {
			comp = comp || this;
			var dataSource:Object = comp.dataSource;
			if (comp is Box) {
				Box(comp).removeAllChild();
			}
			createComp(comp.comJSON || comp.comXml, comp, this);
			comp.dataSource = dataSource;
		}
		
		/**注册组件(用于扩展组件及修改组件对应关系)*/
		public static function registerComponent(key:String, compClass:Class):void {
			uiClassMap[key] = compClass;
		}
		
		/**注册runtime解析*/
		public static function registerViewRuntime(key:String, compClass:Class):void {
			viewClassMap[key] = compClass;
		}
	}
}