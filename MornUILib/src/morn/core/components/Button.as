/**
 * Morn UI Version 2.1.0623 http://code.google.com/p/morn https://github.com/yungzhu/morn
 * Feedback yungzhu@gmail.com http://weibo.com/newyung
 */
package morn.core.components {
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import morn.core.handlers.Handler;
	import morn.core.utils.ObjectUtils;
	import morn.core.utils.StringUtils;
	
	/**选择改变后触发*/
	[Event(name="select",type="flash.events.Event")]
	
	/**按钮类*/
	public class Button extends Component implements ISelect {
		protected static var stateMap:Object = {"rollOver": 1, "rollOut": 0, "mouseDown": 2, "mouseUp": 1, "selected": 2, "disable":3};
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
		protected var _letterSpacing:uint = 0;
		protected var _useDisableClip:Boolean = false;
		protected var _useDisableGray:Boolean = true;
		
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
				sendEvent(Event.SELECT);
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
		
		/**皮肤*/
		public function get skin():String {
			return _skin;
		}
		
		public function set skin(value:String):void {
			if (_skin != value) {
				_skin = value;
				if(_useDisableClip == false){
					_bitmap.clips = App.asset.getClips(_skin, 1, 3);
				}else{
					_bitmap.clips = App.asset.getClips(_skin, 1, 4);
				}
				if (_autoSize) {
					_contentWidth = _bitmap.width;
					_contentHeight = _bitmap.height;
				}
				callLater(changeLabelSize);
			}
		}
		
		protected function changeLabelSize():void {
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
			_bitmap.index = _state;
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
				super.disabled = value;
				if(_useDisableClip == false){
					state = _selected ? stateMap["selected"] : stateMap["rollOut"];
				}else{
					state = stateMap["disable"];
				}
				if(_useDisableGray){
					ObjectUtils.gray(this, _disabled);
				}else{
					ObjectUtils.gray(this, false);
				}
			}
		}
		
		/**按钮标签颜色(格式:upColor,overColor,downColor,disableColor)*/
		public function get labelColors():String {
			return _labelColors as String;
		}
		
		public function set labelColors(value:String):void {
			_labelColors = StringUtils.fillArray(_labelColors, value);
			callLater(changeState);
		}
		
		/**按钮标签边距(格式:左边距,上边距,右边距,下边距)*/
		public function get labelMargin():String {
			return _labelMargin as String;
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
		
		/**九宫格信息(格式:左边距,上边距,右边距,下边距)*/
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
		
		public function get letterSpacing():Object 
		{
			return btnLabel.letterSpacing;
		}
		
		public function set letterSpacing(value:Object):void 
		{
			btnLabel.letterSpacing = value;
		}

		/**
		 * 是否使用失效帧
		 */
		public function get useDisableClip():Boolean
		{
			return _useDisableClip;
		}

		public function set useDisableClip(value:Boolean):void
		{
			if(_useDisableClip != value)
			{
				_useDisableClip = value;
				if(_useDisableClip == false){
					state = _selected ? stateMap["selected"] : stateMap["rollOut"];
				}else{
					state = stateMap["disable"];
				}
				callLater(changeState);
				//重新切图
				if(_useDisableClip == false){
					_bitmap.clips = App.asset.getClips(_skin, 1, 3);
				}else{
					_bitmap.clips = App.asset.getClips(_skin, 1, 4);
				}
				if (_autoSize) {
					_contentWidth = _bitmap.width;
					_contentHeight = _bitmap.height;
				}
				callLater(changeLabelSize);
			}
			
		}

		/**
		 * 是否使用失效变灰
		 */
		public function get useDisableGray():Boolean
		{
			return _useDisableGray;
		}

		public function set useDisableGray(value:Boolean):void
		{
			if(_useDisableGray != value){
				_useDisableGray = value;
				ObjectUtils.gray(this, _disabled);
			}
		}
	}
}