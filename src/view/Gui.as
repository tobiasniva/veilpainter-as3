package view
{
	import com.bit101.components.Style;
	import core.AppEventBus;
	import events.CanvasEvent;
	import core.AppModel;
	import ui.StyleSizer;
	import events.StageEvent;
	import data.Constants;

	public class Gui extends GuiBase implements ILayout
	{
		private var _navbar:GuiNavbar;
		private var _brushSettings:GuiBrushSettings;

		public function Gui()
		{
			super();
		}

		override protected function onAddedToStage():void
		{
			AppEventBus.instance.addEventListener(StageEvent.STAGE_SIZE_CHANGED, onStageSizeChanged);
			AppEventBus.instance.addEventListener(StageEvent.UI_SCALE_CHANGED, onUiScaleChanged);
			AppEventBus.instance.addEventListener(CanvasEvent.TOUCH_START, onDrawStarted);
			AppEventBus.instance.addEventListener(CanvasEvent.TOUCH_END, onDrawEnded);
		}

		override protected function onRemovedFromStage():void
		{
			AppEventBus.instance.removeEventListener(StageEvent.STAGE_SIZE_CHANGED, onStageSizeChanged);
			AppEventBus.instance.removeEventListener(StageEvent.UI_SCALE_CHANGED, onUiScaleChanged);
			AppEventBus.instance.removeEventListener(CanvasEvent.TOUCH_START, onDrawStarted);
			AppEventBus.instance.removeEventListener(CanvasEvent.TOUCH_END, onDrawEnded);
		}

		override protected function onInit():void
		{
			trace("Gui::onInit");
			createContainers();
		}

		private function onUiScaleChanged(e:StageEvent):void
		{
			trace("Gui::onUiScaleChanged");
			createContainers();
			onStageSizeChanged();
		}

		private function onStageSizeChanged(e:StageEvent = null):void
		{
			trace("Gui::onStageSizeChanged: " + AppModel.instance.stageSize);

			var width:Number = AppModel.instance.stageSize.x;
			width = Math.min(width, Constants.UI_MAX_WIDTH); // We cap gui-container widths...

			var height:Number = AppModel.instance.stageSize.y;
			var gridSize:int = width / 24; // Figure out good grid size...

			layout(width, height, gridSize);
		}

		public function layout(width:int, height:int, gridSize:int):void
		{
			trace("Gui::layout: w=" + width + " h=" + height + " gridSize=" + gridSize);

			// TODO: Figure out if we want left/center/right alignment configurable...
			// var xpos:int = 0; // left align...
			var xpos:int = (AppModel.instance.stageSize.x - width) / 2; // center...
			// var xpos:int = AppModel.instance.stageSize.x - width; // right align...

			var navbarHeight:Number = _navbar.btnSize + (gridSize * 2);

			var navBarY:Number = AppModel.instance.stageSize.y - navbarHeight;
			var panelHeight:Number = AppModel.instance.stageSize.y - navbarHeight;

			// TODO: Positioning - left/center/right, but always bottom?
			_navbar.layout(width, navbarHeight, gridSize);
			_navbar.x = xpos;
			_navbar.y = navBarY;

			// TODO: Positioning - left/center/right, top/bottom? (bottom huggging navbar...)
			_brushSettings.layout(width, height - navbarHeight, gridSize);
			_brushSettings.x = xpos;
			_brushSettings.y = 0;
		}

		private function createContainers():void
		{
			trace("Gui::createContainers");

			// Clean up old containers - consider making a container class to manage this better...
			if (_navbar && _navbar.parent)
				_navbar.parent.removeChild(_navbar);
			if (_brushSettings && _brushSettings.parent)
				_brushSettings.parent.removeChild(_brushSettings);

			_navbar = null;
			_brushSettings = null;

			Style.setStyle(Style.DARK);
			StyleSizer.ComponentScale(AppModel.instance.uiScale);

			_navbar = new GuiNavbar();
			addChild(_navbar);

			_brushSettings = new GuiBrushSettings();
			addChild(_brushSettings);
		}

		// --- Handlers...
		private function onDrawStarted(e:CanvasEvent):void
		{
			if (AppModel.instance.uiHideOnDraw)
				this.visible = false;
		}

		private function onDrawEnded(e:CanvasEvent):void
		{
			// TODO: Implement delay until ui shows again? config/setting in model?
			this.visible = true;
		}
	}
}