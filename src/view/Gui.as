package view
{
	import com.bit101.components.Style;
	import flash.display.Sprite;
	import core.AppEventBus;
	import events.CanvasEvent;
	import core.AppModel;
	import ui.StyleSizer;
	import events.StageEvent;
	import data.Constants;

	public class Gui extends GuiBase
	{
		private var _navbar:GuiNavbar;
		private var _brushPanel:GuiBrushPanel;

		public function Gui()
		{
			super();
		}

		override protected function onAddedToStage():void
		{
			AppEventBus.instance.addEventListener(StageEvent.STAGE_SIZE_CHANGED, onStageSizeChanged);
			AppEventBus.instance.addEventListener(CanvasEvent.TOUCH_START, onDrawStarted);
			AppEventBus.instance.addEventListener(CanvasEvent.TOUCH_END, onDrawEnded);
			AppEventBus.instance.addEventListener(StageEvent.UI_SCALE_CHANGED, onUiScaleChanged);

			// init creation - not really needed,since will be called on resize anyway?
			onStageSizeChanged(null); 
		}

		override protected function onRemovedFromStage():void
		{
			AppEventBus.instance.removeEventListener(StageEvent.STAGE_SIZE_CHANGED, onStageSizeChanged);
			AppEventBus.instance.removeEventListener(CanvasEvent.TOUCH_START, onDrawStarted);
			AppEventBus.instance.removeEventListener(CanvasEvent.TOUCH_END, onDrawEnded);
			AppEventBus.instance.removeEventListener(StageEvent.UI_SCALE_CHANGED, onUiScaleChanged);
		}

		override protected function onInit():void
		{
			createContainers();
		}

		private function onUiScaleChanged(e:StageEvent):void
		{
			createContainers();
		}

		private function createContainers():void
		{
			// Clean up old containers - consider making a container class to manage this better...
			if (_navbar && _navbar.parent)
				_navbar.parent.removeChild(_navbar);
			if (_brushPanel && _brushPanel.parent)
				_brushPanel.parent.removeChild(_brushPanel);

			_navbar = null;
			_brushPanel = null;

			// TODO: Pass in to gui/views, or let then ref it?
			Style.setStyle(Style.DARK);
			StyleSizer.ComponentScale(AppModel.instance.uiScale);

			_navbar = new GuiNavbar();
			addChild(_navbar);

			_brushPanel = new GuiBrushPanel();
			addChild(_brushPanel);
		}

		private function onStageSizeChanged(e:StageEvent):void
		{
			// -- Prepare layout...
			var width:Number = AppModel.instance.stageSize.x;
			var height:Number = AppModel.instance.stageSize.y;

			//-- Cap width to 768?
			width = Math.min(width, Constants.UI_MAX_WIDTH);
			var xpos:int = (AppModel.instance.stageSize.x - width) / 2; // center horizontally...
			var gridSize:int = width / 32; // Figure out good grid size...

			var navbarHeight:Number = AppModel.instance.uiScale * Constants.UI_MAGIC_SIZE_NUMBER + (gridSize * 2);

			var navBarY:Number = AppModel.instance.stageSize.y - navbarHeight;
			var panelHeight:Number = AppModel.instance.stageSize.y - navbarHeight;

			//TODO: Positioning centered on larger screens like tablet landscape etc...?
			_navbar.layout(width, navbarHeight, gridSize);
			_navbar.x = xpos;
			_navbar.y = navBarY;

			_brushPanel.layout(width, height - navbarHeight, gridSize);
			_brushPanel.x = xpos;
			_brushPanel.y = 0; //TODO: Consider hugged towards navbar at bottom...?
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
