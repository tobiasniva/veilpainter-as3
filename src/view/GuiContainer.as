package view
{
    import core.AppEventBus;
    import core.AppModel;
    import data.SettingsViewActive;
    import events.UIEvent;
    import data.AlignVertical;

    public class GuiContainer extends GuiBase implements ILayout
    {
        private var _activeGui:GuiBase;
        private var _w:int = 0;
        private var _h:int = 0;
        private var _grid:int = 0;
        private var _hasLayout:Boolean = false;

        public function GuiContainer()
        {
            super();
        }

        override protected function onAddedToStage():void
        {
            AppEventBus.instance.addEventListener(UIEvent.SELECTED_SETTINGS_INDEX_CHANGED, onActiveViewChanged);
            setActiveView(AppModel.instance.uiActiveSettingView);
        }

        override protected function onRemovedFromStage():void
        {
            AppEventBus.instance.removeEventListener(UIEvent.SELECTED_SETTINGS_INDEX_CHANGED, onActiveViewChanged);
        }

        private function onActiveViewChanged(e:UIEvent):void
        {
            setActiveView(AppModel.instance.uiActiveSettingView);
        }

        private function setActiveView(viewId:int):void
        {
            var next:GuiBase = createView(viewId);

            // -- If later decide to cache...?
            if (next === _activeGui)
                return;

            swapActive(next);
            applyLayoutIfPossible();
        }

        private function createView(viewId:int):GuiBase
        {
            switch (viewId)
            {
                case SettingsViewActive.BRUSH:
                    return new GuiBrushSettings();
                case SettingsViewActive.CANVAS:
                    return new GuiCanvasSettings();
                case SettingsViewActive.APP:
                    return new GuiAppSettings();
                case SettingsViewActive.NONE:
                default:
                    return null;
            }
        }

        private function swapActive(next:GuiBase):void
        {
            if (_activeGui && contains(_activeGui))
                removeChild(_activeGui);

            _activeGui = next;

            if (_activeGui)
                addChild(_activeGui);
        }

        public function layout(w:int, h:int, gridSize:int):void
        {
            _w = w;
            _h = h;
            _grid = gridSize;
            _hasLayout = true;

            applyLayoutIfPossible();
        }

        private function applyLayoutIfPossible():void
        {
            if (!_hasLayout)
                return;
            if (!_activeGui)
                return;

            if (_activeGui is ILayout)
                ILayout(_activeGui).layout(_w, _h, _grid);

            // After layout, view has height - align vertically...
            var guiH:int = int(_activeGui.height);

            _activeGui.y = (AppModel.instance.uiAlignV == AlignVertical.TOP) ? 0 : (_h - guiH);
            trace("GuiContainer height _h: " + _h);
            trace("height of view to add: " + guiH);
        }
    }
}
