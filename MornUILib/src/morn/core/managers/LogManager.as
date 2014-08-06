/**
 * Morn UI Version 3.0 http://www.mornui.com/
 * Feedback yungzhu@gmail.com http://weibo.com/newyung
 */
package morn.core.managers {
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.FocusEvent;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.filters.GlowFilter;
	import flash.system.System;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.ui.Keyboard;
	import morn.core.utils.ObjectUtils;
	
	/**日志管理器*/
	public class LogManager extends Sprite {
		private var _msgs:Array = [];
		private var _box:Sprite;
		private var _textField:TextField;
		private var _filter:TextField;
		private var _filters:Array = [];
		private var _canScroll:Boolean = true;
		private var _scroll:TextField;
		
		public function LogManager() {
			//容器
			_box = new Sprite();
			_box.addChild(ObjectUtils.createBitmap(400, 300, 0x333333, 0.9));
			_box.visible = false;
			addChild(_box);
			//筛选栏
			_filter = new TextField();
			_filter.width = 270;
			_filter.height = 20;
			_filter.type = "input";
			_filter.textColor = 0xffffff;
			_filter.border = true;
			_filter.borderColor = 0xBFBFBF;
			_filter.defaultTextFormat = new TextFormat("Arial", 12);
			_filter.addEventListener(KeyboardEvent.KEY_DOWN, onFilterKeyDown);
			_filter.addEventListener(FocusEvent.FOCUS_OUT, onFilterFocusOut);
			_box.addChild(_filter);
			//控制按钮			
			var clear:TextField = createLinkButton("Clear");
			clear.addEventListener(MouseEvent.CLICK, onClearClick);
			clear.x = 280;
			_box.addChild(clear);
			_scroll = createLinkButton("Pause");
			_scroll.addEventListener(MouseEvent.CLICK, onScrollClick);
			_scroll.x = 315;
			_box.addChild(_scroll);
			var copy:TextField = createLinkButton("Copy");
			copy.addEventListener(MouseEvent.CLICK, onCopyClick);
			copy.x = 350;
			_box.addChild(copy);
			//信息栏
			_textField = new TextField();
			_textField.width = 400;
			_textField.height = 280;
			_textField.y = 20;
			_textField.multiline = true;
			_textField.wordWrap = true;
			_textField.defaultTextFormat = new TextFormat("微软雅黑,Arial");
			_box.addChild(_textField);
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private function onAddedToStage(e:Event):void {
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			stage.addEventListener(KeyboardEvent.KEY_DOWN, onStageKeyDown);
		}
		
		private function createLinkButton(text:String):TextField {
			var tf:TextField = new TextField();
			tf.selectable = false;
			tf.autoSize = "left";
			tf.textColor = 0x0080C0;
			tf.filters = [new GlowFilter(0xffffff, 0.8, 2, 2, 10)];
			tf.text = text;
			return tf;
		}
		
		private function onCopyClick(e:MouseEvent):void {
			System.setClipboard(_textField.text);
		}
		
		private function onScrollClick(e:MouseEvent):void {
			_canScroll = !_canScroll;
			_scroll.text = _canScroll ? "Pause" : "Start";
			if (_canScroll) {
				refresh(null);
			}
		}
		
		private function onClearClick(e:MouseEvent):void {
			clear();
		}
		
		private function onFilterKeyDown(e:KeyboardEvent):void {
			if (e.keyCode == Keyboard.ENTER) {
				App.stage.focus = _box;
			}
		}
		
		private function onFilterFocusOut(e:FocusEvent):void {
			_filters = Boolean(_filter.text) ? _filter.text.split(",") : [];
			refresh(null);
		}
		
		private function onStageKeyDown(e:KeyboardEvent):void {
			if (e.ctrlKey && e.keyCode == Keyboard.L) {
				toggle();
			}
		}
		
		/**清理所有日志*/
		public function clear():void {
			_msgs.length = 0;
			_textField.htmlText = "";
		}
		
		/**信息*/
		public function info(... args):void {
			print("info", args, 0x3EBDF4);
		}
		
		/**消息*/
		public function echo(... args):void {
			print("echo", args, 0x00C400);
		}
		
		/**调试*/
		public function debug(... args):void {
			print("debug", args, 0xdddd00);
		}
		
		/**错误*/
		public function error(... args):void {
			print("error", args, 0xFF4646);
		}
		
		/**警告*/
		public function warn(... args):void {
			print("warn", args, 0xFFFF80);
		}
		
		public function print(type:String, args:Array, color:uint):void {
			var msg:String = "<p><font color='#" + color.toString(16) + "'><b>[" + type + "]</b></font> <font color='#EEEEEE'>" + args.join(" ") + "</font></p>";
			trace("[" + type + "]", args.join(" "));
			if (_msgs.length > 500) {
				_msgs.length = 0;
			}
			_msgs.push(msg);
			if (_box.visible) {
				refresh(msg);
			}
		}
		
		/**打开或隐藏面板*/
		public function toggle():void {
			_box.visible = !_box.visible;
			if (_box.visible) {
				refresh(null);
			}
		}
		
		/**根据过滤刷新显示*/
		private function refresh(newMsg:String):void {
			var msg:String = "";
			if (newMsg != null) {
				if (isFilter(newMsg)) {
					msg = (_textField.htmlText || "") + newMsg;
					_textField.htmlText = msg;
				}
			} else {
				for each (var item:String in _msgs) {
					if (isFilter(item)) {
						msg += item;
					}
				}
				_textField.htmlText = msg;
			}
			if (_canScroll) {
				_textField.scrollV = _textField.maxScrollV;
			}
		}
		
		/**是否是筛选属性*/
		private function isFilter(msg:String):Boolean {
			if (_filters.length < 1) {
				return true;
			}
			for each (var item:String in _filters) {
				if (msg.indexOf(item) > -1) {
					return true;
				}
			}
			return false;
		}
	}
}