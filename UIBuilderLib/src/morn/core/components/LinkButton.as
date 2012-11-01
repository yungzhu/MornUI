/**
 * Version 0.9.9 https://github.com/yungzhu/morn
 * Feedback yungzhu@gmail.com http://weibo.com/newyung
 * Copyright 2012, yungzhu. All rights reserved.
 * This program is free software. You can redistribute and/or modify it
 * in accordance with the terms of the accompanying license agreement.
 */
package morn.core.components {
	
	/**文本按钮*/
	public class LinkButton extends Button {
		
		public function LinkButton(label:String = "") {
			super(null, label);
		}
		
		override protected function preinitialize():void {
			super.preinitialize();
			_labelColors = Styles.linkLabelColors;
			buttonMode = true;
		}
		
		override protected function initialize():void {
			super.initialize();
			_btnLabel.underline = true;
			_btnLabel.autoSize = "left";
		}
		
		override protected function changeLabelSize():void {
		
		}
	}
}