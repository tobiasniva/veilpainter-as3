package
{
	import behavior.Brush;
	import com.adobe.images.PNGEncoder;
	import core.AppModel;
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
	import flash.system.Capabilities;
	import ui.StyleSizer
	import utils.LoadAlphaImages;
	import utils.ShapeFactory;
	import utils.SaveImageWithDialog;
	import utils.UiScaleUtil
	import view.Gui;
	import view.layout.*;
	import view.viewport.*;

	[SWF(backgroundColor="#000000", frameRate="60", width="1024", height="768")]
	public class VeilPainter extends Sprite
	{
		public var brush:Brush;
		public var loadAlphaImages:LoadAlphaImages;
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
			stage.addEventListener(Event.RESIZE, initialResizeCorrectStageSize);
			initialResizeCorrectStageSize();
		}

		private function initialResizeCorrectStageSize():void
		{
			stage.removeEventListener(Event.RESIZE, initialResizeCorrectStageSize);

			// Model inits
			AppModel.instance.stageSize = new Point(stage.stageWidth, stage.stageHeight);
			AppModel.instance.canvasMultiplier = Constants.CANVAS_MULTIPLIER_DEFAULT;

			loadAlphaImages = new LoadAlphaImages();
			loadAlphaImages.addEventListener(Event.COMPLETE, init);
		}

		private function init(e:Event):void
		{
			loadAlphaImages.removeEventListener(Event.COMPLETE, init);

			//-- Init canvas
			var bmpSize:Point = AppModel.instance.stageSize;
			var canvasCol:uint = AppModel.instance.canvasColor;
			_bmpData = new BitmapData(bmpSize.x, bmpSize.y, false, canvasCol);
			_bmp = new Bitmap(_bmpData);
			addChildAt(_bmp, 0);

			//-- Create Brush
			brush = new Brush(_bmpData); //TODO: Extract bmp/canvas ref from within brush...
			brush.alphaImage           = loadAlphaImages.images[0].bitmap;
			brush.elasticity           = Constants.ELASTICITY_DEFAULT;
			brush.strength             = Constants.STRENGTH_DEFAULT;
			brush.strengthDegradation  = Constants.DEGRADATION_DEFAULT;
			brush.brushColor           = Constants.BRUSH_COLOR_DEFAULT;
			brush.brushAlpha           = Constants.BRUSH_ALPHA_DEFAULT;
			brush.brushBlendmode       = Constants.BRUSH_BLENDMODE_DEFAULT;
			brush.shape = ShapeFactory.getCircle(Constants.CHAIN_LINK_SIZE, Constants.CHAIN_LINK_COLOR);
			addChildAt(brush, 1); // Above bitmap
			
			//-- GUI
			var uiScale:int = UiScaleUtil.computeUiScale();
			trace("UI Scale: " + uiScale);
			trace("dpi: " + Capabilities.screenDPI);
			StyleSizer.ComponentScale(uiScale);
			_gui = new Gui(this);
			addChildAt(_gui, 2); // Above brush

			//-- Layout Manager - NEEDS GUI!
			_layoutManager = new LayoutManager(_gui, uiScale);
			_layoutManager.registerLayout(Strings.PHONE_PORTRAIT, new PhonePortraitLayout());
			_layoutManager.registerLayout(Strings.PHONE_LANDSCAPE, new PhoneLandscapeLayout());
			_layoutManager.refresh(true);

			//-- Viewport resize listener - RELIES ON GUI BEING INITIALIZED!
			var viewportService:ViewportService = new ViewportService(stage);
			viewportService.addEventListener(ViewportChangedEvent.VIEWPORT_CHANGED, onViewportChanged);
			viewportService.start();

			//-- Mouse
			stage.addEventListener(MouseEvent.MOUSE_DOWN, toggleDrawing);
			stage.addEventListener(MouseEvent.MOUSE_UP, toggleDrawing);

			//-- Ticker
			stage.addEventListener(Event.ENTER_FRAME, update);
		}

		private function onViewportChanged(e:ViewportChangedEvent):void
		{
			AppModel.instance.stageSize = new Point(e.screenW, e.screenH);

			_layoutManager.refresh(true);
			resetCanvas(); //TODO: Preserve image - rotate/transform into new bmpData...
		}

		private function update(e:Event):void
		{
			var target:Point = new Point(mouseX, mouseY);
			brush.update(target);
		}

		private function toggleDrawing(e:MouseEvent):void
		{
			if (e.type == MouseEvent.MOUSE_DOWN && e.target == stage)
			{
				brush.isDrawing = true;
				_gui.hide();
//				trace("isDrawing = true");
			}
			else
			{
				brush.isDrawing = false;
				_gui.show();
//				trace("isDrawing = false");
			}
		}

		//-- 
		public function resetCanvas():void
		{
			trace("Reset canvas");
//			_bmpData.dispose();
			var bs:Point = new Point(AppModel.instance.stageSize.x, AppModel.instance.stageSize.y);

			_bmpData = new BitmapData(bs.x, bs.y, false, AppModel.instance.canvasColor);
			_bmp.bitmapData = _bmpData;
			_bmp.scaleX = _bmp.scaleY = 1 / AppModel.instance.canvasMultiplier;

			brush.canvas = _bmpData;
			brush.canvasSizeMultiplier = AppModel.instance.canvasMultiplier;
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
