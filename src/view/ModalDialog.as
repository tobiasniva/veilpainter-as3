package view
{
    import com.bit101.components.Label;
    import com.bit101.components.PushButton;
    import com.bit101.components.Window;

    import flash.display.DisplayObjectContainer;
    import flash.display.Sprite;
    import flash.events.Event;
    import flash.events.MouseEvent;
    import flash.text.TextFieldAutoSize;

    /**
     * Minimal modal dialog built with com.bit101.components.
     * - Blocks interaction behind it (scrim).
     * - Centers itself and recenters on stage resize.
     */
    public final class ModalDialog
    {
        private var _parent:DisplayObjectContainer;
        private var _scrim:Sprite;
        private var _win:Window;
        private var _ok:PushButton;

        public function ModalDialog(parent:DisplayObjectContainer)
        {
            _parent = parent;
        }

        public function show(title:String, message:String, okText:String = "OK", onOk:Function = null):void
        {
            if (_scrim != null) return; // already showing

            // Scrim blocks clicks behind dialog.
            _scrim = new Sprite();
            _scrim.graphics.beginFill(0x000000, 0.55);
            _scrim.graphics.drawRect(0, 0, 10, 10);
            _scrim.graphics.endFill();
            _scrim.addEventListener(MouseEvent.MOUSE_DOWN, swallow, true);
            _scrim.addEventListener(MouseEvent.MOUSE_UP, swallow, true);
            _scrim.addEventListener(MouseEvent.CLICK, swallow, true);

            _parent.addChild(_scrim);

            _win = new Window(_parent, 0, 0, title);
            _win.draggable = false;
            _win.hasCloseButton = false;

            var lbl:Label = new Label(_win.content, 10, 10, message);
            // Make the label wrap by using its internal textField.
            lbl.textField.multiline = true;
            lbl.textField.wordWrap = true;
            lbl.textField.autoSize = TextFieldAutoSize.LEFT;

            // Choose a fixed dialog width that works on phone/tablet.
            const dialogW:Number = 520;
            lbl.width = dialogW - 20;

            // Measure text height after width is set.
            var textH:Number = Math.max(60, lbl.textField.textHeight + 10);
            lbl.height = textH;

            _ok = new PushButton(_win.content, 0, 0, okText, function(_:Event):void
            {
                hide();
                if (onOk != null) onOk();
            });

            // Layout.
            _ok.width = 120;
            _ok.x = dialogW - _ok.width - 10;
            _ok.y = 10 + lbl.height + 12;

            _win.setSize(dialogW, _ok.y + _ok.height + 12);

            // Size/position.
            resizeToStage();
            if (_parent.stage) _parent.stage.addEventListener(Event.RESIZE, onStageResize);
        }

        public function hide():void
        {
            if (_parent && _scrim && _parent.contains(_scrim)) _parent.removeChild(_scrim);
            if (_parent && _win && _parent.contains(_win)) _parent.removeChild(_win);

            if (_parent && _parent.stage) _parent.stage.removeEventListener(Event.RESIZE, onStageResize);

            if (_scrim)
            {
                _scrim.removeEventListener(MouseEvent.MOUSE_DOWN, swallow, true);
                _scrim.removeEventListener(MouseEvent.MOUSE_UP, swallow, true);
                _scrim.removeEventListener(MouseEvent.CLICK, swallow, true);
            }

            _scrim = null;
            _win = null;
            _ok = null;
        }

        private function onStageResize(e:Event):void
        {
            resizeToStage();
        }

        private function resizeToStage():void
        {
            if (!_parent.stage || !_scrim || !_win) return;

            var sw:Number = _parent.stage.stageWidth;
            var sh:Number = _parent.stage.stageHeight;

            // Resize scrim to full stage.
            _scrim.width = sw;
            _scrim.height = sh;

            // Center window.
            _win.x = Math.max(10, (sw - _win.width) * 0.5);
            _win.y = Math.max(10, (sh - _win.height) * 0.5);
        }

        private function swallow(e:MouseEvent):void
        {
            e.stopImmediatePropagation();
        }
    }
}
