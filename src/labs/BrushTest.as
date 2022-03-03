package labs
{
	import behavior.Brush;
	import behavior.ImageWithLabel;

	import com.adobe.images.PNGEncoder;
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
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.globalization.DateTimeFormatter;
	import flash.utils.ByteArray;

	import utils.LoadAlphaImages;
	import utils.ShapeFactory;

	/**
	 *
	 * @author: Tobi Wan Kenobi
	 */
	[SWF(backgroundColor="#000000", frameRate="60", width="1440", height="900")]
	public class BrushTest extends Sprite
	{
		private static const BG_COLOR_DEFAULT:uint = 0xeeeeee;
		private static const BRUSH_COLOR_DEFAULT:uint = 0x3399cc;
		private static const CHAIN_LINK_COLOR:uint = 0x808080;
		private static const CHAIN_LINK_SIZE:int = 2;

		private static const SCREEN_WIDTH:int = 1440;
		private static const SCREEN_HEIGHT:int = 900;

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

		private var _loadAlphaImages:LoadAlphaImages;

		public function BrushTest()
		{
			setupGUI();
			_loadAlphaImages = new LoadAlphaImages();
			_loadAlphaImages.addEventListener(Event.COMPLETE, init);
		}

		private function init(e:Event):void
		{
			_loadAlphaImages.removeEventListener(Event.COMPLETE, init);

			for each(var img:ImageWithLabel in _loadAlphaImages.images)
			{
				_cmbAlphaImage.addItem(img.label);
			}
			_cmbAlphaImage.selectedIndex = 0;
			_cmbAlphaImage.numVisibleItems = _loadAlphaImages.images.length;
			_cmbAlphaImage.addEventListener(Event.SELECT, onAlphaImageChanged);

			_bmpData = new BitmapData(SCREEN_WIDTH, SCREEN_HEIGHT, false, _colorPickerBG.value);
			_bmp = new Bitmap(_bmpData);
			addChildAt(_bmp, 0);

			//-- Create Brush
			_brush = new Brush(_bmpData, _stpNumLinks.value);
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

		private function onClearCanvas(e:*):void
		{
			_bmpData.fillRect(new Rectangle(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT), _colorPickerBG.value);
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

		/*
		 GUI and controls
		 */
		private function setupGUI():void
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
			_stpNumLinks.step = 4;
			_stpNumLinks.minimum = 4;
			_stpNumLinks.value = 4;
			_stpNumLinks.maximum = 32;

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

			//-- Color BG
			_colorPickerBG = new ColorChooser(this, 1252, 12, BG_COLOR_DEFAULT, onClearCanvas);
			_colorPickerBG.usePopup = true;

			var btnClear:PushButton = new PushButton(this, 1330, 10, "Clear", onClearCanvas);

			var btnSaveImage:PushButton = new PushButton(this, 1330, 40, "Save", onSaveImageToDesktop);
		}
	}
}
