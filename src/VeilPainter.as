package
{
	import behavior.Brush;
	import data.AlphaImages;
	import data.Strings;
	import events.ViewportChangedEvent;
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageDisplayState;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import ui.StyleSizer
	import utils.UiScaleUtil
	import view.Gui;
	import view.layout.*;
	import view.viewport.*;
	import core.AppEventBus;
	import events.CanvasEvent;
	import core.AppModel;
	import view.Canvas;

	[SWF(backgroundColor="#000000", frameRate="60", width="1024", height="768")]
	public class VeilPainter extends Sprite
	{
		// private var _bmpDataUsedBySaveToBeRemoved:BitmapData;
		private var _canvas:Canvas;
		private var _brush:Brush;
		private var _uiRoot:Sprite;
		private var _gui:Gui;
		private var _layoutManager:LayoutManager;

		public function VeilPainter()
		{
			super();
			if (stage) onAddedToStage();
			else addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}

		private function onAddedToStage(e:Event = null):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			stage.displayState = StageDisplayState.FULL_SCREEN_INTERACTIVE;
			stage.addEventListener(Event.RESIZE, init);
			init();
		}

		private function init(e:Event = null):void
		{
			stage.removeEventListener(Event.RESIZE, init);

			// Model inits - TODO: Implement prefs...
			AppModel.instance.stageSize = new Point(stage.stageWidth, stage.stageHeight);

			//-- Create canvas...
			_canvas = new Canvas();
			addChild(_canvas);

			//-- Create brush
			var initAlphaImage:Bitmap = AlphaImages.getAll()[0].bitmap;
			_brush = new Brush(initAlphaImage);
			addChild(_brush); // above canvas
			
			//-- GUI
			var uiScale:int = UiScaleUtil.computeUiScale();
			StyleSizer.ComponentScale(uiScale);
			_gui = new Gui(this);
			addChild(_gui); // above brush

			//-- Layout Manager - NEEDS GUI!
			_layoutManager = new LayoutManager(_gui, uiScale);
			_layoutManager.registerLayout(Strings.PHONE_PORTRAIT, new PhonePortraitLayout());
			_layoutManager.registerLayout(Strings.PHONE_LANDSCAPE, new PhoneLandscapeLayout());
			_layoutManager.refresh(true);

			//-- Viewport resize listener - RELIES ON GUI BEING INITIALIZED!
			var viewportService:ViewportService = new ViewportService(stage);
			viewportService.addEventListener(ViewportChangedEvent.VIEWPORT_CHANGED, onViewportChanged);
			viewportService.start();

			//-- Mouse/touch to detect input for toggle stuff (e.g. drawing)
			stage.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
			stage.addEventListener(MouseEvent.MOUSE_UP, onMouseDown);
		}

		private function onViewportChanged(e:ViewportChangedEvent):void
		{
			AppModel.instance.stageSize = new Point(e.screenW, e.screenH);
			_layoutManager.refresh(true);
			
			//TODO: Consider transfer bitmap between portrait/landscape changes...
			AppEventBus.instance.dispatchEvent(new CanvasEvent(CanvasEvent.SETTINGS_CHANGED));
		}

		//-- TODO: Figure out where/who should own this....?
		private function onMouseDown(e:MouseEvent):void
		{
			if (e.type == MouseEvent.MOUSE_DOWN && e.target == stage)
			{
				AppEventBus.instance.dispatchEvent(new CanvasEvent(CanvasEvent.TOUCH_START));
			}
			else
			{
				AppEventBus.instance.dispatchEvent(new CanvasEvent(CanvasEvent.TOUCH_END));
			}
		}


		//-- TODO: Move to own class...
		/*
		public function saveImage():void
		{
			trace("perm status: " + File.permissionStatus);
			
			var byteArray:ByteArray = PNGEncoder.encode(_bmpDataUsedBySaveToBeRemoved);
			
			var d:Date = new Date();
			var dtf:DateTimeFormatter = new DateTimeFormatter("en-US");
			dtf.setDateTimePattern("yyyyMMdd_HHmmss");
			var imgName:String = "veil_" + dtf.format(d) + ".png";

			var parent:DisplayObjectContainer = this as DisplayObjectContainer;
			SaveImageWithDialog.savePNG(
				byteArray,
				imgName,
				function():void { trace("Saved: " + imgName); },
				function():void { trace("User canceled"); },
				function(err:String):void
				{
					trace("Save failed: " + err);
					//TODO: implemtent popup with hint that saving to downloads folder might work
				}
			);
		}
		*/
	}
}
