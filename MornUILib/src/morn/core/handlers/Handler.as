/**
 * Morn UI Version 2.0.0526 http://www.mornui.com/
 * Feedback yungzhu@gmail.com http://weibo.com/newyung
 */
package morn.core.handlers {
	
	/**处理器*/
	public class Handler {
		/**处理方法*/
		public var method:Function;
		/**参数*/
		public var args:Array;
		
		public function Handler(method:Function = null, args:Array = null) {
			this.method = method;
			this.args = args;
		}
		
		/**执行处理*/
		public function execute():void {
			if (method != null) {
				method.apply(null, args);
			}
		}
		
		/**执行处理(增加数据参数)*/
		public function executeWith(data:Array):void {
			if (data == null) {
				return execute();
			}
			if (method != null) {
				method.apply(null, args ? args.concat(data) : data);
			}
		}
	}
}