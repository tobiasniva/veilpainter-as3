package view
{
	import core.AppEventBus;
	import events.CanvasEvent;
	import core.AppModel;
	import events.StageEvent;
	import data.Constants;
	import ui.StyleSizer;
	import data.AlignHorizontal;

	public class Gui extends GuiBase implements ILayout
	{
		private var _navbar:GuiNavbar;
		private var _container:GuiContainer;

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
			createContainers();
		}

		private function onUiScaleChanged(e:StageEvent):void
		{
			createContainers();
			onStageSizeChanged();
		}

		private function onStageSizeChanged(e:StageEvent = null):void
		{
			var width:Number = AppModel.instance.stageSize.x;
			width = Math.min(width, Constants.UI_MAX_WIDTH); // We cap gui-container widths...

			var height:Number = AppModel.instance.stageSize.y;
			var gridSize:int = width / 24; // Figure out good grid size...

			layout(width, height, gridSize);
		}

		public function layout(width:int, height:int, gridSize:int):void
		{
			var xpos:int = alignedX(AppModel.instance.stageSize.x, width, AppModel.instance.uiAlignH);
			var navbarHeight:Number = _navbar.btnSize + (gridSize * 2);
			var navBarY:Number = AppModel.instance.stageSize.y - navbarHeight;

			_navbar.layout(width, navbarHeight, gridSize);
			_navbar.x = xpos;
			_navbar.y = navBarY;

			_container.layout(width, height - navbarHeight, gridSize);
			_container.x = xpos;
			_container.y = 0;
		}

		private function alignedX(stageW:int, blockW:int, alignH:int):int
		{
			switch (alignH)
			{
				case AlignHorizontal.LEFT:
					return 0;
				case AlignHorizontal.RIGHT:
					return stageW - blockW;
				case AlignHorizontal.CENTER:
				default:
					return (stageW - blockW) / 2;
			}
		}

		private function createContainers():void
		{
			// Clean up old containers...
			if (_navbar && _navbar.parent)
				_navbar.parent.removeChild(_navbar);
			if (_container && _container.parent)
				_container.parent.removeChild(_container);

			_navbar = null;
			_container = null;

			StyleSizer.ComponentScale(AppModel.instance.uiScale);

			_navbar = new GuiNavbar();
			addChild(_navbar);

			_container = new GuiContainer();
			addChild(_container);
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