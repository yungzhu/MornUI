/**
 * Morn UI Version 3.0 http://www.mornui.com/
 * Feedback yungvip@163.com weixin:yungzhu
 */
package morn.core.utils {
	import flash.display.BitmapData;
	import flash.display.Graphics;
	import flash.display.Shape;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	/**位图工具集*/
	public class BitmapUtils {
		private static var m:Matrix = new Matrix();
		private static var newRect:Rectangle = new Rectangle();
		private static var clipRect:Rectangle = new Rectangle();
		private static var grid:Rectangle = new Rectangle();
		private static var destPoint:Point = new Point();
		
		/**获取9宫格拉伸位图数据*/
		public static function scale9Bmd(bmd:BitmapData, sizeGrid:Array, width:int, height:int):BitmapData {
			if (bmd.width == width && bmd.height == height) {
				return bmd;
			}
			
			width = width > 1 ? width : 1;
			height = height > 1 ? height : 1;
			
			var gw:int = int(sizeGrid[0]) + int(sizeGrid[2]);
			var gh:int = int(sizeGrid[1]) + int(sizeGrid[3]);
			var newBmd:BitmapData = new BitmapData(width, height, bmd.transparent, 0x00000000);
			var shape:Shape = new Shape();
			var g:Graphics = shape.graphics;
			//如果目标大于九宫格，则进行9宫格缩放，否则直接缩放
			if (width > gw && height > gh) {
				var repeatFill:Boolean = sizeGrid.length > 4 && sizeGrid[4] == 1;
				setRect(grid, sizeGrid[0], sizeGrid[1], bmd.width - sizeGrid[0] - sizeGrid[2], bmd.height - sizeGrid[1] - sizeGrid[3]);
				var rows:Array = [0, grid.top, grid.bottom, bmd.height];
				var cols:Array = [0, grid.left, grid.right, bmd.width];
				var newRows:Array = [0, grid.top, height - (bmd.height - grid.bottom), height];
				var newCols:Array = [0, grid.left, width - (bmd.width - grid.right), width];
				for (var i:int = 0; i < 3; i++) {
					for (var j:int = 0; j < 3; j++) {
						setRect(newRect, cols[i], rows[j], cols[i + 1] - cols[i], rows[j + 1] - rows[j]);
						setRect(clipRect, newCols[i], newRows[j], newCols[i + 1] - newCols[i], newRows[j + 1] - newRows[j]);
						m.identity();
						m.a = clipRect.width / newRect.width;
						m.d = clipRect.height / newRect.height;
						m.tx = clipRect.x - newRect.x * m.a;
						m.ty = clipRect.y - newRect.y * m.d;
						if (!repeatFill || (i != 1 && j != 1)) {
							newBmd.draw(bmd, m, null, null, clipRect, true);
						} else {
							if (newRect.width != 0 && newRect.height != 0) {
								var tempBmd:BitmapData = new BitmapData(newRect.width, newRect.height, bmd.transparent, 0x00000000);
								tempBmd.copyPixels(bmd, newRect, destPoint);
								
								g.clear();
								g.beginBitmapFill(tempBmd);
								g.drawRect(0, 0, clipRect.width, clipRect.height);
								g.endFill();
								
								m.identity();
								m.tx = clipRect.x;
								m.ty = clipRect.y;
								
								newBmd.draw(shape, m, null, null, clipRect, true);
								g.clear();
								tempBmd.dispose();
							}
						}
					}
				}
			} else {
				m.identity();
				m.scale(width / bmd.width, height / bmd.height);
				setRect(grid, 0, 0, width, height);
				newBmd.draw(bmd, m, null, null, grid, true);
			}
			return newBmd;
		}
		
		/**设置rect，兼容flash player10*/
		public static function setRect(rect:Rectangle, x:Number = 0, y:Number = 0, width:Number = 0, height:Number = 0):Rectangle {
			rect.x = x;
			rect.y = y;
			rect.width = width;
			rect.height = height;
			return rect;
		}
		
		/**创建切片资源*/
		public static function createClips(bmd:BitmapData, xNum:int, yNum:int):Vector.<BitmapData> {
			if (bmd == null) {
				return null;
			}
			var clips:Vector.<BitmapData> = new Vector.<BitmapData>();
			var width:int = Math.max(bmd.width / xNum, 1);
			var height:int = Math.max(bmd.height / yNum, 1);
			var point:Point = new Point();
			for (var i:int = 0; i < yNum; i++) {
				for (var j:int = 0; j < xNum; j++) {
					var item:BitmapData = new BitmapData(width, height);
					item.copyPixels(bmd, new Rectangle(j * width, i * height, width, height), point);
					clips.push(item);
				}
			}
			return clips;
		}
	}
}