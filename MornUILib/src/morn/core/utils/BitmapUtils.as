/**
 * Version 0.9.4.1.3 https://github.com/yungzhu/morn
 * Feedback yungzhu@gmail.com http://weibo.com/newyung
 */
package morn.core.utils {
	import flash.display.BitmapData;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	/**位图工具集*/
	public class BitmapUtils {
		
		/**获取9宫格拉伸位图数据*/
		public static function scale9Bmd(bmd:BitmapData, sizeGrid:Array, width:int, height:int):BitmapData {
			if (bmd.width == width && bmd.height == height) {
				return bmd;
			}
			if (width == 0 || height == 0) {
				return null;
			}
			var gw:int = int(sizeGrid[0]) + int(sizeGrid[2]);
			var gh:int = int(sizeGrid[1]) + int(sizeGrid[3]);
			var newBmd:BitmapData = new BitmapData(width, height, bmd.transparent, 0x00000000);
			var m:Matrix = new Matrix();
			//如果目标大小大于九宫格，则进行9宫格缩放，否则直接缩放
			if (width > gw && height > gh) {
				var grid:Rectangle = new Rectangle(sizeGrid[0], sizeGrid[1], bmd.width - sizeGrid[0] - sizeGrid[2], bmd.height - sizeGrid[1] - sizeGrid[3]);
				var rows:Array = [0, grid.top, grid.bottom, bmd.height];
				var cols:Array = [0, grid.left, grid.right, bmd.width];
				var newRows:Array = [0, grid.top, height - (bmd.height - grid.bottom), height];
				var newCols:Array = [0, grid.left, width - (bmd.width - grid.right), width];
				var newRect:Rectangle = new Rectangle();
				var clipRect:Rectangle = new Rectangle();
				for (var i:int = 0; i < 3; i++) {
					for (var j:int = 0; j < 3; j++) {
						newRect.setTo(cols[i], rows[j], cols[i + 1] - cols[i], rows[j + 1] - rows[j]);
						clipRect.setTo(newCols[i], newRows[j], newCols[i + 1] - newCols[i], newRows[j + 1] - newRows[j]);
						m.identity();
						m.a = clipRect.width / newRect.width;
						m.d = clipRect.height / newRect.height;
						m.tx = clipRect.x - newRect.x * m.a;
						m.ty = clipRect.y - newRect.y * m.d;
						newBmd.draw(bmd, m, null, null, clipRect, true);
					}
				}
			} else {
				m.a = width / bmd.width;
				m.d = height / bmd.height;
				newBmd.draw(bmd, m, null, null, new Rectangle(0, 0, width, height), true);
			}
			return newBmd;
		}
		
		/**创建切片资源*/
		public static function createClips(bmd:BitmapData, xNum:int, yNum:int):Vector.<BitmapData> {
			var clips:Vector.<BitmapData> = new Vector.<BitmapData>();
			var width:int = Math.max(bmd.width / xNum, 1);
			var height:int = Math.max(bmd.height / yNum, 1);
			var point:Point = new Point();
			for (var i:int = 0; i < xNum; i++) {
				for (var j:int = 0; j < yNum; j++) {
					var item:BitmapData = new BitmapData(width, height);
					item.copyPixels(bmd, new Rectangle(i * width, j * height, width, height), point);
					clips.push(item);
				}
			}
			return clips;
		}
	}
}