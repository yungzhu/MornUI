package morn.core.components {
	import flash.events.MouseEvent;
	import flash.text.TextFieldAutoSize;
	import morn.core.handlers.Handler;	
	
	/**分页 (翻页条)
	 * @author Coamy  172808712*/
	public class Paging extends Component {
		protected var _totalPage:int;
		protected var _page:int;
		protected var _space:int = 3;
		
		protected var _skin:String;
		protected var _pageLabel:Label;
		protected var _prevButton:Button;
		protected var _nextButton:Button;
		
		protected var _pageChangeHandler:Handler;
		
		public function Paging(skin:String = null) {
			this.skin = skin;
		}
		
		override protected function preinitialize():void {
			mouseChildren = true;
		}
		
		override protected function createChildren():void {
			addChild(_pageLabel = new Label());
			addChild(_prevButton = new Button());
			addChild(_nextButton = new Button());
		}
		
		override protected function initialize():void {
			_pageLabel.selectable = false;
			_pageLabel.align = TextFieldAutoSize.CENTER;
			_pageLabel.text = "0/0";
			_prevButton.disabled = true;
			_nextButton.disabled = true;
			_prevButton.addEventListener(MouseEvent.MOUSE_DOWN, onButtonMouseDown);
			_nextButton.addEventListener(MouseEvent.MOUSE_DOWN, onButtonMouseDown);
			callLater(resetPosition);
		}
		
		protected function resetPosition():void {
			_pageLabel.x = _prevButton.x + _prevButton.width + _space;
			_nextButton.x = _pageLabel.x + _pageLabel.width + _space;
			_contentWidth = _nextButton.x + _nextButton.width;
			_contentHeight = Math.max(_pageLabel.height, _nextButton.height);
		}
		
		protected function onButtonMouseDown(e:MouseEvent):void {
			var isNext:Boolean = e.currentTarget == _nextButton;
			isNext ? page++ : page--;
		}
		
		/**皮肤*/
		public function get skin():String {
			return _skin;
		}
		
		public function set skin(value:String):void {
			if (_skin != value) {
				_skin = value;
				_pageLabel.skin = _skin;
				_pageLabel.width = _pageLabel.width;
				_pageLabel.height = _pageLabel.height;
				_prevButton.skin = _skin + "$prev";
				_nextButton.skin = _skin + "$next";
			}
		}
		
		/**当前页码*/
		public function get page():int {
			return _page;
		}
		
		public function set page(value:int):void {
			if (_page == value)
				return;
			
			_page = value;
			updatePage();
			
			if (_pageChangeHandler != null) {
				_pageChangeHandler.executeWith([_page]);
			}
		}
		
		/**最大分页数*/
		public function get totalPage():int {
			return _totalPage;
		}
		
		public function set totalPage(value:int):void {
			_totalPage = value;
			updatePage();
		}
		
		private function updatePage():void {
			if (_page <= 0) {
				_page = 0;
			}
			_prevButton.disabled = _page <= 0;
			
			if (_page >= _totalPage - 1) {
				_page = _totalPage - 1;
			}
			_nextButton.disabled = _page >= _totalPage - 1;
			
			_pageLabel.text = _page + 1 + " / " + _totalPage;
		}
		
		/**总页数或当前页被改变时执行的处理器(默认返回参数page:int)*/
		public function get pageChangeHandler():Handler {
			return _pageChangeHandler;
		}
		
		public function set pageChangeHandler(value:Handler):void {
			_pageChangeHandler = value;
		}
		
		/**间距*/
		public function get space():int {
			return _space;
		}
		
		public function set space(value:int):void {
			_space = value;
			resetPosition();
		}
		
		/**字体颜色*/
		public function get color():Object {
			return _pageLabel.color;
		}
		
		public function set color(value:Object):void {
			_pageLabel.color = value;
		}
		
		/**字体类型*/
		public function get font():String {
			return _pageLabel.font;
		}
		
		public function set font(value:String):void {
			_pageLabel.font = value;
		}
		
		/**字体大小*/
		public function get size():Object {
			return _pageLabel.size;
		}
		
		public function set size(value:Object):void {
			_pageLabel.size = value;
		}
		
		/**描边(格式:color,alpha,blurX,blurY,strength,quality)*/
		public function get stroke():String {
			return _pageLabel.stroke;
		}
		
		public function set stroke(value:String):void {
			_pageLabel.stroke = value;
		}
	
	}
}