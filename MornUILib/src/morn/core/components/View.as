/**
 * Version 0.9.4.1.3 https://github.com/yungzhu/morn
 * Feedback yungzhu@gmail.com http://weibo.com/newyung
 */
package morn.core.components {
	import morn.core.handlers.Handler;
	
	/**视图创建完成后触发*/
	[Event(name="viewCreated",type="morn.core.components.UIEvent")]
	
	/**视图*/
	public class View extends Box {
		/**加载模式使用，存储uixml*/
		public static var xmlMap:Object = {};
		protected static var uiClassMap:Object = {"Box": Box, "Button": Button, "CheckBox": CheckBox, "Clip": Clip, "ComboBox": ComboBox, "Component": Component, "Container": Container, "FrameClip": FrameClip, "HScrollBar": HScrollBar, "HSlider": HSlider, "Image": Image, "Label": Label, "LinkButton": LinkButton, "List": List, "Panel": Panel, "ProgressBar": ProgressBar, "RadioButton": RadioButton, "RadioGroup": RadioGroup, "ScrollBar": ScrollBar, "Slider": Slider, "Tab": Tab, "TextArea": TextArea, "TextInput": TextInput, "View": View, "ViewStack": ViewStack, "VScrollBar": VScrollBar, "VSlider": VSlider};
		protected var viewClassMap:Object = {};
		
		protected function createView(xml:XML):void {
			createComps(xml);
			sendEvent(UIEvent.VIEW_CREATED);
		}
		
		protected function getCompsInstance(name:String):Component {
			var compClass:Class = viewClassMap[name] || uiClassMap[name];
			if (compClass != null) {
				return new compClass();
			}
			return null;
		}
		
		protected function createComps(xml:XML, root:Boolean = true):Component {
			var comp:Component = root ? this : getCompsInstance(xml.name());
			for each (var attrs:XML in xml.attributes()) {
				var prop:String = attrs.name().toString();
				var value:String = attrs;
				if (comp.hasOwnProperty(prop)) {
					comp[prop] = (value == "true" ? true : (value == "false" ? false : value))
				} else if (prop == "var" && hasOwnProperty(value)) {
					this[value] = comp;
				}
			}
			for (var j:int = 0, n:int = xml.children().length(); j < n; j++) {
				var child:Component = createComps(xml.children()[j], false);
				if (child != null) {
					comp.addChild(child);
				}
			}
			if (comp is IItem) {
				IItem(comp).initItems();
			}
			//comp.showBorder();
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