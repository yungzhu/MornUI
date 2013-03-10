/**
 * Morn UI Version 1.2.0310 http://code.google.com/p/morn https://github.com/yungzhu/morn
 * Feedback yungzhu@gmail.com http://weibo.com/newyung
 */
package morn.core.components {
	import morn.core.events.UIEvent;
	
	/**视图创建完成后触发*/
	[Event(name="viewCreated",type="morn.core.events.UIEvent")]
	
	/**视图*/
	public class View extends Box {
		/**加载模式使用，存储uixml*/
		public static var xmlMap:Object = {};
		protected static var uiClassMap:Object = {"Box": Box, "Button": Button, "CheckBox": CheckBox, "Clip": Clip, "ComboBox": ComboBox, "Component": Component, "Container": Container, "FrameClip": FrameClip, "HScrollBar": HScrollBar, "HSlider": HSlider, "Image": Image, "Label": Label, "LinkButton": LinkButton, "List": List, "Panel": Panel, "ProgressBar": ProgressBar, "RadioButton": RadioButton, "RadioGroup": RadioGroup, "ScrollBar": ScrollBar, "Slider": Slider, "Tab": Tab, "TextArea": TextArea, "TextInput": TextInput, "View": View, "ViewStack": ViewStack, "VScrollBar": VScrollBar, "VSlider": VSlider};
		protected var viewClassMap:Object = {};
		
		protected function createView(xml:XML):void {
			createComps(xml);
		}
		
		protected function getCompsInstance(name:String):Component {
			var compClass:Class = viewClassMap[name] || uiClassMap[name];
			if (compClass != null) {
				return new compClass();
			}
			return null;
		}
		
		protected function createComps(xml:XML, root:Boolean = true):Component {
			var type:String = xml.name();
			var comp:Component = root ? this : getCompsInstance(type);
			for each (var attrs:XML in xml.attributes()) {
				var prop:String = attrs.name().toString();
				var value:String = attrs;
				if (comp.hasOwnProperty(prop)) {
					comp[prop] = (value == "true" ? true : (value == "false" ? false : value))
				} else if (prop == "var" && hasOwnProperty(value)) {
					this[value] = comp;
				}
			}
			if (type != "List") {
				for (var j:int = 0, n:int = xml.children().length(); j < n; j++) {
					var child:Component = createComps(xml.children()[j], false);
					if (child) {
						comp.addChild(child);
					}
				}
			} else { //list ItemRender特殊处理				
				for (var i:int = 0, m:int = xml.children().length(); i < m; i++) {
					var render:XML = xml.children()[i];
					if (render.@name == "render") {
						var row:int = int(xml.@repeatX);
						var column:int = int(xml.@repeatY);
						var spaceX:int = int(xml.@spaceX);
						var spaceY:int = int(xml.@spaceY);
						for (var k:int = 0; k < column; k++) {
							for (var l:int = 0; l < row; l++) {
								var item:Component = createComps(render, false);
								item.name = "item" + (l + k * row);
								item.x += l * (spaceX + item.width);
								item.y += k * (spaceY + item.height);
								comp.addChild(item);
							}
						}
					} else {
						comp.addChild(createComps(xml.children()[i], false));
					}
				}
			}
			if (comp is IItem) {
				IItem(comp).initItems();
			}
			return comp;
		}
		
		/**加载UI*/
		protected function loadUI(path:String):void {
			var xml:XML = xmlMap[path];
			if (xml) {
				createView(xml);
			}
		}
	}
}