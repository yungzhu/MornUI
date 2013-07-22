/**
 * Project:		MornUILib 
 * Author:		醉人的烟圈(齐小伟)
 * QQ:			7379076
 * MSN:			gamefriends@hotmail.com
 * GTalk:		gamefriends.net@gmail.com 
 * Email:		gamefriends@qq.com
 * Created:		2013-7-19 
 */
package morn.core.components
{
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextFormatAlign;

	[Event(name="change", type="flash.events.Event")]
	/**
	 * 分页组件
	 * <br/>
	 * 支持常规skin和xml描述皮肤
	 * <li>skin(该方法要修改属性时,会调用changePaging重新布局)</li>
	 * <li>compositeXML(该方法要修改属性时,不会重新布局)</li>
	 * @author qixiaowei
	 * 
	 */
	public class Paging extends Component implements ICompositeComponent
	{
		//------组件
		protected var _skin:String;
		protected var _bg:Image;
		protected var _upButton:Button;
		protected var _label:Label;
		protected var _downButton:Button;
		//------数据
		protected var _compositeXML:XML;
		protected var _currentPage:int = 1;
		protected var _totalPage:int = 1;
		public function Paging(skin:String = null)
		{
			this.skin = skin;
		}
		
		override protected function preinitialize():void
		{
			mouseChildren = true;
		}
		
		override protected function createChildren():void
		{
			addChild(_bg = new Image());
			addChild(_label = new Label());
			addChild(_upButton = new Button());
			addChild(_downButton = new Button());
		}
		
		override protected function initialize():void
		{
			_upButton.mouseEnabled = _downButton.mouseEnabled = true;
			_upButton.addEventListener(MouseEvent.CLICK, onClick);
			_downButton.addEventListener(MouseEvent.CLICK, onClick);
		}

		private function onClick(event:MouseEvent):void
		{
			switch(event.currentTarget)
			{
				case _upButton:
					if(currentPage > 1){
						currentPage--;
					}
					break;
				case _downButton:
					if(currentPage < totalPage){
						currentPage++;
					}
					break;
			}
		}
		
		/**皮肤*/
		public function get skin():String {
			return _skin;
		}
		
		public function set skin(value:String):void {
			if (_skin != value) {
				compositeXML = null;
				
				_skin = value;
				_bg.url = _skin;
				_upButton.skin = _skin + "$up";
				_downButton.skin = _skin + "$down";
				callLater(changePaging);
			}
		}
		
		protected function changePaging():void
		{
			if(_compositeXML == null){
				_upButton.x = 2;
				_upButton.y = (_bg.height - _upButton.height) / 2;
				
				_downButton.x = _bg.width - _downButton.width - 2;
				_downButton.y = (_bg.height - _downButton.height) / 2;
				
				//默认居中
				_label.align = TextFormatAlign.CENTER;
				_label.width = _bg.width;
				_label.x = (_bg.width - _label.width) / 2;
				_label.y = (_bg.height - _label.height) / 2;
			}
		}

		public function get compositeXML():XML
		{
			return _compositeXML;
		}

		/**
		 * 组合组件的描述(XML)
		 */
		public function set compositeXML(value:*):void
		{
			if(value is XML == false)
			{
				value = new XML(value);
			}
			if(_compositeXML != value)
			{
				_compositeXML = value;
				
				for (var i:int = 0, m:int = _compositeXML.children().length(); i < m; i++) {
					var node:XML = _compositeXML.children()[i];
					var comp:Component;
					if(node.@name == "bg")
					{
						comp = _bg;
					}else if(node.@name == "up")
					{
						comp = _upButton;
					}else if(node.@name == "label")
					{
						comp = _label;
					}else if(node.@name == "down")
					{
						comp = _downButton;
					}
					if(!comp)
					{
						continue;
					}
					for each (var attrs:XML in node.attributes()) {
						var prop:String = attrs.name().toString();
						var v:String = attrs;
						if (comp.hasOwnProperty(prop)) {
							comp[prop] = (v == "true" ? true : (v == "false" ? false : v))
						}
					}
				}
				_label.text = String(_currentPage) + "/" + String(_totalPage);
				_upButton.disabled = _currentPage == 1 ? true : false;
				_downButton.disabled = _currentPage == _totalPage ? true : false;
			}
		}
		
		public function get label():String
		{
			return _label.text;
		}
		/**标签文字*/
		public function set label(value:String):void
		{
			_label.text = value;
		}
		/**标签文字颜色*/
		public function get labelColor():Object
		{
			return _label.color;
		}
		
		public function set labelColor(value:Object):void
		{
			_label.color = value;
		}
		/**标签文字大小*/
		public function get labelSize():Object
		{
			return _label.size;
		}
		
		public function set labelSize(value:Object):void
		{
			_label.size = value;
			callLater(changePaging);
		}
		/**按钮标签粗细*/
		public function get labelBold():Object {
			return _label.bold;
		}
		
		public function set labelBold(value:Object):void {
			_label.bold = value
			callLater(changePaging);
		}
		/**标签字间距*/
		public function get letterSpacing():Object 
		{
			return _label.letterSpacing;
		}
		
		public function set letterSpacing(value:Object):void 
		{
			_label.letterSpacing = value;
			callLater(changePaging);
		}
		/**按钮标签描边(格式:color,alpha,blurX,blurY,strength,quality)*/
		public function get labelStroke():String {
			return _label.stroke;
		}
		
		public function set labelStroke(value:String):void {
			_label.stroke = value;
		}

		/**
		 * 当前页（如果没有数据为0,有数据从1开始）
		 */
		public function get currentPage():int
		{
			return _currentPage;
		}

		public function set currentPage(value:int):void
		{
			_currentPage = value;
			callLater(changePaging);
			
			_label.text = String(_currentPage) + "/" + String(_totalPage);
			_upButton.disabled = _currentPage == 1 ? true : false;
			_downButton.disabled = _currentPage == _totalPage ? true : false;
			dispatchEvent(new Event(Event.CHANGE));
		}

		/**
		 * 总页数
		 */
		public function get totalPage():int
		{
			return _totalPage;
		}

		public function set totalPage(value:int):void
		{
			_totalPage = value;
			callLater(changePaging);
			
			_label.text = String(_currentPage) + "/" + String(_totalPage);
			_upButton.disabled = _currentPage == 1 ? true : false;
			_downButton.disabled = _currentPage == _totalPage ? true : false;
			dispatchEvent(new Event(Event.CHANGE));
		}
	}
}