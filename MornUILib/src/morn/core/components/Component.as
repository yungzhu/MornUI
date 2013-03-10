/**
 * Morn UI Version 1.2.0309 http://code.google.com/p/morn https://github.com/yungzhu/morn
 * Feedback yungzhu@gmail.com http://weibo.com/newyung
 */
package morn.core.components {
	import flash.display.DisplayObject;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.utils.Dictionary;
	import morn.core.events.UIEvent;
	import morn.editor.core.IComponent;
	
	/**渲染后触发*/
	[Event(name="renderCompleted",type="morn.core.events.UIEvent")]
	/**重置大小后触发*/
	[Event(name="resize",type="flash.events.Event")]
	
	/**组件基类*/
	public class Component extends Sprite implements IComponent {
		protected var _methods:Dictionary = new Dictionary();
		protected var _x:Number = 0;
		protected var _y:Number = 0;
		protected var _width:Number;
		protected var _height:Number;
		protected var _contentWidth:Number = 0;
		protected var _contentHeight:Number = 0;
		protected var _disabled:Boolean;
		protected var _tag:Object;
		protected var _comXml:XML;
		protected var _dataSource:Object;
		protected var _toolTip:Object;
		protected var _mouseChildren:Boolean;
		
		public function Component() {
			mouseChildren = tabEnabled = tabChildren = false;
			preinitialize();
			createChildren();
			initialize();
		}
		
		/**预初始化，这里可以修改属性默认值*/
		protected function preinitialize():void {
		
		}
		
		/**创建组件对象*/
		protected function createChildren():void {
		
		}
		
		/**初始化，此处子对象已被创建，可以针对子对象进行修改*/
		protected function initialize():void {
		
		}
		
		protected function invalidate():void {
			addEventListener(Event.RENDER, onValidate);
			//render有一定几率无法触发，这里加上保险处理
			addEventListener(Event.ENTER_FRAME, onValidate);
			if (App.stage) {
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
			for (var method:Object in _methods) {
				exeCallLater(method as Function);
			}
		}
		
		protected function exeCallLater(method:Function):void {
			if (_methods[method] != null) {
				var args:Array = _methods[method];
				delete _methods[method];
				method.apply(null, args);
			}
		}
		
		/**立即渲染组件*/
		public function validate():void {
			for (var obj:Object in _methods) {
				onValidate(null);
				break;
			}
		}
		
		/**延迟调用*/
		public function callLater(mothod:Function, args:Array = null):void {
			if (_methods[mothod] == null) {
				_methods[mothod] = args || [];
				invalidate();
			}
		}
		
		/**派发事件*/
		public function sendEvent(type:String, data:* = null):void {
			if (hasEventListener(type)) {
				dispatchEvent(new UIEvent(type, data));
			}
		}
		
		/**从父容器删除自己*/
		public function remove():void {
			if (parent) {
				parent.removeChild(this);
			}
		}
		
		/**根据名字删除子对象*/
		public function removeChildByName(name:String):void {
			var display:DisplayObject = getChildByName(name);
			if (display) {
				removeChild(display);
			}
		}
		
		/**x坐标(显示时四舍五入)*/
		override public function get x():Number {
			return _x;
		}
		
		override public function set x(value:Number):void {
			_x = value;
			super.x = Math.round(value);
		}
		
		/**y坐标(显示时四舍五入)*/
		override public function get y():Number {
			return _y;
		}
		
		override public function set y(value:Number):void {
			_y = value;
			super.y = Math.round(value);
		}
		
		/**设置组件位置*/
		public function setPosition(x:Number, y:Number):void {
			this.x = x;
			this.y = y;
		}
		
		/**宽度(值为0时，宽度为自适应)*/
		override public function get width():Number {
			if (!isNaN(_width)) {
				return _width;
			} else if (_contentWidth != 0) {
				return _contentWidth;
			} else {
				validate();
				return super.width;
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
			if (!isNaN(_height)) {
				return _height;
			} else if (_contentHeight != 0) {
				return _contentHeight;
			} else {
				validate();
				return super.height;
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
		
		/**真实X坐标*/
		public function get realX():Number {
			return super.x;
		}
		
		/**真实Y坐标*/
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
				mouseEnabled = !value;
				super.mouseChildren = value ? false : _mouseChildren;
			}
		}
		
		override public function set mouseChildren(value:Boolean):void {
			_mouseChildren = super.mouseChildren = value;
		}
		
		/**标签(冗余字段，可以用来储存数据)*/
		public function get tag():Object {
			return _tag;
		}
		
		public function set tag(value:Object):void {
			_tag = value;
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
		
		/**仅在编辑器模式下才使用，可忽略，可用来存储别的内容*/
		public function get comXml():XML {
			return _comXml;
		}
		
		public function set comXml(value:XML):void {
			_comXml = value;
		}
		
		/**数据源*/
		public function get dataSource():Object {
			return _dataSource;
		}
		
		public function set dataSource(value:Object):void {
			_dataSource = value;
			for (var prop:String in _dataSource) {
				if (hasOwnProperty(prop)) {
					this[prop] = _dataSource[prop];
				}
			}
		}
		
		/**鼠标提示*/
		public function get toolTip():Object {
			return _toolTip;
		}
		
		public function set toolTip(value:Object):void {
			if (_toolTip != value) {
				_toolTip = value;
				addEventListener(MouseEvent.ROLL_OVER, onRollMouse);
				addEventListener(MouseEvent.ROLL_OUT, onRollMouse);
			}
		}
		
		protected function onRollMouse(e:MouseEvent):void {
			dispatchEvent(new UIEvent(e.type == MouseEvent.ROLL_OVER ? UIEvent.SHOW_TIP : UIEvent.HIDE_TIP, _toolTip, true));
		}
	}
}