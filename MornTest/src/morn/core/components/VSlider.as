/**
 * Version 0.9.0 https://github.com/yungzhu/morn
 * Feedback yungzhu@gmail.com http://weibo.com/newyung
 * Copyright 2012, yungzhu. All rights reserved.
 * This program is free software. You can redistribute and/or modify it
 * in accordance with the terms of the accompanying license agreement.
 */
package morn.core.components {
	
	/**垂直滑动条*/
	public class VSlider extends Slider {
		
		public function VSlider(skin:String = null) {
			super(skin);
		}
		
		override protected function preinitialize():void {
			super.preinitialize();
			direction = VERTICAL;
		}
	}
}