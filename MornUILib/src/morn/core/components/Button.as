/**
 * Morn UI Version 1.1.0303 http://code.google.com/p/morn https://github.com/yungzhu/morn
 * Feedback yungzhu@gmail.com http://weibo.com/newyung
 */
package morn.core.components {
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.events.MouseEvent;
	import morn.core.handlers.Handler;
	import morn.core.utils.BitmapUtils;
	import morn.core.utils.ObjectUtils;
	import morn.core.utils.StringUtils;
	
	/**按钮类*/
	public class Button extends Component implements ISelect {
		protected var _bitmap:Bitmap;
		protected var _clips:Vector.<BitmapData>;
		protected var _btnLabel:Label;
		protected var _clickHandler:Handler;
		protected var _labelColors:Array = Styles.buttonLabelColors;
		protected var _labelMargin:Array = Styles.buttonLabelMargin;
		protected var _stateMap:Object = {"rollOver": 1, "rollOut": 0, "mouseDown": 2, "mouseUp": 1, "selected": 2};
		protected var _state:int;
		protected var _toggle:Boolean;
		protected var _selected:Boolean;
		protected var _skin:String;
		protected var _sizeGrid:Array = [4, 4, 4, 4];
		protected var _autoSize:Boolean = true;
		
		public function Button(skin:String = null, label:String = "") {
			this.skin = skin;
			this.label = label;
		}
		
		override protected function createChildren():void {
			addChild(_bitmap = new Bitmap());
			addChild(_btnLabel = new Label());
		}
		
		override protected function initialize():void {
			_btnLabel.align = "center";
			addEventListener(MouseEvent.ROLL_OVER, onMouse);
			addEventListener(MouseEvent.ROLL_OUT, onMouse);
			addEventListener(MouseEvent.MOUSE_DOWN, onMouse);
			addEventListener(MouseEvent.MOUSE_UP, onMouse);
			addEventListener(MouseEvent.CLICK, onMouse);
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
				state = _stateMap[e.type];
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
				_clips = App.asset.getClips(_skin, 1, 3);
				if (_autoSize && _clips) {
					_contentWidth = _clips[0].width;
					_contentHeight = _clips[0].height;
				}
				callLater(changeState);
				callLater(changeLabelSize);
			}
		}
		
		protected function changeClips():void {
			if (StringUtils.isNotEmpty(_skin)) {
				var source:Vector.<BitmapData> = App.asset.getClips(_skin, 1, 3);
				if (_autoSize && source) {
					var temp:Vector.<BitmapData> = new Vector.<BitmapData>();
					for (var i:int = 0, n:int = source.length; i < n; i++) {
						//清理临时位图数据
						if (_clips[i] != source[i]) {
							_clips[i].dispose();
						}
						temp.push(BitmapUtils.scale9Bmd(source[i], _sizeGrid, width, height));
					}
					_clips = temp;
				}
			}
		}
		
		protected function changeLabelSize():void {
			_btnLabel.width = width - _labelMargin[0] - _labelMargin[2];
			_btnLabel.height = ObjectUtils.getTextField(_btnLabel.format).height;
			_btnLabel.x = _labelMargin[0];
			_btnLabel.y = (height - _btnLabel.height) * 0.5 + _labelMargin[1] - _labelMargin[3];
		}
		
		/**是否选择*/
		public function get selected():Boolean {
			return _selected;
		}
		
		public function set selected(value:Boolean):void {
			if (_selected != value) {
				_selected = value;
				state = _selected ? _stateMap["selected"] : _stateMap["rollOut"];
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
			exeCallLater(changeClips);
			if (_clips) {
				_bitmap.bitmapData = _clips[_state];
			}
			_btnLabel.color = _labelColors[_state];
		}
		
		/**是否切换状态*/
		public function get toggle():Boolean {
			return _toggle;
		}
		
		public function set toggle(value:Boolean):void {
			_toggle = value;
		}
		
		override public function set disabled(value:Boolean):void {
			if (_disabled != value) {
				super.disabled = value;
				state = _stateMap["rollOut"];
				ObjectUtils.gray(this, _disabled);
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
			return _sizeGrid.join(",");
		}
		
		public function set sizeGrid(value:String):void {
			_sizeGrid = StringUtils.fillArray([4, 4, 4, 4], value);
			callLater(changeClips);
			callLater(changeState);
		}
		
		override public function get width():Number {
			if (_autoSize == false) {
				_btnLabel.validate();
				validate();
			}
			if (StringUtils.isNotEmpty(_skin) || StringUtils.isNotEmpty(label)) {
				return super.width;
			}
			return 0;
		}
		
		override public function set width(value:Number):void {
			super.width = value;
			callLater(changeClips);
			callLater(changeState);
			callLater(changeLabelSize);
		}
		
		override public function get height():Number {
			if (_autoSize == false) {
				_btnLabel.validate();
				validate();
			}
			if (StringUtils.isNotEmpty(_skin) || StringUtils.isNotEmpty(label)) {
				return super.height;
			}
			return 0;
		}
		
		override public function set height(value:Number):void {
			super.height = value;
			callLater(changeClips);
			callLater(changeState);
			callLater(changeLabelSize);
		}
		
		override public function set dataSource(value:Object):void {
			if (value is String) {
				label = value as String;
			} else {
				super.dataSource = value;
			}
		}
	}
}