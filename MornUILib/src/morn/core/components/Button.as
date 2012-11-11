/**
 * Version 0.9.2 https://github.com/yungzhu/morn
 * Feedback yungzhu@gmail.com http://weibo.com/newyung
 * Copyright 2012, yungzhu. All rights reserved.
 * This program is free software. You can redistribute and/or modify it
 * in accordance with the terms of the accompanying license agreement.
 */
package morn.core.components {
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.events.MouseEvent;
	import morn.core.handlers.Handler;
	import morn.core.utils.ObjectUtils;
	import morn.core.utils.StringUtils;
	
	/**按钮类*/
	public class Button extends Component implements ISelectable {
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
		protected var _skinW:int = 1;
		protected var _skinH:int = 3;
		
		public function Button(skin:String = null, label:String = "") {
			this.skin = skin;
			this.label = label;
			this.labelStroke = "0x170702";
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
		
		override protected function render():void {
			exeCallLater(changeState);
			super.render();
		}
		
		private function onMouse(e:MouseEvent):void {
			if ((_toggle == false && _selected) || _disabled) {
				return;
			}
			if (e.type == MouseEvent.CLICK) {
				if (_clickHandler) {
					_clickHandler.execute();
				}
				if (_toggle) {
					selected = !_selected;
					state = 1;
				}
				return;
			}
			state = _stateMap[e.type];
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
				var bmd:BitmapData = App.asset.getBitmapData(_skin);
				if (bmd != null) {
					_clips = App.asset.getClips(_skin, _skinW, _skinH);
					callLater(changeState);
					callLater(changeLabelSize);
				}
			}
		}
		
		protected function changeLabelSize():void {
			_btnLabel.validate();
			_btnLabel.x = _labelMargin[0];
			_btnLabel.width = _bitmap.width - _labelMargin[0] - _labelMargin[2];
			_btnLabel.autoSize = "left";
			_btnLabel.height = _btnLabel.textField.height;
			_btnLabel.autoSize = "none";
			_btnLabel.y = (_bitmap.height - _btnLabel.height) / 2 + _labelMargin[1];
		}
		
		/**是否选择*/
		public function get selected():Boolean {
			return _selected;
		}
		
		public function set selected(value:Boolean):void {
			if (_selected != value) {
				_selected = value;
				if (_selected) {
					state = _skinW == 1 ? _stateMap["selected"] : _stateMap["rollOut"];
				} else {
					state = _stateMap["rollOut"];
				}
			}
		}
		
		private function get state():int {
			return _state;
		}
		
		private function set state(value:int):void {
			_state = value;
			callLater(changeState);
		}
		
		protected function changeState():void {
			if (_clips != null) {
				var index:int = _state;
				if (_skinW == 2 && _selected) {
					index += _skinH;
				}
				_bitmap.bitmapData = _clips[index];
			}
			_btnLabel.color = _labelColors[_state];
		}
		
		/**控制是否处于切换状态*/
		public function get toggle():Boolean {
			return _toggle;
		}
		
		public function set toggle(value:Boolean):void {
			if (_toggle != value) {
				_toggle = value;
			}
		}
		
		override public function set disabled(value:Boolean):void {
			if (_disabled != value) {
				super.disabled = value;
				state = _stateMap["rollOut"];
				ObjectUtils.gray(this, _disabled);
			}
		}
		
		/**按钮标签颜色*/
		public function get labelColors():String {
			return String(_labelColors);
		}
		
		public function set labelColors(value:String):void {
			_labelColors = StringUtils.fillArray(_labelColors, value);
			callLater(changeState);
		}
		
		/**按钮标签对齐[左,上,右,下]*/
		public function get labelMargin():String {
			return String(_labelMargin);
		}
		
		public function set labelMargin(value:String):void {
			_labelMargin = StringUtils.fillArray(_labelMargin, value);
			callLater(changeLabelSize);
		}
		
		/**按钮标签描边*/
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
		
		/**点击处理器*/
		public function get clickHandler():Handler {
			return _clickHandler;
		}
		
		public function set clickHandler(value:Handler):void {
			if (_clickHandler != value) {
				_clickHandler = value;
			}
		}
		
		/**按钮标签控件*/
		public function get btnLabel():Label {
			return _btnLabel;
		}
		
		override public function get width():Number {
			_btnLabel.validate();
			return super.width;
		}
		
		override public function get height():Number {
			_btnLabel.validate();
			return super.height;
		}
	}
}