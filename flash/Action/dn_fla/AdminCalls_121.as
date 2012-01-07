﻿package dn_fla
{
    import fl.controls.*;
    import flash.display.*;
    import flash.events.*;

    dynamic public class AdminCalls_121 extends MovieClip
    {
        public var calls_mc:List;
        public var top_mc:MovieClip;
        public var num_calls_txt:Label;
        public var minimize_btn:SimpleButton;
        public var calls:Object;
        public var remember_position:Boolean;

        public function AdminCalls_121()
        {
            addFrameScript(0, this.frame1);
            this.__setProp_num_calls_txt_AdminCalls_count_0();
            return;
        }// end function

        public function addCall(param1:String, param2:Array)
        {
            var _loc_3:Object = {label:param2[1], data:param1};
            this.calls_mc.addItem(_loc_3);
            this.calls[param1] = _loc_3;
            this.num_calls_txt.text = "Calls: " + this.calls_mc.length;
            return;
        }// end function

        public function removeCall(param1:String)
        {
            var _loc_2:* = this.calls[param1];
            this.calls[param1] = undefined;
            this.calls_mc.removeItem(_loc_2);
            this.num_calls_txt.text = "Calls: " + this.calls_mc.length;
            return;
        }// end function

        public function startDragE(event:MouseEvent)
        {
            this.remember_position = true;
            startDrag();
            return;
        }// end function

        public function dropE(event:MouseEvent)
        {
            stopDrag();
            return;
        }// end function

        function __setProp_num_calls_txt_AdminCalls_count_0()
        {
            try
            {
                this.num_calls_txt["componentInspectorSetting"] = true;
            }
            catch (e:Error)
            {
            }
            this.num_calls_txt.autoSize = "none";
            this.num_calls_txt.condenseWhite = false;
            this.num_calls_txt.enabled = true;
            this.num_calls_txt.htmlText = "";
            this.num_calls_txt.selectable = false;
            this.num_calls_txt.text = "Calls: 0";
            this.num_calls_txt.visible = true;
            this.num_calls_txt.wordWrap = false;
            try
            {
                this.num_calls_txt["componentInspectorSetting"] = false;
            }
            catch (e:Error)
            {
            }
            return;
        }// end function

        function frame1()
        {
            visible = false;
            this.calls = new Object();
            this.remember_position = false;
            this.top_mc.addEventListener(MouseEvent.MOUSE_DOWN, this.startDragE);
            this.top_mc.addEventListener(MouseEvent.MOUSE_UP, this.dropE);
            return;
        }// end function

    }
}