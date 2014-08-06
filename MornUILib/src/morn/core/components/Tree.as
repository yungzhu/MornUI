/**
 * Morn UI Version 3.0 http://www.mornui.com/
 * Feedback yungzhu@gmail.com http://weibo.com/newyung
 */
package morn.core.components {
	import flash.events.Event;
	import flash.events.MouseEvent;
	import morn.core.components.Box;
	import morn.core.components.Clip;
	import morn.core.components.List;
	import morn.core.handlers.Handler;
	import morn.editor.core.IRender;
	
	/**selectedIndex属性变化时调度*/
	[Event(name="change",type="flash.events.Event")]
	
	/**树*/
	public class Tree extends Box implements IRender {
		protected var _list:List;
		protected var _source:Array;
		protected var _xml:XML;
		protected var _renderHandler:Handler;
		protected var _spaceLeft:Number = 10;
		protected var _spaceBottom:Number = 0;
		protected var _keepOpenStatus:Boolean = true;
		
		public function Tree() {
			width = height = 200;
		}
		
		override protected function createChildren():void {
			addChild(_list = new List());
			_list.renderHandler = new Handler(renderItem);
			_list.addEventListener(Event.CHANGE, onListChange);
		}
		
		private function onListChange(e:Event):void {
			sendEvent(Event.CHANGE);
		}
		
		/**组件数据源发生变化后，是否保持之前打开状态，默认为true*/
		public function get keepOpenStatus():Boolean {
			return _keepOpenStatus;
		}
		
		public function set keepOpenStatus(value:Boolean):void {
			_keepOpenStatus = value;
		}
		
		/**列表数据源，只包含当前可视节点数据*/
		public function get array():Array {
			return _list.array;
		}
		
		public function set array(value:Array):void {
			if (_keepOpenStatus && _list.array && value) {
				parseOpenStatus(_list.array, value);
			}
			_source = value;
			_list.array = getArray();
		}
		
		/**数据源，全部节点数据*/
		public function get source():Array {
			return _source;
		}
		
		/**list控件*/
		public function get list():List {
			return _list;
		}
		
		/**单元格渲染器，可以设置为XML或类对象*/
		public function get itemRender():* {
			return _list.itemRender;
		}
		
		public function set itemRender(value:*):void {
			_list.itemRender = value;
		}
		
		/**滚动条皮肤*/
		public function get scrollBarSkin():String {
			return _list.vScrollBarSkin;
		}
		
		public function set scrollBarSkin(value:String):void {
			_list.vScrollBarSkin = value;
		}
		
		/**单元格鼠标事件处理器(默认返回参数e:MouseEvent,index:int)*/
		public function get mouseHandler():Handler {
			return _list.mouseHandler;
		}
		
		public function set mouseHandler(value:Handler):void {
			_list.mouseHandler = value;
		}
		
		/**Tree渲染处理器*/
		public function get renderHandler():Handler {
			return _renderHandler;
		}
		
		public function set renderHandler(value:Handler):void {
			_renderHandler = value;
		}
		
		/**左侧缩进距离*/
		public function get spaceLeft():Number {
			return _spaceLeft;
		}
		
		public function set spaceLeft(value:Number):void {
			_spaceLeft = value;
		}
		
		/**项间隔距离*/
		public function get spaceBottom():Number {
			return _list.spaceY;
		}
		
		public function set spaceBottom(value:Number):void {
			_list.spaceY = value;
		}
		
		/**选择索引*/
		public function get selectedIndex():int {
			return _list.selectedIndex;
		}
		
		public function set selectedIndex(value:int):void {
			_list.selectedIndex = value;
		}
		
		/**选中单元格数据源*/
		public function get selectedItem():Object {
			return _list.selectedItem;
		}
		
		public function set selectedItem(value:Object):void {
			_list.selectedItem = value;
		}
		
		override public function set width(value:Number):void {
			super.width = value;
			_list.width = value;
		}
		
		override public function set height(value:Number):void {
			super.height = value;
			_list.height = value;
		}
		
		protected function getArray():Array {
			var arr:Array = [];
			for each (var item:Object in _source) {
				if (getParentOpenStatus(item)) {
					item.x = _spaceLeft * getDepth(item);
					arr.push(item);
				}
			}
			return arr;
		}
		
		protected function getDepth(item:Object, num:int = 0):int {
			if (item.nodeParent == null) {
				return num;
			} else {
				return getDepth(item.nodeParent, num + 1);
			}
		}
		
		protected function getParentOpenStatus(item:Object):Boolean {
			var parent:Object = item.nodeParent;
			if (parent == null) {
				return true;
			} else {
				if (parent.isOpen) {
					if (parent.nodeParent != null) {
						return getParentOpenStatus(parent);
					} else {
						return true;
					}
				} else {
					return false;
				}
			}
		}
		
		private function renderItem(cell:Box, index:int):void {
			var item:Object = cell.dataSource;
			if (item) {
				cell.left = item.x;
				var arrow:Clip = cell.getChildByName("arrow") as Clip;
				if (arrow) {
					if (item.hasChild) {
						arrow.visible = true;
						arrow.frame = item.isOpen ? 1 : 0;
						arrow.tag = index;
						arrow.addEventListener(MouseEvent.CLICK, onArrowClick);
					} else {
						arrow.visible = false;
					}
				}
				var folder:Clip = cell.getChildByName("folder") as Clip;
				if (folder) {
					if (folder.clipY == 2) {
						folder.frame = item.isDirectory ? 0 : 1;
					} else {
						folder.frame = item.isDirectory ? item.isOpen ? 1 : 0 : 2;
					}
				}
				if (_renderHandler != null) {
					_renderHandler.executeWith([cell, index]);
				}
			}
		}
		
		private function onArrowClick(e:MouseEvent):void {
			var arrow:Clip = e.currentTarget as Clip;
			var index:int = int(arrow.tag);
			_list.array[index].isOpen = !_list.array[index].isOpen;
			_list.array = getArray();
		}
		
		override public function set dataSource(value:Object):void {
			_dataSource = value;
			if (value is XML) {
				xml = value as XML;
			} else {
				super.dataSource = value;
			}
		}
		
		/**xml结构的数据源*/
		public function get xml():XML {
			return _xml;
		}
		
		public function set xml(value:XML):void {
			_xml = value;
			var arr:Array = [];
			parseXml(xml, arr, null, true);
			
			array = arr;
		}
		
		protected function parseXml(xml:XML, source:Array, nodeParent:Object, isRoot:Boolean):void {
			var obj:Object;
			var childCount:int = xml.children().length();
			if (!isRoot) {
				obj = {};
				for each (var attrs:XML in xml.attributes()) {
					var prop:String = attrs.name().toString();
					var value:String = attrs;
					obj[prop] = value == "true" ? true : value == "false" ? false : value;
				}
				obj.nodeParent = nodeParent;
				if (childCount > 0) {
					obj.isDirectory = true;
				}
				obj.hasChild = childCount > 0;
				source.push(obj);
			}
			for (var i:int = 0; i < childCount; i++) {
				var node:XML = xml.children()[i];
				parseXml(node, source, obj, false);
			}
		}
		
		protected function parseOpenStatus(oldSource:Array, newSource:Array):void {
			for (var i:int = 0, n:int = newSource.length; i < n; i++) {
				var newItem:Object = newSource[i];
				if (newItem.isDirectory) {
					for (var j:int = 0, m:int = oldSource.length; j < m; j++) {
						var oldItem:Object = oldSource[j];
						if (oldItem.isDirectory && isSameParent(oldItem, newItem) && newItem.label == oldItem.label) {
							newItem.isOpen = oldItem.isOpen;
							break;
						}
					}
				}
			}
		}
		
		protected function isSameParent(item1:Object, item2:Object):Boolean {
			if (item1.nodeParent == null && item2.nodeParent == null) {
				return true;
			} else if (item1.nodeParent == null || item2.nodeParent == null) {
				return false
			} else {
				if (item1.nodeParent.label == item2.nodeParent.label) {
					return isSameParent(item1.nodeParent, item2.nodeParent);
				} else {
					return false;
				}
			}
		}
	}
}