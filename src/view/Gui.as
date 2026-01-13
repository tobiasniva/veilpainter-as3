package view
{
	import com.bit101.components.Style;
	import flash.display.Sprite;
	import flash.events.Event;
	import core.AppEventBus;
	import events.CanvasEvent;
	import core.AppModel;
	import ui.StyleSizer;
	import events.StageEvent;
	import data.Constants;

	public class Gui extends Sprite
	{
		private var _navbar:GuiNavbar;
		private var _panel:Sprite;
		private var _stageWidth:int;
		private var _stageHeight:int;
		

		public function Gui()
		{
			super();
			this.mouseEnabled = false;
			if (stage)
				init();
			else
				addEventListener(Event.ADDED_TO_STAGE, init);

			createContainers();
		}

		private function init(e:Event = null):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			addEventListener(Event.REMOVED_FROM_STAGE, onRemovedFromStage);
			AppEventBus.instance.addEventListener(StageEvent.STAGE_SIZE_CHANGED, onStageSizeChanged);
			AppEventBus.instance.addEventListener(CanvasEvent.TOUCH_START, onDrawStarted);
			AppEventBus.instance.addEventListener(CanvasEvent.TOUCH_END, onDrawEnded);
			AppEventBus.instance.addEventListener(StageEvent.UI_SCALE_CHANGED, onUiScaleChanged);
		}

		private function onRemovedFromStage(e:Event):void
		{
			removeEventListener(Event.REMOVED_FROM_STAGE, onRemovedFromStage);
			AppEventBus.instance.removeEventListener(StageEvent.STAGE_SIZE_CHANGED, onStageSizeChanged);
			AppEventBus.instance.removeEventListener(CanvasEvent.TOUCH_START, onDrawStarted);
			AppEventBus.instance.removeEventListener(CanvasEvent.TOUCH_END, onDrawEnded);
			AppEventBus.instance.removeEventListener(StageEvent.UI_SCALE_CHANGED, onUiScaleChanged);
		}

		private function onUiScaleChanged(e:StageEvent):void
		{
			createContainers();
		}

		private function onStageSizeChanged(e:StageEvent):void
		{
			layout();
		}

		private function createContainers():void
		{
			//TODO: Clean up old containers...

			//TODO: Pass in to gui/views, or let then ref it?
			Style.setStyle(Style.DARK);
			StyleSizer.ComponentScale(AppModel.instance.uiScale);

			_navbar = new GuiNavbar();
			_navbar.mouseEnabled = false;
			addChild(_navbar);

			_panel = new Sprite();
			_panel.mouseEnabled = false;
			addChild(_panel);
		}

		private function layout():void
		{
			var padding:Number = Constants.UI_MAGIC_SIZE_NUMBER;
			var navbarHeight:Number = AppModel.instance.uiScale * padding + (padding * 2);

			var screenWidth:Number = AppModel.instance.stageSize.x;
			var navBarY:Number = AppModel.instance.stageSize.y - navbarHeight;
			var panelHeight:Number = AppModel.instance.stageSize.y - navbarHeight;

			_navbar.layout(screenWidth, navbarHeight, padding);
			_navbar.x = 0;
			_navbar.y = navBarY;

			//-- TEMP
			_panel.graphics.clear();
			_panel.graphics.lineStyle(1, 0x00ff00);
			_panel.graphics.beginFill(0x00ff00, 0.05);
			_panel.graphics.drawRect(0, 0, screenWidth - 1, panelHeight - 1);
			_panel.graphics.endFill();
			//--

			_panel.x = 0;
			_panel.y = 0;
		}

		// --- Handlers...
		private function onDrawStarted(e:CanvasEvent):void
		{
			if(AppModel.instance.uiHideOnDraw)
				this.visible = false;
		}

		private function onDrawEnded(e:CanvasEvent):void
		{
			//TODO: Implement delay until ui shows again? config/setting in model?
			this.visible = true;
		}
	}
}
