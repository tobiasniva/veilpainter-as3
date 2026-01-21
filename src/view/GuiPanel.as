package view
{
    import flash.display.Sprite;

    public class GuiPanel extends Sprite
    {
        private var _bgColor:uint = 0x808080;

        private var _debugLine:uint = 0xff00ff;
        private var _debugFill:uint = 0xff00ff;
        private var _debugAlpha:Number = 0.0;

        public function GuiPanel()
        {
            mouseEnabled = false;
            mouseChildren = false;
            visible = false; // default hidden until first draw
        }

        // --- Normal panel (background)
        public function draw(w:int, h:int, alpha:Number = 0.5):void
        {
            visible = true;

            graphics.clear();
            graphics.beginFill(_bgColor, alpha);
            graphics.drawRect(0, 0, w, h);
            graphics.endFill();
        }

        // --- Debug outline panel (bounds)
        public function drawDebug(w:int, h:int):void
        {
            visible = true;

            graphics.clear();
            graphics.lineStyle(0, _debugLine);
            graphics.beginFill(_debugFill, _debugAlpha);
            graphics.drawRect(0, 0, w, h);
            graphics.endFill();
        }

        // --- Convenience: draw debug bounds only if enabled, otherwise clear.
        //     This keeps navbar code as simple as: _panel.renderDebugOnly(AppModel.instance.debugBounds, w, h);
        public function renderDebugOnly(enabled:Boolean, w:int, h:int):void
        {
            if (enabled) drawDebug(w, h);
            else clear();
        }

        // --- Clear / hide
        public function clear():void
        {
            graphics.clear();
            visible = false;
        }
    }
}
