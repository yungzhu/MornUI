/**
 * Morn UI Version 3.0 http://www.mornui.com/
 * Feedback yungzhu@gmail.com http://weibo.com/newyung
 */
package morn.core.components {
	import flash.display.DisplayObject;
	import morn.editor.core.IBox;
	
	/**容器类*/
	public class Box extends Component implements IBox {
		public function Box() {
		}
		
		override protected function preinitialize():void {
			mouseChildren = true;
		}
		
		/**添加显示对象*/
		public function addElement(element:DisplayObject, x:Number, y:Number):void {
			element.x = x;
			element.y = y;
			addChild(element);
		}
		
		/**增加显示对象到index层*/
		public function addElementAt(element:DisplayObject, index:int, x:Number, y:Number):void {
			element.x = x;
			element.y = y;
			addChildAt(element, index);
		}
		
		/**批量增加显示对象*/
		public function addElements(elements:Array):void {
			for (var i:int = 0, n:int = elements.length; i < n; i++) {
				var item:DisplayObject = elements[i];
				addChild(item);
			}
		}
		
		/**删除子显示对象，子对象为空或者不包含子对象时不抛出异常*/
		public function removeElement(element:DisplayObject):void {
			if (element && contains(element)) {
				removeChild(element);
			}
		}
		
		/**删除所有子显示对象
		 * @param except 例外的对象(不会被删除)*/
		public function removeAllChild(except:DisplayObject = null):void {
			for (var i:int = numChildren - 1; i > -1; i--) {
				if (except != getChildAt(i)) {
					removeChildAt(i);
				}
			}
		}
		
		/**增加显示对象到某对象上面
		   @param element 要插入的对象
		 @param compare 参考的对象*/
		public function insertAbove(element:DisplayObject, compare:DisplayObject):void {
			removeElement(element);
			var index:int = getChildIndex(compare);
			addChildAt(element, Math.min(index + 1, numChildren));
		}
		
		/**增加显示对象到某对象下面
		   @param element 要插入的对象
		 @param compare 参考的对象*/
		public function insertBelow(element:DisplayObject, compare:DisplayObject):void {
			removeElement(element);
			var index:int = getChildIndex(compare);
			addChildAt(element, Math.max(index, 0));
		}
		
		override public function set dataSource(value:Object):void {
			_dataSource = value;
			for (var name:String in value) {
				var comp:Component = getChildByName(name) as Component;
				if (comp) {
					comp.dataSource = value[name];
				} else {
					if (hasOwnProperty(name)) {
						this[name] = value[name];
					}
				}
			}
		}
	}
}