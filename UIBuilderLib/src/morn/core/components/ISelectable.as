/**
 * Version 0.9.9 https://github.com/yungzhu/morn
 * Feedback yungzhu@gmail.com http://weibo.com/newyung
 * Copyright 2012, yungzhu. All rights reserved.
 * This program is free software. You can redistribute and/or modify it
 * in accordance with the terms of the accompanying license agreement.
 */
package morn.core.components {
	import morn.core.handlers.Handler;
	
	public interface ISelectable {
		function get selected():Boolean;
		function set selected(value:Boolean):void;
		function get clickHandler():Handler;
		function set clickHandler(value:Handler):void;
	}
}