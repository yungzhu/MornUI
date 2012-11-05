/**
 * Version 0.9.0 https://github.com/yungzhu/morn
 * Feedback yungzhu@gmail.com http://weibo.com/newyung
 * Copyright 2012, yungzhu. All rights reserved.
 * This program is free software. You can redistribute and/or modify it
 * in accordance with the terms of the accompanying license agreement.
 */
package morn.core.components {
	
	/**视图*/
	public class View extends Box {
		private static var uiClassMap:Object = {"Box": Box, "Button": Button, "CheckBox": CheckBox, "Clip": Clip, "Component": Component, "Container": Container, "FrameClip": FrameClip, "HScrollBar": HScrollBar, "HSlider": HSlider, "Image": Image, "Label": Label, "LinkButton": LinkButton, "List": List, "ProgressBar": ProgressBar, "RadioButton": RadioButton, "RadioGroup": RadioGroup, "ScrollBar": ScrollBar, "Slider": Slider, "Tab": Tab, "TextArea": TextArea, "TextInput": TextInput, "View": View, "ViewStack": ViewStack, "VScrollBar": VScrollBar, "VSlider": VSlider};
		protected var viewClassMap:Object = {};
		
		protected function createView(xml:XML):void {
			createComps(xml);
			sendEvent(UIEvent.VIEW_CREATED);
		}
		
		private function getCompsInstance(name:String):Component {
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
			if (comp is IItems) {
				IItems(comp).initItems();
			}
			return comp;
		}
	}
}