/**
 * Version 0.9.2 https://github.com/yungzhu/morn
 * Feedback yungzhu@gmail.com http://weibo.com/newyung
 * Copyright 2012, yungzhu. All rights reserved.
 * This program is free software. You can redistribute and/or modify it
 * in accordance with the terms of the accompanying license agreement.
 */
package morn.core.components {
	
	/**
	 * 对话框
	 */
	public class Dialog extends View {
		
		/**显示对话框(会关闭已经打开的非模式窗口)*/
		public function show():void {
			App.dialog.show(this);
		}
		
		/**显示对话框*/
		public function popup():void {
			App.dialog.popup(this);
		}
		
		/**关闭对话框*/
		public function close():void {
			App.dialog.remove(this);
		}
	}
}