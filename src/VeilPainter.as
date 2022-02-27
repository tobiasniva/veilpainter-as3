package
{
	import behavior.Brush;
	import behavior.ImageWithLabel;

	import com.adobe.images.PNGEncoder;
	import com.bit101.components.CheckBox;
	import com.bit101.components.ColorChooser;
	import com.bit101.components.ComboBox;
	import com.bit101.components.HUISlider;
	import com.bit101.components.Label;
	import com.bit101.components.NumericStepper;
	import com.bit101.components.PushButton;

	import data.BlendModes;

	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageDisplayState;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.geom.Point;
	import flash.globalization.DateTimeFormatter;
	import flash.ui.Multitouch;
	import flash.ui.MultitouchInputMode;
	import flash.utils.ByteArray;

	import utils.LoadAlphaImages;
	import utils.ShapeFactory;

	/**
	 *
	 * @author: Tobi Wan Kenobi
	 */
	[SWF(backgroundColor="#000000", frameRate="60", width="1024", height="768")]
	public class VeilPainter extends Sprite
	{
		private static const BG_COLOR_DEFAULT:uint = 0xeeeeee;
		private static const BRUSH_COLOR_DEFAULT:uint = 0x3399cc;
		private static const CHAIN_LINK_COLOR:uint = 0x808080;
		private static const CHAIN_LINK_SIZE:int = 2;

		private var _screenSize:Point;
		private var _bmpSize:Point;
		private var _sizeMultiplier:int;

		private var _bmp:Bitmap;
		private var _bmpData:BitmapData;
		private var _brush:Brush;

		private var _sldElasticity:HUISlider;
		private var _sldStrength:HUISlider;
		private var _sldStrengthDegradation:HUISlider;
		private var _sldAlpha:HUISlider;
		private var _stpNumLinks:NumericStepper;
		private var _cmbAlphaImage:ComboBox;
		private var _cmbBlendMode:ComboBox;
		private var _colorPicker:ColorChooser;
		private var _colorPickerBG:ColorChooser;
		private var _stpSizeMultiplier:NumericStepper;
		private var _chkDebug:CheckBox;

		private var _loadAlphaImages:LoadAlphaImages;

		public function VeilPainter()
		{
			stage.scaleMode 	= StageScaleMode.NO_SCALE;
			stage.align 		= StageAlign.TOP_LEFT;
			stage.displayState 	= StageDisplayState.FULL_SCREEN;
			stage.displayState 	= StageDisplayState.FULL_SCREEN_INTERACTIVE; //-- Needed to be able to type into e.g. color chooser!

			_sizeMultiplier = 1;
			_screenSize = new Point(stage.fullScreenWidth, stage.fullScreenHeight);
			_bmpSize 	= new Point(_screenSize.x * _sizeMultiplier, _screenSize.y * _sizeMultiplier);

			initGUI();
			
			_loadAlphaImages = new LoadAlphaImages();
			_loadAlphaImages.addEventListener(Event.COMPLETE, initBrush);
		}

		private function initBrush(e:Event):void
		{
			_loadAlphaImages.removeEventListener(Event.COMPLETE, initBrush);

			for each(var img:ImageWithLabel in _loadAlphaImages.images)
			{
				_cmbAlphaImage.addItem(img.label);
			}
			_cmbAlphaImage.selectedIndex = 0;
			_cmbAlphaImage.numVisibleItems = _loadAlphaImages.images.length;
			_cmbAlphaImage.addEventListener(Event.SELECT, onAlphaImageChanged);

			//-- Init canvas
			_bmpData = new BitmapData(_bmpSize.x, _bmpSize.y, false, _colorPickerBG.value);
			_bmp = new Bitmap(_bmpData);
			addChildAt(_bmp, 0);

			//-- Create Brush
			_brush = new Brush(_bmpData, _sizeMultiplier, _stpNumLinks.value);
			_brush.alphaImage = _loadAlphaImages.images[0].bitmap;
			_brush.elasticity = _sldElasticity.value;
			_brush.strength = _sldStrength.value;
			_brush.strengthDegradation = _sldStrengthDegradation.value;
//			_brush.fade = true;
			_brush.brushColor = _colorPicker.value;
			_brush.brushAlpha = _sldAlpha.value;
			_brush.brushBlendmode = String(_cmbBlendMode.selectedItem);
			_brush.shape = ShapeFactory.getCircle(CHAIN_LINK_SIZE, CHAIN_LINK_COLOR);
			addChildAt(_brush, getChildIndex(_bmp) + 1);

			//-- Mouse
			stage.addEventListener(MouseEvent.MOUSE_DOWN, toggleDrawing);
			stage.addEventListener(MouseEvent.MOUSE_UP, toggleDrawing);

			//-- Ticker
			stage.addEventListener(Event.ENTER_FRAME, update);
		}

		private function update(e:Event):void
		{
			var target:Point = new Point(mouseX, mouseY);
			_brush.update(target);
		}

		private function toggleDrawing(e:MouseEvent):void
		{
			if (e.type == MouseEvent.MOUSE_DOWN && e.target == stage)
			{
				_brush.isDrawing = true;
			}
			else
			{
				_brush.isDrawing = false;
			}
		}

		private function onResetCanvas(e:*):void
		{
			_sizeMultiplier = _stpSizeMultiplier.value;
			_bmpSize.x = _screenSize.x * _sizeMultiplier;
			_bmpSize.y = _screenSize.y * _sizeMultiplier;

//			_bmpData.dispose();

			_bmpData = new BitmapData(_bmpSize.x, _bmpSize.y, false, _colorPickerBG.value);
			_bmp.bitmapData = _bmpData;
			_bmp.scaleX = _bmp.scaleY = 1 / _sizeMultiplier;

			_brush.canvas = _bmpData;
			_brush.canvasSizeMultiplier = _sizeMultiplier;
		}

		private function onSaveImageToDesktop(e:MouseEvent):void
		{
			var byteArray:ByteArray = PNGEncoder.encode(_bmpData);

			var d:Date = new Date();
			var dtf:DateTimeFormatter = new DateTimeFormatter("en-US");
			dtf.setDateTimePattern("yyyyMMdd_hhmmss");

			var file:File = File.desktopDirectory.resolvePath("niva3d_" + dtf.format(d) + ".png");
			var fileStream:FileStream = new FileStream();
			fileStream.open(file, FileMode.WRITE);
			fileStream.writeBytes(byteArray);
			fileStream.close();
		}

		private function onNumLinksChanged(e:Event):void
		{
			_brush.numLinks = _stpNumLinks.value;
		}

		private function onElasticityChanged(e:Event):void
		{
			_brush.elasticity = _sldElasticity.value;
		}

		private function onStrengthChanged(e:Event):void
		{
			_brush.strength = _sldStrength.value;
		}

		private function onStrengthDegradationChanged(e:Event):void
		{
			_brush.strengthDegradation = _sldStrengthDegradation.value;
		}

		private function onColorChanged(e:Event):void
		{
			_brush.brushColor = _colorPicker.value;
		}

		private function onAlphaChanged(e:Event):void
		{
			_brush.brushAlpha = _sldAlpha.value;
		}

		private function onBlendModeChanged(e:Event):void
		{
			_brush.brushBlendmode = String(_cmbBlendMode.selectedItem);
		}

		private function onAlphaImageChanged(e:Event):void
		{
			var index:int = _cmbAlphaImage.selectedIndex;
			var img:Bitmap = _loadAlphaImages.images[index].bitmap;
			_brush.alphaImage = img;
		}

		private function onDebugChanged(e:Event):void
		{
//			trace(_debugDots.selected);
			_brush.debug = _chkDebug.selected;
		}

		/*
		 GUI and controls
		 */
		private function initGUI():void
		{
			_sldElasticity = new HUISlider(this, 10, 10, "Elasticity", onElasticityChanged);
			_sldElasticity.width = 300;
			_sldElasticity.setSliderParams(0.0, 1.0, 0.85);
			_sldElasticity.labelPrecision = 2;
			_sldElasticity.tick = 0.01

			_sldStrength = new HUISlider(this, 10, 35, "Strength", onStrengthChanged);
			_sldStrength.width = 300;
			_sldStrength.setSliderParams(0.0, 0.1, 0.028);
			_sldStrength.labelPrecision = 3;
			_sldStrength.tick = 0.001

			_sldStrengthDegradation = new HUISlider(this, 10, 60, "Strength degr", onStrengthDegradationChanged);
			_sldStrengthDegradation.width = 300;
			_sldStrengthDegradation.setSliderParams(0.05, 10, 2.7);
			_sldStrengthDegradation.labelPrecision = 2;
			_sldStrengthDegradation.tick = 0.01;


			var lblAlphaImage:Label = new Label(this, 316, 10, "Alpha img");
			_cmbAlphaImage = new ComboBox(this, 369, 10, "");
			_cmbAlphaImage.width = 96;
//			_cmbAlphaImage.addEventListener(Event.SELECT, onAlphaImageChanged);

			_sldAlpha = new HUISlider(this, 469, 10, "", onAlphaChanged);
			_sldAlpha.width = 130;
			_sldAlpha.setSliderParams(0, 1, 0.5);
			_sldAlpha.labelPrecision = 1;
			_sldAlpha.tick = 0.1;

			var lblNumLinks:Label = new Label(this, 748, 11, "Num links");
			_stpNumLinks = new NumericStepper(this, 692, 12, onNumLinksChanged);
			_stpNumLinks.width = 52
			_stpNumLinks.step = 2;
			_stpNumLinks.minimum = 2;
			_stpNumLinks.value = 4;
			_stpNumLinks.maximum = 16;

			_chkDebug = new CheckBox(this, 733, 43, "Debug", onDebugChanged);

			var lblBlendModes:Label = new Label(this, 316, 39, "BlendMode");
			var blendModesAll:Array = BlendModes.getAll();
			_cmbBlendMode = new ComboBox(this, 369, 38, "", blendModesAll);
			_cmbBlendMode.width = 96;
			_cmbBlendMode.numVisibleItems = blendModesAll.length;
			_cmbBlendMode.selectedIndex = 10;
			_cmbBlendMode.addEventListener(Event.SELECT, onBlendModeChanged);

			//-- Color 'BRUSH'
			_colorPicker = new ColorChooser(this, 478, 40, BRUSH_COLOR_DEFAULT, onColorChanged);
			_colorPicker.usePopup = true;


			//-- STUFF @ right...
			var btnClear:PushButton = new PushButton(this, _screenSize.x - 110, 10, "Clear", onResetCanvas);

			_stpSizeMultiplier = new NumericStepper(this, btnClear.x - 62, 12, onResetCanvas);
			_stpSizeMultiplier.minimum = 1;
			_stpSizeMultiplier.value = _sizeMultiplier;
			_stpSizeMultiplier.maximum = 4;
			_stpSizeMultiplier.width = 52;

			//-- Color BG
			_colorPickerBG = new ColorChooser(this, _stpSizeMultiplier.x - 80, 12, BG_COLOR_DEFAULT, onResetCanvas);
			_colorPickerBG.usePopup = true;


			var btnSaveImage:PushButton = new PushButton(this, _screenSize.x - 110, _screenSize.y - 30, "Save", onSaveImageToDesktop);
		}
	}
}
