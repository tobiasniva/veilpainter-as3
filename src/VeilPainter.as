package
{
	import behavior.Brush;
	import data.Constants;
	import data.Strings;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageDisplayState;
	import flash.display.StageScaleMode;
	import flash.display.Screen;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.filesystem.File
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.globalization.DateTimeFormatter;
	import flash.utils.ByteArray;
	import utils.LoadAlphaImages;
	import utils.ShapeFactory;
	import utils.SaveImageWithDialog;
	import utils.UiScaleUtil
	import flash.system.Capabilities;
	import com.adobe.images.PNGEncoder;
	import ui.StyleSizer
	import view.Gui;
	import view.layout.*;
	import view.viewport.*;
	import event.ViewportChangedEvent;
	/**
	 * @author: Tobi Wan Kenobi
	 * Sort of the main class acting as a hub, holding the bitmap, brush and gui etc...
	 */
	[SWF(backgroundColor="#000000", frameRate="60", width="1024", height="768")]
	public class VeilPainter extends Sprite
	{
		public var brush:Brush;
		public var loadAlphaImages:LoadAlphaImages;
		
		private var _safeArea:Point;
		private var _screenSize:Point;
		private var _bmpSize:Point;
		private var _sizeMultiplier:int;

		private var _bmp:Bitmap;
		private var _bmpData:BitmapData;
		private var _uiRoot:Sprite;
		private var _gui:Gui;
		private var _layoutManager:LayoutManager;


		public function VeilPainter()
		{
			stage.scaleMode 	= StageScaleMode.NO_SCALE;
			stage.align 		= StageAlign.TOP_LEFT;
			stage.displayState 	= StageDisplayState.FULL_SCREEN;
			stage.displayState 	= StageDisplayState.FULL_SCREEN_INTERACTIVE; //-- Needed to be able to type into e.g. color chooser!

			_sizeMultiplier = Constants.SIZE_MULTIPLIER_DEFAULT;
			// _screenSize = new Point(stage.fullScreenWidth, stage.fullScreenHeight);
			_safeArea = getSafeAreaSize(); // Used for mobile devices with notches etc.
			
			loadAlphaImages = new LoadAlphaImages();
			loadAlphaImages.addEventListener(Event.COMPLETE, init);
		}
		
		private function getSafeAreaSize():Point
		{
			// EXACTLY your existing logic:
			var screenSize:Point = new Point(stage.fullScreenWidth, stage.fullScreenHeight);
			var safe:Point = new Point(Screen.mainScreen.safeArea.width, Screen.mainScreen.safeArea.height);

			if (Capabilities.playerType == "Desktop" &&
				(Capabilities.os.toLowerCase().indexOf("windows") != -1 || Capabilities.os.toLowerCase().indexOf("mac") != -1))
			{
				safe.x = screenSize.x;
				safe.y = screenSize.y;
			}
			return safe;
		}

		private function init(e:Event):void
		{
			loadAlphaImages.removeEventListener(Event.COMPLETE, init);

			//-- Init canvas
			_bmpSize 	= new Point(_safeArea.x * _sizeMultiplier, _safeArea.y * _sizeMultiplier);
			_bmpData = new BitmapData(_bmpSize.x, _bmpSize.y, false, Constants.BG_COLOR_DEFAULT);
			_bmp = new Bitmap(_bmpData);
			addChildAt(_bmp, 0);

			//-- Create Brush
			brush = new Brush(_bmpData, _sizeMultiplier, Constants.NUM_LINKS_DEFAULT);
			brush.alphaImage           = loadAlphaImages.images[0].bitmap;
			brush.elasticity           = Constants.ELASTICITY_DEFAULT;
			brush.strength             = Constants.STRENGTH_DEFAULT;
			brush.strengthDegradation  = Constants.DEGRADATION_DEFAULT;
//			brush.fade = true;
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
			_layoutManager.refresh(_safeArea.x, _safeArea.y, true);

			//-- Viewport resize listener - RELIES ON GUI BEING INITIALIZED!
			var viewportService:ViewportService = new ViewportService(stage, getSafeAreaSize);
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
			// if (_safeArea.x == e.screenW && _safeArea.y == e.screenH) return;

			_safeArea.x = e.screenW;
			_safeArea.y = e.screenH;

			_layoutManager.refresh(_safeArea.x, _safeArea.y, true);
			resetCanvas(_sizeMultiplier, Constants.BG_COLOR_DEFAULT); //TODO: preserve image?
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
		public function resetCanvas(sizeMultiplier:Number, bgColor:uint):void
		{
			trace("Reset canvas");

			_sizeMultiplier = sizeMultiplier;
			_bmpSize.x = _safeArea.x * _sizeMultiplier;
			_bmpSize.y = _safeArea.y * _sizeMultiplier;

//			_bmpData.dispose();

			_bmpData = new BitmapData(_bmpSize.x, _bmpSize.y, false, bgColor);
			_bmp.bitmapData = _bmpData;
			_bmp.scaleX = _bmp.scaleY = 1 / _sizeMultiplier;

			brush.canvas = _bmpData;
			brush.canvasSizeMultiplier = _sizeMultiplier;
		}

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
