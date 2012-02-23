﻿package dn_fla
{
    import fl.controls.*;
    import flash.display.*;
    import flash.events.*;

    dynamic public class AdminCalls_121 extends MovieClip
    {
        public var calls_mc:List;
        public var calls_btn:SimpleButton;
        public var tools_mc:MovieClip;
        public var tools_selected_mc:MovieClip;
        public var top_mc:MovieClip;
        public var num_calls_txt:Label;
        public var tools_btn:SimpleButton;
        public var minimize_btn:SimpleButton;
        public var calls_selected_mc:MovieClip;
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
            delete this.calls[param1];
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

        public function showCallsE(event:MouseEvent)
        {
            this.calls_btn.visible = false;
            this.calls_selected_mc.visible = true;
            this.tools_btn.visible = true;
            this.tools_selected_mc.visible = false;
            this.calls_mc.visible = true;
            this.tools_mc.visible = false;
            return;
        }// end function

        public function showToolsE(event:MouseEvent)
        {
            this.calls_btn.visible = true;
            this.calls_selected_mc.visible = false;
            this.tools_btn.visible = false;
            this.tools_selected_mc.visible = true;
            this.calls_mc.visible = false;
            this.tools_mc.visible = true;
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
            this.showCallsE(null);
            this.calls_btn.addEventListener(MouseEvent.CLICK, this.showCallsE);
            this.tools_btn.addEventListener(MouseEvent.CLICK, this.showToolsE);
            return;
        }// end function

    }
}
