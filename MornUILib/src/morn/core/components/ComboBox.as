/**
 * Morn UI Version 2.4.1027 http://www.mornui.com/
 * Feedback yungzhu@gmail.com http://weibo.com/newyung
 */
package morn.core.components {
	import flash.display.DisplayObject;
	import flash.display.Graphics;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.text.TextFormat;
	
	import morn.core.handlers.Handler;
	import morn.core.utils.ObjectUtils;
	import morn.core.utils.StringUtils;
	
	/**选择项改变后触发*/
	[Event(name="select",type="flash.events.Event")]
	
	/**下拉框*/
	public class ComboBox extends Component {
		/**向上方向*/
		public static const UP:String = "up";
		/**向下方向*/
		public static const DOWN:String = "down";
		protected var _visibleNum:int = 6;
		protected var _button:Button;
		protected var _list:List;
		protected var _isOpen:Boolean;
		protected var _scrollBar:VScrollBar;
		protected var _itemColors:Array = Styles.comboBoxItemColors;
		protected var _itemSize:int = Styles.fontSize;
		protected var _labels:Array = [];
		protected var _selectedIndex:int = -1;
		protected var _selectHandler:Handler;
		protected var _openDirection:String = DOWN;
		protected var _itemHeight:Number;
		protected var _listHeight:Number;
		
		/**
		 *是否可以编辑 
		 */		
		protected var _editEnabled:Boolean = false;
		
		/**
		 *文本编辑框 
		 */		
		protected var _inputTxt:TextInput;
		
		
		
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
			_list.mouseHandler = new Handler(onlistItemMouse);
			_scrollBar = new VScrollBar();
			_list.addChild(_scrollBar);
		}
		
		override protected function initialize():void {
			_button.btnLabel.align = "left";
			_button.labelMargin = "5";
			_button.addEventListener(MouseEvent.MOUSE_DOWN, onButtonMouseDown);
			
			_list.addEventListener(Event.SELECT, onListSelect);
			_scrollBar.name = "scrollBar";
			_scrollBar.y = 1;
		}
		
		private function onButtonMouseDown(e:MouseEvent):void {
			callLater(changeOpen);
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
		
		/**
		 *是否充许编辑 
		 * @return 
		 * 
		 */		
		public function get editEnabled():Boolean{
			return this._editEnabled;
		}
		
		public function set editEnabled(value:Boolean):void{
			
			if(this._editEnabled == value)return;
			
			if(value){
				
				if(this._inputTxt == null){
					this._inputTxt = new TextInput();
					this._inputTxt.width = this.width;
					this._inputTxt.height = this.height;
					
					if(this.editTextMargin == ""){
						this.editTextMargin = "5";
					}
					
					this.addChild(this._inputTxt);
				}else{
					this._inputTxt.visible = false;
					this.addChild(this._inputTxt);
				}
				
				this._inputTxt.text = this.selectedLabel;
				this._button.label = "";
				
			}else{
				
				if(this._inputTxt){
					this._inputTxt.visible = true;
					this.removeChild(this._inputTxt);
				}
				
				this._button.label = this.selectedLabel;
			}
			
			this._editEnabled = value;
		}
		
		protected function changeList():void {
			var labelWidth:Number = width - 2;
			var labelColor:Number = _itemColors[2];
			_itemHeight = ObjectUtils.getTextField(new TextFormat(Styles.fontName, _itemSize)).height + 3;
			list.itemRender = new XML("<Box><Label name='label' width='" + labelWidth + "' size='" + _itemSize + "' height='" + _itemHeight + "' color='" + labelColor + "' x='1' /></Box>");
			list.repeatY = _visibleNum;
			_scrollBar.x = width - _scrollBar.width - 1;
			_list.refresh();
		}
		
		protected function onlistItemMouse(type:String, index:int):void {
			if (type == MouseEvent.CLICK || type == MouseEvent.ROLL_OVER || type == MouseEvent.ROLL_OUT) {
				var box:Box = list.getCell(index);
				var label:Label = box.getChildByName("label") as Label;
				if (type == MouseEvent.ROLL_OVER) {
					label.background = true;
					label.backgroundColor = _itemColors[0];
					label.color = _itemColors[1];
				} else {
					label.background = false;
					label.color = _itemColors[2];
				}
				if (type == MouseEvent.CLICK) {
					isOpen = false;
				}
			}
		}
		
		protected function changeOpen():void {
			isOpen = !_isOpen;
		}
		
		override public function set width(value:Number):void {
			super.width = value;
			_button.width = _width;
			
			if(this._editEnabled)this._inputTxt.width = _width;
			callLater(changeList);
		}
		
		override public function set height(value:Number):void {
			super.height = value;
			_button.height = _height;
			if(this._editEnabled)this._inputTxt.width = _height;
		}
		
		/**标签集合*/
		public function get labels():String {
			return _labels.join(",");
		}
		
		public function set labels(value:String):void {
			if (_labels.length > 0) {
				selectedIndex = -1;
			}
			if (Boolean(value)) {
				_labels = value.split(",");
			} else {
				_labels.length = 0;
			}
			callLater(changeItem);
		}
		
		protected function changeItem():void {
			//赋值之前需要先初始化列表
			exeCallLater(changeList);
			
			//显示边框
			_listHeight = _labels.length > 0 ? Math.min(_visibleNum, _labels.length) * _itemHeight : _itemHeight;
			_scrollBar.height = _listHeight - 2;
			//填充背景
			var g:Graphics = _list.graphics;
			g.clear();
			g.lineStyle(1, _itemColors[3]);
			g.beginFill(_itemColors[4]);
			g.drawRect(0, 0, width - 1, _listHeight);
			g.endFill();
			//填充数据			
			var a:Array = [];
			for (var i:int = 0, n:int = _labels.length; i < n; i++) {
				a.push({label: _labels[i]});
			}
			_list.array = a;
		}
		
		/**选择索引*/
		public function get selectedIndex():int {
			return _selectedIndex;
		}
		
		public function set selectedIndex(value:int):void {
			if (_selectedIndex != value) {
				_list.selectedIndex = _selectedIndex = value;
				
				if(this._editEnabled){
					this._inputTxt.text = selectedLabel;
				}else{
					_button.label = selectedLabel;
				}
				
				if (_selectHandler != null) {
					_selectHandler.executeWith([_selectedIndex]);
				}
				sendEvent(Event.SELECT);
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
		
		/**
		 *设置或获取combobox上面显示的文本
		 * 如果设置的值不在下拉列表内，那么，selectIndex就会为-1; 
		 * 与selectedLabel的区别在，selectedLabel设置值如果不在list列表内，那么文本框就会为NULL
		 * 而这个属性设置的值如果不在列表内，selectedIndex的属性会为-1,但文本框内会显示设置的值。
		 * @return 
		 * 
		 */		
		public function get text():String{
			
			if(this._editEnabled){
				return this._inputTxt.text;
			}else{
				return this._button.label;
			}
		}
		
		public function set text(value:String):void{
			
			if(value == null)value = "";
			
			if(this._editEnabled){
				if(value == this._inputTxt.text )return;
				this.selectedLabel = value;
				
				if(this._inputTxt.text == ""){
					this._inputTxt.text = value;
				}
				
			}else{
				
				if(value == this._button.label)return;
				this.selectedLabel = value;
				
				if(this._button.label == ""){
					this._button.label = value;
				}
			}
		}
		
		/**可见项数量*/
		public function get visibleNum():int {
			return _visibleNum;
		}
		
		public function set visibleNum(value:int):void {
			_visibleNum = value;
			callLater(changeList);
		}
		
		/**项颜色(格式:overBgColor,overLabelColor,outLableColor,borderColor,bgColor)*/
		public function get itemColors():String {
			return String(_itemColors);
		}
		
		public function set itemColors(value:String):void {
			_itemColors = StringUtils.fillArray(_itemColors, value);
			callLater(changeList);
		}
		
		/**项字体大小*/
		public function get itemSize():int {
			return _itemSize;
		}
		
		public function set itemSize(value:int):void {
			_itemSize = value;
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
					_list.setPosition(p.x, p.y + (_openDirection == DOWN ? height : -_listHeight));
					App.stage.addChild(_list);
					App.stage.addEventListener(MouseEvent.MOUSE_DOWN, removeList);
					App.stage.addEventListener(Event.REMOVED_FROM_STAGE, removeList);
					//处理定位
					_list.scrollTo((_selectedIndex + _visibleNum) < _list.length ? _selectedIndex : _list.length - _visibleNum);
				} else {
					_list.remove();
					App.stage.removeEventListener(MouseEvent.MOUSE_DOWN, removeList);
					App.stage.removeEventListener(Event.REMOVED_FROM_STAGE, removeList);
				}
			}
		}
		
		protected function removeList(e:Event):void {
			if (e == null || (!_button.contains(e.target as DisplayObject) && !_list.contains(e.target as DisplayObject))) {
				isOpen = false;
			}
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
		
		/**list实体*/
		public function get list():List {
			return _list;
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
		
		/**打开方向*/
		public function get openDirection():String {
			return _openDirection;
		}
		
		public function set openDirection(value:String):void {
			_openDirection = value;
		}
		
		/**标签颜色(格式:upColor,overColor,downColor,disableColor)*/
		public function get labelColors():String {
			return _button.labelColors;
		}
		
		public function set labelColors(value:String):void {
			_button.labelColors = value;
			if(this._editEnabled)this._inputTxt.color = value;
		}
		
		/**按钮标签边距(格式:左边距,上边距,右边距,下边距)*/
		public function get labelMargin():String {
			return _button.labelMargin;
		}
		
		public function set labelMargin(value:String):void {
			_button.labelMargin = value;
		}
		
		/**
		 *编辑框，跟上下左右的间距 
		 * @return 
		 * 
		 */		
		public function get editTextMargin():String{
			return this._inputTxt.margin;
		}
		
		public function set editTextMargin(value:String):void{
			this._inputTxt.margin = value;
		}
		
		/**按钮标签描边(格式:color,alpha,blurX,blurY,strength,quality)*/
		public function get labelStroke():String {
			return _button.labelStroke;
		}
		
		public function set labelStroke(value:String):void {
			_button.labelStroke = value;
			if(this._editEnabled)this._inputTxt.stroke = value;
		}
		
		/**按钮标签大小*/
		public function get labelSize():Object {
			return _button.labelSize;
		}
		
		public function set labelSize(value:Object):void {
			_button.labelSize = value;
			if(this._editEnabled)this._inputTxt;
		}
		
		/**按钮标签粗细*/
		public function get labelBold():Object {
			return _button.labelBold;
		}
		
		public function set labelBold(value:Object):void {
			_button.labelBold = value
			if(this._editEnabled)this._inputTxt.bold = value;
		}
	}
}