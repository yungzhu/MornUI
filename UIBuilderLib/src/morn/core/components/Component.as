/**
 * Version 0.9.0 https://github.com/yungzhu/morn
 * Feedback yungzhu@gmail.com http://weibo.com/newyung
 * Copyright 2012, yungzhu. All rights reserved.
 * This program is free software. You can redistribute and/or modify it
 * in accordance with the terms of the accompanying license agreement.
 */
package morn.core.components {
	import editor.core.IComponent;
	
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.utils.Dictionary;
	
	/**组件基类*/
	public class Component extends Sprite implements IComponent {
		protected var _methodList:Dictionary = new Dictionary();
		protected var _x:Number = 0;
		protected var _y:Number = 0;
		protected var _width:Number = 0;
		protected var _height:Number = 0;
		protected var _disabled:Boolean;
		protected var _tag:String;
		protected var _comXml:XML;
		
		public function Component() {
			mouseChildren = tabEnabled = tabChildren = false;
			preinitialize();
			createChildren();
			initialize();
		}
		
		public function get comXml():XML{
			return _comXml;
		}

		public function set comXml(value:XML):void{
			_comXml = value;
		}

		/**在此处对属性赋默认值值*/
		protected function preinitialize():void {
		
		}
		
		protected function createChildren():void {
		
		}
		
		/**在此处对属性赋默认值值*/
		protected function initialize():void {
		
		}
		
		/**派发事件*/
		public function sendEvent(type:String):void {
			if (hasEventListener(type)) {
				dispatchEvent(new Event(type));
			}
		}
		
		protected function invalidate():void {
			addEventListener(Event.RENDER, onValidate);
			//render有一定几率无法触发，这里加上保险处理
			addEventListener(Event.ENTER_FRAME, onValidate);
			if (App.stage != null) {
				App.stage.invalidate();
			}
		}
		
		protected function onValidate(e:Event):void {
			removeEventListener(Event.RENDER, onValidate);
			removeEventListener(Event.ENTER_FRAME, onValidate);
			render();
			sendEvent(UIEvent.RENDER_COMPLETED);
		}
		
		protected function render():void {
			for (var method:Object in _methodList) {
				exeCallLater(method as Function);
			}
		}
		
		protected function exeCallLater(method:Function):void {
			if (_methodList[method] != null) {
				var args:Array = _methodList[method];
				delete _methodList[method];
				method.apply(null, args);
			}
		}
		
		/**立即渲染组件*/
		public function validate():void {
			for (var obj:Object in _methodList) {
				onValidate(null);
				break;
			}
		}
		
		/**延迟调用*/
		public function callLater(mothod:Function, args:Array = null):void {
			if (_methodList[mothod] == null) {
				_methodList[mothod] = args || [];
				invalidate();
			}
		}
		
		/**x坐标(四舍五入)*/
		override public function get x():Number {
			return _x;
		}
		
		override public function set x(value:Number):void {
			if (_x != value) {
				_x = value;
				super.x = Math.round(value);
			}
		}
		
		/**y坐标(四舍五入)*/
		override public function get y():Number {
			return _y;
		}
		
		override public function set y(value:Number):void {
			if (_y != value) {
				_y = value;
				super.y = Math.round(value);
			}
		}
		
		/**设置组件位置*/
		public function setPosition(x:Number, y:Number):void {
			this.x = x;
			this.y = y;
		}
		
		/**宽度(值为0时，宽度为自适应)*/
		override public function get width():Number {
			if (_width == 0) {
				validate();
				return super.width;
			} else {
				return _width;
			}
		}
		
		override public function set width(value:Number):void {
			if (_width != value) {
				_width = value;
				callLater(changeSize);
			}
		}
		
		/**高度(值为0时，高度为自适应)*/
		override public function get height():Number {
			if (_height == 0) {
				validate();
				return super.height;
			} else {
				return _height;
			}
		}
		
		override public function set height(value:Number):void {
			if (_height != value) {
				_height = value;
				callLater(changeSize);
			}
		}
		
		protected function changeSize():void {
			sendEvent(Event.RESIZE);
		}
		
		/**设置组件大小*/
		public function setSize(width:Number, height:Number):void {
			this.width = width;
			this.height = height;
		}
		
		/**真实x坐标*/
		public function get realX():Number {
			return super.x;
		}
		
		/**真实y坐标*/
		public function get realY():Number {
			return super.y;
		}
		
		/**真实宽度*/
		public function get realWidth():Number {
			return super.width;
		}
		
		/**真实高度*/
		public function get realHeight():Number {
			return super.height;
		}
		
		/**缩放比例*/
		public function set scale(value:Number):void {
			scaleX = scaleY = value;
		}
		
		public function get scale():Number {
			return scaleX;
		}
		
		/**是否禁用*/
		public function get disabled():Boolean {
			return _disabled;
		}
		
		public function set disabled(value:Boolean):void {
			if (_disabled != value) {
				_disabled = value;
				mouseEnabled = !disabled;
			}
		}
		
		/**标签*/
		public function get tag():String {
			return _tag;
		}
		
		public function set tag(value:String):void {
			_tag = value;
		}
		
		/**从父容器删除自己*/
		public function remove():void {
			if (parent) {
				parent.removeChild(this);
			}
		}
		
		/**显示边框*/
		public function showBorder(color:uint = 0xff0000):void {
			if (getChildByName("border") == null) {
				var border:Shape = new Shape();
				border.name = "border";
				border.graphics.lineStyle(1, color);
				border.graphics.drawRect(0, 0, width, height);
				addChild(border);
			}
		}
	}
}