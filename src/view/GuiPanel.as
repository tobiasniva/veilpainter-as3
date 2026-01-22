package view
{
    import flash.display.Sprite;
    import data.Constants;

    public class GuiPanel extends Sprite
    {
        private var _bgColor:uint = Constants.UI_PANEL_COLOR;

        private var _debugColor:uint = 0xff00ff;
        private var _debugAlpha:Number = 0.0;

        public function GuiPanel()
        {
            mouseEnabled = false;
            mouseChildren = false;
            visible = false; // default hidden until first draw
        }

        // --- Normal panel (background)
        public function draw(w:int, h:int, alpha:Number = Constants.UI_PANEL_ALPHA):void
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
            graphics.lineStyle(0, _debugColor);
            graphics.beginFill(_debugColor, _debugAlpha);
            graphics.drawRect(0, 0, w, h);
            graphics.endFill();
        }

        // --- Convenience: draw debug bounds only if enabled, otherwise clear.
        // This keeps navbar code as simple as: _panel.renderDebugOnly(AppModel.instance.debugBounds, w, h);
        public function renderDebugOnly(enabled:Boolean, w:int, h:int):void
        {
            if (enabled)
                drawDebug(w, h);
            else
                clear();
        }

        // --- Clear / hide
        public function clear():void
        {
            graphics.clear();
            visible = false;
        }
    }
}
