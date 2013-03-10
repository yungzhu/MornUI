/**
 * Morn UI Version 1.2.0309 http://code.google.com/p/morn https://github.com/yungzhu/morn
 * Feedback yungzhu@gmail.com http://weibo.com/newyung
 */
package morn.core.components {
	import flash.display.Graphics;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import morn.core.handlers.Handler;
	import morn.core.utils.StringUtils;
	
	/**选择项改变后触发*/
	[Event(name="select",type="flash.events.Event")]
	
	/**下拉框*/
	public class ComboBox extends Component {
		/**向上方向*/
		public static const UP:String = "up";
		/**向下方向*/
		public static const DOWN:String = "down";
		protected static const ITEM_HEIGHT:int = 22;
		protected var _visibleNum:int = 6;
		protected var _button:Button;
		protected var _list:List;
		protected var _isOpen:Boolean;
		protected var _scrollBar:VScrollBar;
		protected var _itemColors:Array = Styles.comboBoxItemColors;
		protected var _labels:Array = [];
		protected var _selectedIndex:int = -1;
		protected var _selectHandler:Handler;
		protected var _openDirection:String = DOWN;
		protected var _listHeight:Number;
		
		public function ComboBox(skin:String = null, labels:String = null) {
			this.skin = skin;
			this.labels = labels;
		}
		
		override protected function preinitialize():void {
			mouseChildren = true;
		}
		
		override protected function createChildren():void {
			addChild(_button = new Button());
			_list = new List();
			_scrollBar = new VScrollBar();
		}
		
		override protected function initialize():void {
			_button.btnLabel.align = "left";
			_button.labelMargin = "5";
			_button.toggle = true;
			_button.clickHandler = new Handler(buttonClick);
			
			_list.addEventListener(Event.SELECT, onListSelect);
			_scrollBar.name = "scrollBar";
			_scrollBar.addEventListener(MouseEvent.CLICK, onScrollBarClick);
		}
		
		protected function onScrollBarClick(e:MouseEvent):void {
			e.stopPropagation();
		}
		
		protected function onListSelect(e:Event):void {
			selectedIndex = _list.selectedIndex;
		}
		
		/**皮肤*/
		public function get skin():String {
			return _button.skin;
		}
		
		public function set skin(value:String):void {
			if (_button.skin != value) {
				_button.skin = value;
				_contentWidth = _button.width;
				_contentHeight = _button.height;
				callLater(changeList);
			}
		}
		
		protected function changeList():void {
			_list.removeAllChild();
			for (var i:int = 0; i < _visibleNum; i++) {
				var label:Label = new Label();
				label.name = "label";
				label.width = width - 2;
				label.height = ITEM_HEIGHT;
				
				var box:Box = new Box();
				box.name = "item" + i;
				box.addElement(label, 1, 0);
				box.addEventListener(MouseEvent.ROLL_OVER, onListItemMouse);
				box.addEventListener(MouseEvent.ROLL_OUT, onListItemMouse);
				_list.addElement(box, 0, i * ITEM_HEIGHT);
			}
			_scrollBar.x = width - _scrollBar.width - 1;
			_list.addChild(_scrollBar);
			_list.initItems();
			_list.refresh();
		}
		
		private function onListItemMouse(e:MouseEvent):void {
			var box:Box = e.currentTarget as Box;
			var label:Label = box.getChildByName("label") as Label;
			if (e.type == MouseEvent.ROLL_OVER) {
				label.background = true;
				label.backgroundColor = _itemColors[0];
				label.color = _itemColors[1];
			} else {
				label.background = false;
				label.color = _itemColors[2];
			}
		}
		
		protected function buttonClick():void {
			callLater(changeOpen);
		}
		
		protected function changeOpen():void {
			isOpen = !_isOpen;
		}
		
		override public function set width(value:Number):void {
			super.width = value;
			_button.width = _width;
			callLater(changeList);
		}
		
		override public function set height(value:Number):void {
			super.height = value;
			_button.height = _height;
		}
		
		/**标签集合*/
		public function get labels():String {
			return _labels.join(",");
		}
		
		public function set labels(value:String):void {
			if (StringUtils.isNotEmpty(value)) {
				var oldLabels:Array = _labels;
				_labels = value.split(",");
				callLater(changeItem);
				if (oldLabels) {
					selectedIndex = -1;
				}
			}
		}
		
		protected function changeItem():void {
			//赋值之前需要先初始化列表
			exeCallLater(changeList);
			var a:Array = [];
			for (var i:int = 0, n:int = _labels.length; i < n; i++) {
				a.push({label: _labels[i]});
			}
			_list.array = a;
			
			//显示边框
			_listHeight = Math.min(_visibleNum, a.length) * ITEM_HEIGHT;
			var g:Graphics = _list.graphics;
			g.clear();
			g.lineStyle(1, _itemColors[3]);
			g.beginFill(_itemColors[4]);
			g.drawRect(0, 0, width - 1, _listHeight);
			g.endFill();
			
			_scrollBar.height = _listHeight;
		}
		
		/**选择索引*/
		public function get selectedIndex():int {
			return _selectedIndex;
		}
		
		public function set selectedIndex(value:int):void {
			if (_selectedIndex != value) {
				_list.selectedIndex = _selectedIndex = value;
				_button.label = selectedLabel;
				sendEvent(Event.SELECT);
				if (_selectHandler != null) {
					_selectHandler.executeWith([_selectedIndex]);
				}
			}
		}
		
		/**选择被改变时执行的处理器(默认返回参数index:int)*/
		public function get selectHandler():Handler {
			return _selectHandler;
		}
		
		public function set selectHandler(value:Handler):void {
			_selectHandler = value;
		}
		
		/**选择标签*/
		public function get selectedLabel():String {
			return _selectedIndex > -1 && _selectedIndex < _labels.length ? _labels[_selectedIndex] : null;
		}
		
		public function set selectedLabel(value:String):void {
			selectedIndex = _labels.indexOf(value);
		}
		
		/**可见项数量*/
		public function get visibleNum():int {
			return _visibleNum;
		}
		
		public function set visibleNum(value:int):void {
			_visibleNum = value;
			callLater(changeList);
		}
		
		/**项颜色(格式:overBgColor,overLabelColor,outLableColor,borderColor,,bgColor)*/
		public function get itemColors():String {
			return _itemColors as String;
		}
		
		public function set itemColors(value:String):void {
			_itemColors = StringUtils.fillArray(_itemColors, value);
			callLater(changeList);
		}
		
		/**是否打开*/
		public function get isOpen():Boolean {
			return _isOpen;
		}
		
		public function set isOpen(value:Boolean):void {
			if (_isOpen != value) {
				_isOpen = value;
				_button.selected = _isOpen;
				if (_isOpen) {
					var p:Point = localToGlobal(new Point());
					if (_openDirection == DOWN) {
						_list.setPosition(p.x, p.y + height);
					} else {
						_list.setPosition(p.x, p.y - _listHeight);
					}
					App.stage.addChild(_list);
					App.stage.addEventListener(MouseEvent.CLICK, removeList);
					App.stage.addEventListener(Event.REMOVED_FROM_STAGE, removeList);
				} else {
					removeList(null);
				}
			}
		}
		
		protected function removeList(e:Event):void {
			_isOpen = false;
			_button.selected = false;
			_list.remove();
			App.stage.removeEventListener(MouseEvent.CLICK, removeList);
			App.stage.removeEventListener(Event.REMOVED_FROM_STAGE, removeList);
		}
		
		/**滚动条皮肤*/
		public function get scrollBarSkin():String {
			return _scrollBar.skin;
		}
		
		public function set scrollBarSkin(value:String):void {
			_scrollBar.skin = value;
		}
		
		/**九宫格信息(格式:左边距,上边距,右边距,下边距)*/
		public function get sizeGrid():String {
			return _button.sizeGrid;
		}
		
		public function set sizeGrid(value:String):void {
			_button.sizeGrid = value;
		}
		
		/**滚动条*/
		public function get scrollBar():VScrollBar {
			return _scrollBar;
		}
		
		/**按钮实体*/
		public function get button():Button {
			return _button;
		}
		
		override public function set dataSource(value:Object):void {
			if (value is int) {
				selectedIndex = value as int;
			} else {
				super.dataSource = value;
			}
		}
		
		/**打开方向*/
		public function get openDirection():String {
			return _openDirection;
		}
		
		public function set openDirection(value:String):void {
			_openDirection = value;
		}
	}
}