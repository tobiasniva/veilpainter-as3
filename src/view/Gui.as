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

	public class Gui extends Sprite
	{
		private var _navbar:Sprite;
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
		}

		private function onRemovedFromStage(e:Event):void
		{
			removeEventListener(Event.REMOVED_FROM_STAGE, onRemovedFromStage);
			AppEventBus.instance.removeEventListener(StageEvent.STAGE_SIZE_CHANGED, onStageSizeChanged);
			AppEventBus.instance.removeEventListener(CanvasEvent.TOUCH_START, onDrawStarted);
			AppEventBus.instance.removeEventListener(CanvasEvent.TOUCH_END, onDrawEnded);
		}

		private function onStageSizeChanged(e:StageEvent):void
		{
			//TODO: Pass in to gui/views, or let then ref it?
			Style.setStyle(Style.DARK);
			StyleSizer.ComponentScale(AppModel.instance.uiScale);
			positionContainers();
		}

		private function createContainers():void
		{
			_navbar = new Sprite();
			_navbar.mouseEnabled = false;
			addChild(_navbar);

			_panel = new Sprite();
			_panel.mouseEnabled = false;
			addChild(_panel);
		}

		private function positionContainers():void
		{
			var navbarHeight:Number = AppModel.instance.uiScale * 30; // 30 - height px of button 
			var screenWidth:Number = AppModel.instance.stageSize.x;
			var navBarY:Number = AppModel.instance.stageSize.y - navbarHeight;
			var panelHeight:Number = AppModel.instance.stageSize.y - navbarHeight;

			//TODO: Temp for visualization
			_navbar.graphics.clear();
			_navbar.graphics.lineStyle(1, 0xff0000);
			_navbar.graphics.beginFill(0xff0000, 0.1);
			_navbar.graphics.drawRect(0, 0, screenWidth - 1, navbarHeight - 1);
			_navbar.graphics.endFill();

			_panel.graphics.clear();
			_panel.graphics.lineStyle(1, 0x00ff00);
			_panel.graphics.beginFill(0x00ff00, 0.1);
			_panel.graphics.drawRect(0, 0, screenWidth - 1, panelHeight - 1);
			_panel.graphics.endFill();
			//--

			_navbar.x = 0;
			_navbar.y = navBarY;
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
