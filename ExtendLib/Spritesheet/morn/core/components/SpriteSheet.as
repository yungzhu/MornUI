package morn.core.components {
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import morn.core.handlers.Handler;
	/**
	 * @author handylee  QQ 70863687 lihandi@gmail.com
	 * 
	 * @param url 皮肤
	 * @param json String || Array
	 * @param [dir] String
	 * 
	 * @example	方式1
	 * new SpriteSheet("皮肤地址 png.animate.move","不带后缀的json文件名","json文件所在相对目录");
	 * 
	 * @example 方式2
	 * new SpriteSheet("皮肤地址 png.animate.move",已加载完成的数组数据);
	 * 
	 * @example 方式3
	 * var s:SpriteSheet = new SpriteSheet("皮肤地址 png.animate.move");
	 * s.sheet = 已加载完成的数组数据
	 * 
	 * //直接用
	 * s.frame = 2; 
	 * 
	 * //作为资源库使用
	 * var bm:Bitmap = s.getIndex(2)
	 * addChild(bm);
	 * 
	 * var bm2:Bitmap = s.getLabel("close");
	 * addChild(bm2);
	 *
	 * 数组格式为  [ {"x":0,"y":0,"w":0,"h":0} ] 
	 * 或者带偏移量的 [ {"x":0,"y":0,"w":0,"h":0,"ox":0,"oy":0,"ow":0,"oh":0} ]
	 * 或者带标签name [ {"x":0,"y":0,"w":0,"h":0,"name":"close"} ] 
	 * 
	 * 
	 * 具体格式可自己修改后 更改loadComplete方法
	 * 
	 * 
	 * 默认autoPlay为false
	 * 
	 * 分享个生成数据工具 http://zengrong.net/sprite_sheet_editor
	 */
	public class SpriteSheet extends Clip {
		private var _sheet:Array; //
		private var _labels:Object = { };
		
		public function SpriteSheet(url:String,json:*=null,jsonDir:String="assets/spritesheet/") {
			this.url = url;
			
			//加载SpriteSheet数据文件
			if (json) {
				if(json is String){
					App.loader.loadTXT(jsonDir + json + ".json", new Handler(loadSuccess), null, new Handler(loadError),false);
				}else if (json is Array) {
					this.sheet = json;
				}
			}
		}
		/**
		 * 根据标签名 返回Bitmap
		 * @param	_label 标签名
		 * @return
		 */
		public function getLabel(_label:String):Bitmap {
			if (!_labels.hasOwnProperty(_label)) throw new Error("label "+ _label+" not found");
			return new Bitmap(clips[_labels[_label]]);
		}
		
		/**
		 * 根据frame 返回Bitmap
		 * @param	v frame索引
		 * @return
		 */
		public function getIndex(_index:int):Bitmap {
			if (_index >= totalFrame || _index < 0) throw new Error("clip idx error");
			return new Bitmap(clips[_index]);
		}
		
		override public function set url(value:String):void {
			if (_url != value && Boolean(value)) {
				_url = value;
			}
		}
		
		private function loadSuccess(content:String):void {
			this.sheet = JSON.parse(content) as Array;
		}
		
		private function loadError(content:String):void {
			throw new Error(content + " 加载失败");
		}
		
		public function get sheet():Array {
			return _sheet;
		}
		
		public function set sheet(v:Array):void {
			_sheet = v;
			_labels = { };
			callLater(changeClip);
		}
		
		override protected function loadComplete(url:String, bmd:BitmapData):void {
			if (url == _url && bmd) {
				var _clips:Vector.<BitmapData> = new Vector.<BitmapData>();
				var point:Point = new Point(0,0);
				var item:BitmapData;
				for (var i:int = 0; i < sheet.length; i++) {
					if(sheet[i].ox || sheet[i].ow){
						item = new BitmapData(sheet[i].ow, sheet[i].oh,true,0x0);
						point.x = Math.abs(sheet[i].ox);
						point.y = Math.abs(sheet[i].oy);
					}else {
						item = new BitmapData(sheet[i].w, sheet[i].h);
					}
					//是否有标签 有则加入
					if (sheet[i].name) { // or sheet[i].label 看生成数据
						_labels[sheet[i].name] = i;
					}
					item.copyPixels(bmd, new Rectangle(sheet[i].x, sheet[i].y, sheet[i].w, sheet[i].h), point);
					_clips.push(item);
				}
				clips = _clips;
			}
		}
	}

}