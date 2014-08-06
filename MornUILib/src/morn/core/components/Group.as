/**
 * Morn UI Version 3.0 http://www.mornui.com/
 * Feedback yungzhu@gmail.com http://weibo.com/newyung
 */
package morn.core.components {
	import flash.display.DisplayObject;
	import flash.events.Event;
	import morn.core.handlers.Handler;
	
	/**selectedIndex属性变化时调度*/
	[Event(name="change",type="flash.events.Event")]
	
	/**集合，Tab和RadioGroup的基类*/
	public class Group extends Box implements IItem {
		protected var _items:Vector.<ISelect>;
		protected var _selectHandler:Handler;
		protected var _selectedIndex:int = -1;
		protected var _skin:String;
		protected var _labels:String;
		protected var _labelColors:String;
		protected var _labelStroke:String;
		protected var _labelSize:Object;
		protected var _labelBold:Object;
		protected var _labelMargin:String;
		protected var _direction:String;
		protected var _space:Number = 0;
		
		public function Group(labels:String = null, skin:String = null) {
			this.skin = skin;
			this.labels = labels;
		}
		
		/**增加项，返回索引id
		 * @param autoLayOut 是否自动布局，如果为true，会根据direction和space属性计算item的位置*/
		public function addItem(item:ISelect, autoLayOut:Boolean = true):int {
			var display:DisplayObject = item as DisplayObject;
			var index:int = _items.length;
			display.name = "item" + index;
			addChild(display);
			initItems();
			
			if (autoLayOut && index > 0) {
				var preItem:DisplayObject = _items[index - 1] as DisplayObject;
				if (_direction == "horizontal") {
					display.x = preItem.x + preItem.width + _space;
				} else {
					display.y = preItem.y + preItem.height + _space;
				}
			}
			return index;
		}
		
		/**删除项
		 * @param autoLayOut 是否自动布局，如果为true，会根据direction和space属性计算item的位置*/
		public function delItem(item:ISelect, autoLayOut:Boolean = true):void {
			var index:int = _items.indexOf(item);
			if (index != -1) {
				var display:DisplayObject = item as DisplayObject;
				removeChild(display);
				for (var i:int = index + 1, n:int = _items.length; i < n; i++) {
					var child:DisplayObject = _items[i] as DisplayObject;
					child.name = "item" + (i - 1);
					if (autoLayOut) {
						if (_direction == "horizontal") {
							child.x -= display.width + _space;
						} else {
							child.y -= display.height + _space;
						}
					}
				}
				initItems();
				if (_selectedIndex > -1) {
					selectedIndex = _selectedIndex < _items.length ? _selectedIndex : (_selectedIndex - 1);
				}
			}
		}
		
		/**初始化*/
		public function initItems():void {
			_items = new Vector.<ISelect>();
			for (var i:int = 0; i < int.MAX_VALUE; i++) {
				var item:ISelect = getChildByName("item" + i) as ISelect;
				if (item == null) {
					break;
				}
				_items.push(item);
				item.selected = (i == _selectedIndex);
				item.clickHandler = new Handler(itemClick, [i]);
			}
		}
		
		protected function itemClick(index:int):void {
			selectedIndex = index;
		}
		
		/**所选按钮的索引，默认为-1*/
		public function get selectedIndex():int {
			return _selectedIndex;
		}
		
		public function set selectedIndex(value:int):void {
			if (_selectedIndex != value) {
				setSelect(_selectedIndex, false);
				_selectedIndex = value;
				setSelect(_selectedIndex, true);
				sendEvent(Event.CHANGE);
				//兼容老版本
				sendEvent(Event.SELECT);
				if (_selectHandler != null) {
					_selectHandler.executeWith([_selectedIndex]);
				}
			}
		}
		
		protected function setSelect(index:int, selected:Boolean):void {
			if (_items && index > -1 && index < _items.length) {
				_items[index].selected = selected;
			}
		}
		
		/**选择被改变时执行的处理器(默认返回参数index:int)*/
		public function get selectHandler():Handler {
			return _selectHandler;
		}
		
		public function set selectHandler(value:Handler):void {
			_selectHandler = value;
		}
		
		/**皮肤*/
		public function get skin():String {
			return _skin;
		}
		
		public function set skin(value:String):void {
			if (_skin != value) {
				_skin = value;
				callLater(changeLabels);
			}
		}
		
		/**标签集合*/
		public function get labels():String {
			return _labels;
		}
		
		public function set labels(value:String):void {
			if (_labels != value) {
				_labels = value;
				removeAllChild();
				callLater(changeLabels);
				if (Boolean(_labels)) {
					var a:Array = _labels.split(",");
					for (var i:int = 0, n:int = a.length; i < n; i++) {
						var item:DisplayObject = createItem(_skin, a[i]);
						item.name = "item" + i;
						addChild(item);
					}
				}
				initItems();
			}
		}
		
		protected function createItem(skin:String, label:String):DisplayObject {
			return null;
		}
		
		/**按钮标签颜色(格式:upColor,overColor,downColor,disableColor)*/
		public function get labelColors():String {
			return _labelColors;
		}
		
		public function set labelColors(value:String):void {
			if (_labelColors != value) {
				_labelColors = value;
				callLater(changeLabels);
			}
		}
		
		/**按钮标签描边(格式:color,alpha,blurX,blurY,strength,quality)*/
		public function get labelStroke():String {
			return _labelStroke;
		}
		
		public function set labelStroke(value:String):void {
			if (_labelStroke != value) {
				_labelStroke = value;
				callLater(changeLabels);
			}
		}
		
		/**按钮标签大小*/
		public function get labelSize():Object {
			return _labelSize;
		}
		
		public function set labelSize(value:Object):void {
			if (_labelSize != value) {
				_labelSize = value;
				callLater(changeLabels);
			}
		}
		
		/**按钮标签粗细*/
		public function get labelBold():Object {
			return _labelBold;
		}
		
		public function set labelBold(value:Object):void {
			if (_labelBold != value) {
				_labelBold = value;
				callLater(changeLabels);
			}
		}
		
		/**按钮标签边距(格式:左边距,上边距,右边距,下边距)*/
		public function get labelMargin():String {
			return _labelMargin;
		}
		
		public function set labelMargin(value:String):void {
			if (_labelMargin != value) {
				_labelMargin = value;
				callLater(changeLabels);
			}
		}
		
		/**布局方向*/
		public function get direction():String {
			return _direction;
		}
		
		public function set direction(value:String):void {
			_direction = value;
			callLater(changeLabels);
		}
		
		/**间隔*/
		public function get space():Number {
			return _space;
		}
		
		public function set space(value:Number):void {
			_space = value;
			callLater(changeLabels);
		}
		
		protected function changeLabels():void {
		}
		
		override public function commitMeasure():void {
			exeCallLater(changeLabels);
		}
		
		/**按钮集合*/
		public function get items():Vector.<ISelect> {
			return _items;
		}
		
		/**选择项*/
		public function get selection():ISelect {
			return _selectedIndex > -1 && _selectedIndex < _items.length ? _items[_selectedIndex] : null;
		}
		
		public function set selection(value:ISelect):void {
			selectedIndex = _items.indexOf(value);
		}
		
		override public function set dataSource(value:Object):void {
			_dataSource = value;
			if (value is int || value is String) {
				selectedIndex = int(value);
			} else if (value is Array) {
				labels = (value as Array).join(",");
			} else {
				super.dataSource = value;
			}
		}
	}
}