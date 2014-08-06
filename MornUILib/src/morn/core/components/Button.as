/**
 * Morn UI Version 3.0 http://www.mornui.com/
 * Feedback yungzhu@gmail.com http://weibo.com/newyung
 */
package morn.core.components {
	import flash.events.Event;
	import flash.events.MouseEvent;
	import morn.core.handlers.Handler;
	import morn.core.utils.ObjectUtils;
	import morn.core.utils.StringUtils;
	
	
	/**selected属性变化时调度*/
	[Event(name="change",type="flash.events.Event")]
	
	/**按钮类，可以是单态，两态和三态，默认三态(up,over,down)*/
	public class Button extends Component implements ISelect {
		protected static var stateMap:Object = {"rollOver": 1, "rollOut": 0, "mouseDown": 2, "mouseUp": 1, "selected": 2};
		protected var _bitmap:AutoBitmap;
		protected var _btnLabel:Label;
		protected var _clickHandler:Handler;
		protected var _labelColors:Array = Styles.buttonLabelColors;
		protected var _labelMargin:Array = Styles.buttonLabelMargin;
		protected var _state:int;
		protected var _toggle:Boolean;
		protected var _selected:Boolean;
		protected var _skin:String;
		protected var _autoSize:Boolean = true;
		protected var _stateNum:int = Styles.buttonStateNum;
		
		public function Button(skin:String = null, label:String = "") {
			this.skin = skin;
			this.label = label;
		}
		
		override protected function createChildren():void {
			addChild(_bitmap = new AutoBitmap());
			addChild(_btnLabel = new Label());
		}
		
		override protected function initialize():void {
			_btnLabel.align = "center";
			addEventListener(MouseEvent.ROLL_OVER, onMouse);
			addEventListener(MouseEvent.ROLL_OUT, onMouse);
			addEventListener(MouseEvent.MOUSE_DOWN, onMouse);
			addEventListener(MouseEvent.MOUSE_UP, onMouse);
			addEventListener(MouseEvent.CLICK, onMouse);
			_bitmap.sizeGrid = Styles.defaultSizeGrid;
		}
		
		protected function onMouse(e:MouseEvent):void {
			if ((_toggle == false && _selected) || _disabled) {
				return;
			}
			if (e.type == MouseEvent.CLICK) {
				if (_toggle) {
					selected = !_selected;
				}
				if (_clickHandler) {
					_clickHandler.execute();
				}
				return;
			}
			if (_selected == false) {
				state = stateMap[e.type];
			}
		}
		
		/**按钮标签*/
		public function get label():String {
			return _btnLabel.text;
		}
		
		public function set label(value:String):void {
			if (_btnLabel.text != value) {
				_btnLabel.text = value;
				callLater(changeState);
			}
		}
		
		/**皮肤，支持单态，两态和三态，用stateNum属性设置*/
		public function get skin():String {
			return _skin;
		}
		
		public function set skin(value:String):void {
			if (_skin != value) {
				_skin = value;
				callLater(changeClips);
				callLater(changeLabelSize);
			}
		}
		
		protected function changeClips():void {
			_bitmap.clips = App.asset.getClips(_skin, 1, _stateNum);
			if (_autoSize) {
				_contentWidth = _bitmap.width;
				_contentHeight = _bitmap.height;
			}
		}
		
		override public function commitMeasure():void {
			exeCallLater(changeClips);
		}
		
		protected function changeLabelSize():void {
			exeCallLater(changeClips);
			_btnLabel.width = width - _labelMargin[0] - _labelMargin[2];
			_btnLabel.height = ObjectUtils.getTextField(_btnLabel.format).height;
			_btnLabel.x = _labelMargin[0];
			_btnLabel.y = (height - _btnLabel.height) * 0.5 + _labelMargin[1] - _labelMargin[3];
		}
		
		/**是否是选择状态*/
		public function get selected():Boolean {
			return _selected;
		}
		
		public function set selected(value:Boolean):void {
			if (_selected != value) {
				_selected = value;
				state = _selected ? stateMap["selected"] : stateMap["rollOut"];
				sendEvent(Event.CHANGE);
				//兼容老版本
				sendEvent(Event.SELECT);
			}
		}
		
		protected function get state():int {
			return _state;
		}
		
		protected function set state(value:int):void {
			_state = value;
			callLater(changeState);
		}
		
		protected function changeState():void {
			var index:int = _state;
			if (_stateNum == 2) {
				index = index < 2 ? index : 1;
			} else if (_stateNum == 1) {
				index = 0;
			}
			_bitmap.index = index;
			_btnLabel.color = _labelColors[_state];
		}
		
		/**是否是切换状态*/
		public function get toggle():Boolean {
			return _toggle;
		}
		
		public function set toggle(value:Boolean):void {
			_toggle = value;
		}
		
		override public function set disabled(value:Boolean):void {
			if (_disabled != value) {
				state = _selected ? stateMap["selected"] : stateMap["rollOut"];
				super.disabled = value;
			}
		}
		
		/**按钮标签颜色(格式:upColor,overColor,downColor,disableColor)*/
		public function get labelColors():String {
			return String(_labelColors);
		}
		
		public function set labelColors(value:String):void {
			_labelColors = StringUtils.fillArray(_labelColors, value);
			callLater(changeState);
		}
		
		/**按钮标签边距(格式:左边距,上边距,右边距,下边距)*/
		public function get labelMargin():String {
			return String(_labelMargin);
		}
		
		public function set labelMargin(value:String):void {
			_labelMargin = StringUtils.fillArray(_labelMargin, value, int);
			callLater(changeLabelSize);
		}
		
		/**按钮标签描边(格式:color,alpha,blurX,blurY,strength,quality)*/
		public function get labelStroke():String {
			return _btnLabel.stroke;
		}
		
		public function set labelStroke(value:String):void {
			_btnLabel.stroke = value;
		}
		
		/**按钮标签大小*/
		public function get labelSize():Object {
			return _btnLabel.size;
		}
		
		public function set labelSize(value:Object):void {
			_btnLabel.size = value
			callLater(changeLabelSize);
		}
		
		/**按钮标签粗细*/
		public function get labelBold():Object {
			return _btnLabel.bold;
		}
		
		public function set labelBold(value:Object):void {
			_btnLabel.bold = value
			callLater(changeLabelSize);
		}
		
		/**字间距*/
		public function get letterSpacing():Object {
			return _btnLabel.letterSpacing;
		}
		
		public function set letterSpacing(value:Object):void {
			_btnLabel.letterSpacing = value
			callLater(changeLabelSize);
		}
		
		/**按钮标签字体*/
		public function get labelFont():String {
			return _btnLabel.font;
		}
		
		public function set labelFont(value:String):void {
			_btnLabel.font = value;
			callLater(changeLabelSize);
		}
		
		/**点击处理器(无默认参数)*/
		public function get clickHandler():Handler {
			return _clickHandler;
		}
		
		public function set clickHandler(value:Handler):void {
			_clickHandler = value;
		}
		
		/**按钮标签控件*/
		public function get btnLabel():Label {
			return _btnLabel;
		}
		
		/**九宫格信息，格式：左边距,上边距,右边距,下边距,是否重复填充(值为0或1)，例如：4,4,4,4,1*/
		public function get sizeGrid():String {
			if (_bitmap.sizeGrid) {
				return _bitmap.sizeGrid.join(",");
			}
			return null;
		}
		
		public function set sizeGrid(value:String):void {
			_bitmap.sizeGrid = StringUtils.fillArray(Styles.defaultSizeGrid, value);
		}
		
		override public function set width(value:Number):void {
			super.width = value;
			if (_autoSize) {
				_bitmap.width = value;
			}
			callLater(changeLabelSize);
		}
		
		override public function set height(value:Number):void {
			super.height = value;
			if (_autoSize) {
				_bitmap.height = value;
			}
			callLater(changeLabelSize);
		}
		
		override public function set dataSource(value:Object):void {
			_dataSource = value;
			if (value is Number || value is String) {
				label = String(value);
			} else {
				super.dataSource = value;
			}
		}
		
		/**皮肤的状态数，支持单态，两态和三态按钮，分别对应1,2,3值，默认是三态*/
		public function get stateNum():int {
			return _stateNum;
		}
		
		public function set stateNum(value:int):void {
			if (_stateNum != value) {
				_stateNum = value < 1 ? 1 : value > 3 ? 3 : value;
				callLater(changeClips);
			}
		}
	}
}