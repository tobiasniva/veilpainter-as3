package view
{
	import core.AppEventBus;
	import events.UIEvent;
	import core.AppModel;
	import data.SettingsViewActive;

	public class GuiContainer extends GuiBase implements ILayout
	{
		private var _activeGui:GuiBase;
		private var _lastWidth:int;
		private var _lastHeight:int;
		private var _lastGridSize:int;

		public function GuiContainer()
		{
			super();
		}

		override protected function onAddedToStage():void
		{
			AppEventBus.instance.addEventListener(UIEvent.SELECTED_SETTINGS_INDEX_CHANGED, onShowSettings);
		}

		override protected function onRemovedFromStage():void
		{
			AppEventBus.instance.removeEventListener(UIEvent.SELECTED_SETTINGS_INDEX_CHANGED, onShowSettings);
		}

		private function onShowSettings(e:UIEvent):void
		{
			trace("GuiContainer::onShowSettings");

			removeActiveGui();

			_activeGui = null;

			switch(AppModel.instance.uiActiveSettingView)
			{
				case SettingsViewActive.BRUSH:
					_activeGui = new GuiBrushSettings();
					break;
				case SettingsViewActive.CANVAS:
					_activeGui = new GuiCanvasSettings();
					break;
				case SettingsViewActive.APP:
					_activeGui = new GuiAppSettings();
					break;
				case SettingsViewActive.NONE:
					_activeGui = null;
					break;
			}

			if(_activeGui != null)
			{
				addChild(_activeGui);
				ILayout(_activeGui).layout(_lastWidth, _lastHeight, _lastGridSize); //-- Layout directly...
			}
		}

		private function onRemoveActive(event:Object):void
		{
			trace("GuiContainer::onRemoveActive");
			removeActiveGui();
		}

		public function layout(w:int, h:int, gridSize:int):void
		{
			trace("GuiContainer::layout: w=" + width + " h=" + height + " gridSize=" + gridSize);

			// if (AppModel.instance.debugBounds)
			// 	BoundsFactory.drawBounds(this, w, h, 0xff00ff, 0.0);

			// -- Update local values, needed for when showing/layouting a gui "later"...
			_lastWidth = w;
			_lastHeight = h;
			_lastGridSize = gridSize;

			if (_activeGui != null && "layout" in _activeGui)
			{
				ILayout(_activeGui).layout(w, h, gridSize);
			}
		}

		private function removeActiveGui():void
		{
			if (_activeGui != null)
			{
				if (contains(_activeGui))
					removeChild(_activeGui);
				_activeGui = null;
			}
		}
	}
}