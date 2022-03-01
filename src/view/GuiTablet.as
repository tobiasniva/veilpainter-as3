package view
{
	import behavior.Brush;
	import behavior.ImageWithLabel;

	import com.bit101.components.CheckBox;
	import com.bit101.components.ColorChooser;
	import com.bit101.components.ComboBox;
	import com.bit101.components.HUISlider;
	import com.bit101.components.Label;
	import com.bit101.components.NumericStepper;
	import com.bit101.components.PushButton;

	import data.BlendModes;
	import data.Constants;
	import data.Strings;

	import flash.display.Bitmap;

	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Point;

	import utils.LoadAlphaImages;

	/**
	 *
	 * @author: Tobi Wan Kenobi
	 * The extended UI, where more stuff are available directly on screen...
	 */
	public class GuiTablet extends Sprite
	{
		//-- refs in parent class...
		private var _parent:VeilPainter;
		private var _screenSize:Point;
		private var _brush:Brush;
		private var _loadAlphaImages:LoadAlphaImages;
		
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
		
		
		public function GuiTablet(parent:VeilPainter)
		{
			//TODO: Remove these ugly refs...solve with some event system...?
			_parent = parent;
			_screenSize = parent.screenSize;
			_brush = parent.brush;
			_loadAlphaImages = parent.loadAlphaImages;
			//TODO: See above...
			
			
			//-- init and layout gui
			_sldElasticity = new HUISlider(this, 10, 10, Strings.LBL_ELASTICITY, onElasticityChanged);
			_sldElasticity.width = 300;
			_sldElasticity.setSliderParams(Constants.ELASTICITY_MIN, Constants.ELASTICITY_MAX, Constants.ELASTICITY_DEFAULT);
			_sldElasticity.labelPrecision = 2;
			_sldElasticity.tick = 0.01

			_sldStrength = new HUISlider(this, 10, 35, Strings.LBL_STRENGTH, onStrengthChanged);
			_sldStrength.width = 300;
			_sldStrength.setSliderParams(Constants.STRENGTH_MIN, Constants.STRENGTH_MAX, Constants.STRENGTH_DEFAULT);
			_sldStrength.labelPrecision = 3;
			_sldStrength.tick = 0.001

			_sldStrengthDegradation = new HUISlider(this, 10, 60, Strings.LBL_STRENGTH_DEGR, onStrengthDegradationChanged);
			_sldStrengthDegradation.width = 300;
			_sldStrengthDegradation.setSliderParams(Constants.DEGRADATION_MIN, Constants.DEGRADATION_MAX, Constants.DEGRADATION_DEFAULT);
			_sldStrengthDegradation.labelPrecision = 2;
			_sldStrengthDegradation.tick = 0.01;

			var lblAlphaImage:Label = new Label(this, 316, 10, Strings.LBL_ALPHA_IMG);
			_cmbAlphaImage = new ComboBox(this, 369, 10, "");
			_cmbAlphaImage.width = 96;
			for each(var img:ImageWithLabel in _loadAlphaImages.images)
			{
				_cmbAlphaImage.addItem(img.label);
			}
			_cmbAlphaImage.selectedIndex = 0;
			_cmbAlphaImage.numVisibleItems = _loadAlphaImages.images.length;
			_cmbAlphaImage.addEventListener(Event.SELECT, onAlphaImageChanged);

			_sldAlpha = new HUISlider(this, 469, 10, "", onAlphaChanged);
			_sldAlpha.width = 130;
			_sldAlpha.setSliderParams(0, 1, Constants.BRUSH_ALPHA_DEFAULT);
			_sldAlpha.labelPrecision = 1;
			_sldAlpha.tick = 0.1;

			var lblNumLinks:Label = new Label(this, 748, 11, Strings.LBL_NUM_LINKS);
			_stpNumLinks = new NumericStepper(this, 692, 12, onNumLinksChanged);
			_stpNumLinks.width      = 52
			_stpNumLinks.step       = Constants.NUM_LINKS_STEP;
			_stpNumLinks.minimum    = Constants.NUM_LINKS_MIN;
			_stpNumLinks.value      = Constants.NUM_LINKS_DEFAULT;
			_stpNumLinks.maximum    = Constants.NUM_LINKS_MAX;

			_chkDebug = new CheckBox(this, 733, 43, Strings.LBL_DEBUG, onDebugChanged);

			var lblBlendModes:Label = new Label(this, 316, 39, Strings.LBL_BLENDMODE);
			var blendModesAll:Array = BlendModes.getAll();
			_cmbBlendMode = new ComboBox(this, 369, 38, "", blendModesAll);
			_cmbBlendMode.width = 96;
			_cmbBlendMode.numVisibleItems = blendModesAll.length;
			_cmbBlendMode.selectedIndex = Constants.BRUSH_BLENDMODE_INDEX;
			_cmbBlendMode.addEventListener(Event.SELECT, onBlendModeChanged);

			//-- Color 'BRUSH'
			_colorPicker = new ColorChooser(this, 478, 40, Constants.BRUSH_COLOR_DEFAULT, onColorChanged);
			_colorPicker.usePopup = true;


			//-- STUFF @ right...
			var btnClear:PushButton = new PushButton(this, _screenSize.x - 110, 10, Strings.LBL_CLEAR, onResetCanvas);

			_stpSizeMultiplier = new NumericStepper(this, btnClear.x - 62, 12, onResetCanvas);
			_stpSizeMultiplier.minimum = 1;
			_stpSizeMultiplier.value = Constants.SIZE_MULTIPLIER_DEFAULT;
			_stpSizeMultiplier.maximum = 4;
			_stpSizeMultiplier.width = 52;

			//-- Color BG
			_colorPickerBG = new ColorChooser(this, _stpSizeMultiplier.x - 80, 12, Constants.BG_COLOR_DEFAULT, onResetCanvas);
			_colorPickerBG.usePopup = true;

			var btnSaveImage:PushButton = new PushButton(this, _screenSize.x - 110, _screenSize.y - 30, Strings.LBL_SAVE, onSaveImageToDesktop);
		}

		private function onSaveImageToDesktop(e:Event):void
		{
			_parent.saveImageToDesktop();
		}

		private function onResetCanvas(e:Event):void
		{
			_parent.resetCanvas(_stpSizeMultiplier.value, _colorPickerBG.value);
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
	}
}
