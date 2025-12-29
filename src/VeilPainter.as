package
{
	import behavior.Brush;
	import data.Constants;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageDisplayState;
	import flash.display.StageScaleMode;
	import flash.display.Screen;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.globalization.DateTimeFormatter;
	import flash.utils.ByteArray;
	import helpers.CheckPermission;
	import utils.LoadAlphaImages;
	import utils.ShapeFactory;
	import utils.SaveImageWithDialog;
	import view.*
	import flash.system.Capabilities;
	import com.adobe.images.PNGEncoder;
	import flash.filesystem.File
	/**
	 * @author: Tobi Wan Kenobi
	 * Sort of the main class acting as a hub, holding the bitmap, brush and gui etc...
	 */
	[SWF(backgroundColor="#000000", frameRate="60", width="1024", height="768")]
	public class VeilPainter extends Sprite
	{
		public var brush:Brush;
		public var safeArea:Point;
		public var loadAlphaImages:LoadAlphaImages;
		
		private var _screenSize:Point;
		private var _bmpSize:Point;
		private var _sizeMultiplier:int;

		private var _bmp:Bitmap;
		private var _bmpData:BitmapData;
		private var _gui:GuiBase;
		private var _chkPerm:CheckPermission;


		public function VeilPainter()
		{
			stage.scaleMode 	= StageScaleMode.NO_SCALE;
			stage.align 		= StageAlign.TOP_LEFT;
			stage.displayState 	= StageDisplayState.FULL_SCREEN;
			stage.displayState 	= StageDisplayState.FULL_SCREEN_INTERACTIVE; //-- Needed to be able to type into e.g. color chooser!

			_sizeMultiplier = Constants.SIZE_MULTIPLIER_DEFAULT;
			_screenSize = new Point(stage.fullScreenWidth, stage.fullScreenHeight);
			safeArea = new Point(Screen.mainScreen.safeArea.width, Screen.mainScreen.safeArea.height); // Used for mobile devices with notches etc.

			// hack for making safe area work in the simulator...
			if(Capabilities.playerType == "Desktop" && (Capabilities.os.toLowerCase().indexOf("windows") != -1 || Capabilities.os.toLowerCase().indexOf("mac") != -1) ) {
				safeArea.x = _screenSize.x;
				safeArea.y = _screenSize.y;
			}

			_bmpSize 	= new Point(safeArea.x * _sizeMultiplier, safeArea.y * _sizeMultiplier);
			
			_chkPerm = new CheckPermission();
			_chkPerm.addEventListener(Event.COMPLETE, onPermissionGranted);
			_chkPerm.StartCheck();
		}
		
		private function onPermissionGranted(e:Event):void
		{
			loadAlphaImages = new LoadAlphaImages();
			loadAlphaImages.addEventListener(Event.COMPLETE, onAlphaImagesLoaded);
		}
		
		private function onAlphaImagesLoaded(e:Event):void
		{
			loadAlphaImages.removeEventListener(Event.COMPLETE, onAlphaImagesLoaded);
			
			//-- Init canvas
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
			addChildAt(brush, getChildIndex(_bmp) + 1);
			
			_gui = getGui(Constants.UI_TYPE);
			addChild(_gui);

			// TEMP frame for bounds check
			// var bnd:Sprite = new Sprite();
			// bnd.mouseEnabled = false;
			// bnd.graphics.lineStyle(4, 0xff0000, 1);
			// bnd.graphics.drawRect(0, 0, safeArea.x, safeArea.y);
			// addChild(bnd);

			//-- Mouse
			stage.addEventListener(MouseEvent.MOUSE_DOWN, toggleDrawing);
			stage.addEventListener(MouseEvent.MOUSE_UP, toggleDrawing);

			//-- Ticker
			stage.addEventListener(Event.ENTER_FRAME, update);
		}

		private function getGui(guiType:int):GuiBase
		{
			switch(guiType) {
				case 1:
					return new GuiDesktop(this);
					break;
				case 2:
					return new GuiPhone(this); //TODO: Create GuiTablet...
					break;
				case 4:
					return new GuiPhone(this);
					break;
				default:
					return new GuiDesktop(this);
			}
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
			_bmpSize.x = safeArea.x * _sizeMultiplier;
			_bmpSize.y = safeArea.y * _sizeMultiplier;

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

			SaveImageWithDialog.savePNG(
				byteArray,
				imgName,
				function():void { trace("Saved: " + imgName); },
				function():void { trace("User canceled"); },
				function(err:String):void
				{
					trace("Save failed: " + err);
					createAndShowPopup("Save failed", "This location is not supported on your device. Please choose Downloads and try again."
				);
				}
			);
		}

		private function createAndShowPopup(header:String, msg:String):void
		{
			var dlg:ModalDialog = new ModalDialog(this);
			dlg.show(header, msg, "OK",
				function():void
				{
					trace("User clicked OK");
				}
			);
		}
	}
}
