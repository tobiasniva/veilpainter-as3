package
{
	import behavior.Brush;
	import com.adobe.images.PNGEncoder;
	import core.BrushModel;
	import data.AlphaImages;
	import data.Constants;
	import data.Strings;
	import events.ViewportChangedEvent;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageDisplayState;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.filesystem.File
	import flash.geom.Point;
	import flash.globalization.DateTimeFormatter;
	import flash.utils.ByteArray;
	import ui.StyleSizer
	import utils.SaveImageWithDialog;
	import utils.UiScaleUtil
	import view.Gui;
	import view.layout.*;
	import view.viewport.*;
	import core.AppEventBus;
	import events.CanvasEvent;
	import core.AppModel;
	import core.CanvasModel;
	import view.Canvas;

	[SWF(backgroundColor="#000000", frameRate="60", width="1024", height="768")]
	public class VeilPainter extends Sprite
	{
		private var _canvas:Canvas;
		private var _brush:Brush;
		private var _bmp:Bitmap;
		private var _bmpData:BitmapData;
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

			//-- Create and add Canvas...
			_canvas = new Canvas();
			addChild(_canvas);

			//-- Init canvas
			// var bmpSize:Point = AppModel.instance.stageSize;
			// var canvasCol:uint = CanvasModel.instance.color;
			// _bmpData = new BitmapData(bmpSize.x, bmpSize.y, false, canvasCol);
			// _bmp = new Bitmap(_bmpData);
			// addChild(_bmp);

			//-- Create Brush
			var initAlphaImage:Bitmap = AlphaImages.getAll()[0].bitmap;
			_brush = new Brush(initAlphaImage); //TODO: Extract bmp/canvas ref from within brush...
			addChild(_brush); // Above bitmap
			
			//-- GUI
			var uiScale:int = UiScaleUtil.computeUiScale();
			StyleSizer.ComponentScale(uiScale);
			_gui = new Gui(this);
			addChild(_gui); // Above brush

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
			// resetCanvas(); //-- TODO: Preserve image - rotate/transform into new bmpData...
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
		public function saveImage():void
		{
			trace("perm status: " + File.permissionStatus);
			
			var byteArray:ByteArray = PNGEncoder.encode(_bmpData);
			
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
	}
}
