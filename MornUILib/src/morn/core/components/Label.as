/**
 * Morn UI Version 1.2.0309 http://code.google.com/p/morn https://github.com/yungzhu/morn
 * Feedback yungzhu@gmail.com http://weibo.com/newyung
 */
package morn.core.components {
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.events.Event;
	import flash.filters.GlowFilter;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import morn.core.utils.BitmapUtils;
	import morn.core.utils.ObjectUtils;
	import morn.core.utils.StringUtils;
	
	/**文本发生改变后触发*/
	[Event(name="change",type="flash.events.Event")]
	
	/**文字标签*/
	public class Label extends Component {
		protected var _textField:TextField;
		protected var _format:TextFormat;
		protected var _text:String = "";
		protected var _isHtml:Boolean;
		protected var _stroke:String;
		protected var _skin:String;
		protected var _bitmap:Bitmap;
		protected var _sizeGrid:Array = [2, 2, 2, 2];
		protected var _margin:Array = [0, 0, 0, 0];
		
		public function Label(text:String = "", skin:String = null) {
			this.text = text;
			this.skin = skin;
		}
		
		override protected function preinitialize():void {
			mouseEnabled = false;
			mouseChildren = true;
			_format = new TextFormat(Styles.fontName, Styles.fontSize, Styles.labelColor);
		}
		
		override public function get mouseEnabled():Boolean {
			return super.mouseEnabled;
		}
		
		override public function set mouseEnabled(value:Boolean):void {
			super.mouseEnabled = value;
		}
		
		override protected function createChildren():void {
			addChild(_bitmap = new Bitmap());
			addChild(_textField = new TextField());
		}
		
		override protected function initialize():void {
			_textField.selectable = false;
			_textField.autoSize = TextFieldAutoSize.LEFT;
		}
		
		/**显示文本*/
		public function get text():String {
			return _text;
		}
		
		public function set text(value:String):void {
			if (_text != value) {
				_text = value || "";
				callLater(changeText);
				sendEvent(Event.CHANGE);
			}
		}
		
		protected function changeText():void {
			_textField.defaultTextFormat = _format;
			_isHtml ? _textField.htmlText = _text : _textField.text = App.lang.getLang(_text);
		}
		
		override protected function changeSize():void {
			if (!isNaN(_width)) {
				_textField.autoSize = TextFieldAutoSize.NONE;
				_textField.width = _width - _margin[0] - _margin[2];
				_textField.height = isNaN(_height) ? 18 : _height - _margin[1] - _margin[3];
			} else {
				_width = _height = NaN;
				_textField.autoSize = TextFieldAutoSize.LEFT;
			}
			super.changeSize();
		}
		
		/**是否是html格式*/
		public function get isHtml():Boolean {
			return _isHtml;
		}
		
		public function set isHtml(value:Boolean):void {
			if (_isHtml != value) {
				_isHtml = value;
				callLater(changeText);
			}
		}
		
		/**描边(格式:color,alpha,blurX,blurY,strength,quality)*/
		public function get stroke():String {
			return _stroke;
		}
		
		public function set stroke(value:String):void {
			if (_stroke != value) {
				_stroke = value;
				ObjectUtils.clearFilter(_textField, GlowFilter);
				if (StringUtils.isNotEmpty(_stroke)) {
					var a:Array = StringUtils.fillArray(Styles.labelStroke, _stroke);
					ObjectUtils.addFilter(_textField, new GlowFilter(a[0], a[1], a[2], a[3], a[4], a[5]));
				}
			}
		}
		
		/**是否是多行*/
		public function get multiline():Boolean {
			return _textField.multiline;
		}
		
		public function set multiline(value:Boolean):void {
			_textField.multiline = value;
		}
		
		/**是否是密码*/
		public function get asPassword():Boolean {
			return _textField.displayAsPassword;
		}
		
		public function set asPassword(value:Boolean):void {
			_textField.displayAsPassword = value;
		}
		
		/**宽高是否自适应*/
		public function get autoSize():String {
			return _textField.autoSize;
		}
		
		public function set autoSize(value:String):void {
			_textField.autoSize = value;
		}
		
		/**是否自动换行*/
		public function get wordWrap():Boolean {
			return _textField.wordWrap;
		}
		
		public function set wordWrap(value:Boolean):void {
			_textField.wordWrap = value;
		}
		
		/**是否可选*/
		public function get selectable():Boolean {
			return _textField.selectable;
		}
		
		public function set selectable(value:Boolean):void {
			_textField.selectable = value;
			mouseEnabled = value;
		}
		
		/**是否具有背景填充*/
		public function get background():Boolean {
			return _textField.background;
		}
		
		public function set background(value:Boolean):void {
			_textField.background = value;
		}
		
		/**文本字段背景的颜色*/
		public function get backgroundColor():uint {
			return _textField.backgroundColor;
		}
		
		public function set backgroundColor(value:uint):void {
			_textField.backgroundColor = value;
		}
		
		/**字体颜色*/
		public function get color():Object {
			return _format.color;
		}
		
		public function set color(value:Object):void {
			_format.color = value;
			callLater(changeText);
		}
		
		/**字体类型*/
		public function get font():String {
			return _format.font;
		}
		
		public function set font(value:String):void {
			_format.font = value;
			callLater(changeText);
		}
		
		/**对齐方式*/
		public function get align():String {
			return _format.align;
		}
		
		public function set align(value:String):void {
			_format.align = value;
			callLater(changeText);
		}
		
		/**粗体类型*/
		public function get bold():Object {
			return _format.bold;
		}
		
		public function set bold(value:Object):void {
			_format.bold = value;
			callLater(changeText);
		}
		
		/**垂直间距*/
		public function get leading():Object {
			return _format.leading;
		}
		
		public function set leading(value:Object):void {
			_format.leading = value;
			callLater(changeText);
		}
		
		/**第一个字符的缩进*/
		public function get indent():Object {
			return _format.indent;
		}
		
		public function set indent(value:Object):void {
			_format.indent = value;
			callLater(changeText);
		}
		
		/**字体大小*/
		public function get size():Object {
			return _format.size;
		}
		
		public function set size(value:Object):void {
			_format.size = value;
			callLater(changeText);
		}
		
		/**下划线类型*/
		public function get underline():Object {
			return _format.underline;
		}
		
		public function set underline(value:Object):void {
			_format.underline = value;
			callLater(changeText);
		}
		
		/**边距(格式:左边距,上边距,右边距,下边距)*/
		public function get margin():String {
			return _margin.join(",");
		}
		
		public function set margin(value:String):void {
			_margin = StringUtils.fillArray(_margin, value, int);
			_textField.x = _margin[0];
			_textField.y = _margin[1];
			callLater(changeSize);
		}
		
		/**格式*/
		public function get format():TextFormat {
			return _format;
		}
		
		public function set format(value:TextFormat):void {
			_format = value;
			callLater(changeText);
		}
		
		/**文本控件*/
		public function get textField():TextField {
			return _textField;
		}
		
		/**将指定的字符串追加到文本的末尾*/
		public function appendText(newText:String):void {
			_text += newText;
			callLater(changeText);
		}
		
		/**皮肤*/
		public function get skin():String {
			return _skin;
		}
		
		public function set skin(value:String):void {
			if (_skin != value) {
				_skin = value;
				_bitmap.bitmapData = App.asset.getBitmapData(_skin);
				_contentWidth = _bitmap.bitmapData.width;
				_contentHeight = _bitmap.bitmapData.height;
			}
		}
		
		protected function changeBitmap():void {
			if (StringUtils.isNotEmpty(_skin) && App.asset.hasClass(_skin)) {
				var source:BitmapData = App.asset.getBitmapData(_skin);
				//清理临时位图数据
				if (_bitmap.bitmapData && _bitmap.bitmapData != source) {
					_bitmap.bitmapData.dispose();
				}
				_bitmap.bitmapData = BitmapUtils.scale9Bmd(source, _sizeGrid, width, height);
			}
		}
		
		/**九宫格信息(格式:左边距,上边距,右边距,下边距)*/
		public function get sizeGrid():String {
			return _sizeGrid.join(",");
		}
		
		public function set sizeGrid(value:String):void {
			_sizeGrid = StringUtils.fillArray([4, 4, 4, 4], value);
			callLater(changeBitmap);
		}
		
		override public function set width(value:Number):void {
			super.width = value;
			callLater(changeBitmap);
		}
		
		override public function set height(value:Number):void {
			super.height = value;
			callLater(changeBitmap);
		}
		
		override public function set dataSource(value:Object):void {
			if (value is String) {
				text = value as String;
			} else {
				super.dataSource = value;
			}
		}
	}
}