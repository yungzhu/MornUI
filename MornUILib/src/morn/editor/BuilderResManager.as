/**
 * Morn UI Version 3.0 http://www.mornui.com/
 * Feedback yungzhu@gmail.com http://weibo.com/newyung
 */
package morn.editor {
	import flash.display.BitmapData;
	import morn.core.managers.AssetManager;
	import morn.core.utils.BitmapUtils;
	
	/**重置加载器(对MornUI库的AssetsManager进行重置，通过Sys提供的方法，调用编辑器内的资源)*/
	public class BuilderResManager extends AssetManager {
		public function BuilderResManager() {
		
		}
		
		override public function hasClass(name:String):Boolean {
			return Sys.hasRes(name);
		}
		
		override public function getClass(name:String):Class {
			return Sys.getResClass(name);
		}
		
		override public function getAsset(name:String):* {
			return Sys.getRes(name);
		}
		
		override public function getBitmapData(name:String, cache:Boolean = true):BitmapData {
			return Sys.getResBitmapData(name);
		}
		
		/**获取切片资源*/
		override public function getClips(name:String, xNum:int, yNum:int, cache:Boolean = true, source:BitmapData = null):Vector.<BitmapData> {
			var bmd:BitmapData = getBitmapData(name, false);
			var clips:Vector.<BitmapData> = BitmapUtils.createClips(bmd, xNum, yNum);
			return clips;
		}
	}
}