/**
 * Morn UI Version 2.2.0707 http://code.google.com/p/morn https://github.com/yungzhu/morn
 * Feedback yungzhu@gmail.com http://weibo.com/newyung
 */
package morn.core.components {
	import morn.editor.core.IList;
	
	/**视图*/
	public class View extends Container {
		/**加载模式使用，存储uixml*/
		public static var xmlMap:Object = {};
		protected static var uiClassMap:Object = {"Box": Box, "Button": Button, "CheckBox": CheckBox, "Clip": Clip, "ComboBox": ComboBox, "Component": Component, "Container": Container, "FrameClip": FrameClip, "HScrollBar": HScrollBar, "HSlider": HSlider, "Image": Image, "Label": Label, "LinkButton": LinkButton, "List": List, "Panel": Panel, "ProgressBar": ProgressBar, "RadioButton": RadioButton, "RadioGroup": RadioGroup, "ScrollBar": ScrollBar, "Slider": Slider, "Tab": Tab, "TextArea": TextArea, "TextInput": TextInput, "View": View, "ViewStack": ViewStack, "VScrollBar": VScrollBar, "VSlider": VSlider, "Paging": Paging};
		protected var viewClassMap:Object = {};
		
		protected function createView(xml:XML):void {
			createComps(xml);
		}
		
		protected function createComps(xml:XML, root:Boolean = true):Component {
			var type:String = xml.name();
			var comp:Component = root ? this : getCompsInstance(type);
			comp.comXml = xml;
			for (var i:int = 0, m:int = xml.children().length(); i < m; i++) {
				var node:XML = xml.children()[i];
				if (comp is IList && node.@name == "render") {
					var row:int = int(xml.@repeatX);
					var column:int = int(xml.@repeatY);
					var spaceX:int = int(xml.@spaceX);
					var spaceY:int = int(xml.@spaceY);
					for (var k:int = 0; k < column; k++) {
						for (var l:int = 0; l < row; l++) {
							var item:Component = createComps(node, false);
							item.name = "item" + (l + k * row);
							item.x += l * (spaceX + item.width);
							item.y += k * (spaceY + item.height);
							comp.addChild(item);
						}
					}
				} else {
					comp.addChild(createComps(node, false));
				}
			}
			for each (var attrs:XML in xml.attributes()) {
				var prop:String = attrs.name().toString();
				var value:String = attrs;
				if (comp.hasOwnProperty(prop)) {
					comp[prop] = (value == "true" ? true : (value == "false" ? false : value))
				} else if (prop == "var" && hasOwnProperty(value)) {
					this[value] = comp;
				}
			}
			if (comp is IItem) {
				IItem(comp).initItems();
			}
			//comp.showBorder();
			return comp;
		}
		
		protected function getCompsInstance(name:String):Component {
			var compClass:Class = viewClassMap[name] || uiClassMap[name];
			if (compClass != null) {
				return new compClass();
			}
			return null;
		}
		
		/**加载UI(用于加载模式)*/
		protected function loadUI(path:String):void {
			var xml:XML = xmlMap[path];
			if (xml) {
				createView(xml);
			}
		}
		
		/**重新创建组件(通过修改组件的xml，实现动态更改UI视图)
		 * @param comp 需要重新生成的组件 comp为null时，重新创建整个视图*/
		public function reCreate(comp:Component = null):void {
			var dataSource:Object = comp.dataSource;
			if (comp == null || comp == this) {
				removeAllChild();
				createComps(comXml);
				this.dataSource = dataSource;
			} else if (contains(comp)) {
				var newComp:Component = createComps(comp.comXml, false);
				newComp.dataSource = dataSource;
				comp.parent.addChildAt(newComp, comp.parent.getChildIndex(comp));
				comp.remove();
			}
		}
		
		/**注册组件(用于扩展组件及修改组件对应关系)*/
		public static function registerComponent(key:String, compClass:Class):void {
			uiClassMap[key] = compClass;
		}
	}
}