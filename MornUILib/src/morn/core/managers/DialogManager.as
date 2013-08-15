/**
 * Morn UI Version 2.1.0623 http://code.google.com/p/morn https://github.com/yungzhu/morn
 * Feedback yungzhu@gmail.com http://weibo.com/newyung
 */
package morn.core.managers {
	import flash.display.Bitmap;
import flash.display.DisplayObject;
import flash.display.Sprite;
	import flash.events.Event;
import flash.utils.Dictionary;

import morn.core.components.Box;
	import morn.core.components.Dialog;
	import morn.core.utils.ObjectUtils;

	/**对话框管理器*/
    public class DialogManager extends Sprite {
        private var _box:Box = new Box();
        private var _maskBg:Sprite = new Sprite();
        //非模式窗口
        private var _show:Dictionary = new Dictionary(true);
        //模式窗口
        private var _popup:Dictionary = new Dictionary(true);

        public function DialogManager() {
            addChild(_box);
            _maskBg.addChild(ObjectUtils.createBitmap(10, 10, 0, 0.4));

            addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
        }

        private function onAddedToStage(e:Event):void {
            removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
            stage.addEventListener(Event.RESIZE, onResize);
            onResize(null);
        }

        private function onResize(e:Event):void {
            for (var i:int = _box.numChildren - 1; i > -1; i--) {
                var item:Dialog = _box.getChildAt(i) as Dialog;
                if (item && item.popupCenter) {
                    item.x = (stage.stageWidth - item.width) * 0.5;
                    item.y = (stage.stageHeight - item.height) * 0.5;
                }
            }

            var bitmap:Bitmap = _maskBg.getChildAt(0) as Bitmap;
            bitmap.width = stage.stageWidth;
            bitmap.height = stage.stageHeight;
        }

        /**删除某一类型(模式、非模式)的所有窗口*/
        private function removeDialogs(type:String):void {
            var dialogs:Dictionary = type == "show"?_show:_popup;
            for (var child:* in dialogs) {
                (child as Dialog).remove();
            }

            if(type == "show"){
                _show = new Dictionary(true);
            }else{
                _popup = new Dictionary(true);
                if(_box.contains(_maskBg))_box.removeChild(_maskBg);
            }
        }

        /**显示对话框(非模式窗口) @param closeOther 是否关闭其他对话框*/
        public function show(dialog:Dialog, closeOther:Boolean = false):void {
            if (closeOther) {
                removeDialogs("show")
            }

            _show[dialog] = true;

            if (dialog.popupCenter) {
                dialog.x = (stage.stageWidth - dialog.width) * 0.5;
                dialog.y = (stage.stageHeight - dialog.height) * 0.5;
            }
            _box.addChild(dialog);
        }

        /**显示对话框(模式窗口) @param closeOther 是否关闭其他对话框*/
        public function popup(dialog:Dialog, closeOther:Boolean = false):void {
            if (closeOther) {
                removeDialogs("popup");
            }

            _popup[dialog] = true;

            if (dialog.popupCenter) {
                dialog.x = (stage.stageWidth - dialog.width) * 0.5;
                dialog.y = (stage.stageHeight - dialog.height) * 0.5;
            }
            _box.addChild(_maskBg);
            _box.addChild(dialog);
        }

        /**删除对话框*/
        public function close(dialog:Dialog):void {
            dialog.remove();

            if(_popup[dialog]){
                delete _popup[dialog];

                var noPopups:Boolean = true;
                var i:int = _box.numChildren - 1;
                while(i>=0){
                    var child:DisplayObject = _box.getChildAt(i);
                    if((child is Dialog) && _popup[child]){
                        _box.setChildIndex(_maskBg, i);
                        noPopups = false;
                        break;
                    }else{
                        i--;
                    }
                }
                if(noPopups && _box.contains(_maskBg)){
                    _box.removeChild(_maskBg);
                }
            }else{
                delete _show[dialog];
            }
        }

        /**删除所有对话框*/
        public function closeAll():void {
            removeDialogs("show");
            removeDialogs("popup");
        }
    }
}