package view
{
	import core.AppEventBus;
	import events.UIEvent;

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
			AppEventBus.instance.addEventListener(UIEvent.SHOW_BRUSH_SETTINGS, onShowSettings);
			AppEventBus.instance.addEventListener(UIEvent.SHOW_CANVAS_SETTINGS, onShowSettings);
			AppEventBus.instance.addEventListener(UIEvent.SHOW_APP_SETTINGS, onShowSettings);
			AppEventBus.instance.addEventListener(UIEvent.HIDE_ACTIVE, onRemoveActive);
		}

		override protected function onRemovedFromStage():void
		{
			AppEventBus.instance.removeEventListener(UIEvent.SHOW_BRUSH_SETTINGS, onShowSettings);
			AppEventBus.instance.removeEventListener(UIEvent.SHOW_CANVAS_SETTINGS, onShowSettings);
			AppEventBus.instance.removeEventListener(UIEvent.SHOW_APP_SETTINGS, onShowSettings);
			AppEventBus.instance.removeEventListener(UIEvent.HIDE_ACTIVE, onRemoveActive);
		}

		private function onShowSettings(e:UIEvent):void
		{
			trace("GuiContainer::onShowSettings");

			removeActiveGui();

			_activeGui = new GuiBrushSettings();

			switch(e.type)
			{
				case UIEvent.SHOW_CANVAS_SETTINGS:
					_activeGui = new GuiCanvasSettings();
					break;
				case UIEvent.SHOW_APP_SETTINGS:
					_activeGui = new GuiAppSettings();
					break;
			}

			addChild(_activeGui);
			ILayout(_activeGui).layout(_lastWidth, _lastHeight, _lastGridSize); //-- Layout directly...
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