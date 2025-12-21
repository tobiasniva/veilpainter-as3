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
	import ui.StyleSizer;

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
	 * Figure out what we actually want gui to support. Interface?
	 * Difference between tablet/phone gui? (for sure...)
	 */
	public class GuiBase extends Sprite
	{
		//-- refs in parent class...
		private var _parent:VeilPainter;
		private var _brush:Brush;

		protected var _screenSize:Point;
		protected var _loadAlphaImages:LoadAlphaImages;
		protected var _sldElasticity:HUISlider;
		protected var _sldStrength:HUISlider;
		protected var _sldStrengthDegradation:HUISlider;
		protected var _sldAlpha:HUISlider;
		protected var _stpNumLinks:NumericStepper;
		protected var _cmbAlphaImage:ComboBox;
		protected var _cmbBlendMode:ComboBox;
		protected var _colorPicker:ColorChooser;
		protected var _colorPickerBG:ColorChooser;
		protected var _stpSizeMultiplier:NumericStepper;
		protected var _chkDebug:CheckBox;
		
		protected var _lblAlphaImage:Label;
		protected var _lblNumLinks:Label;
		protected var _lblBlendModes:Label;
		protected var _btnClear:PushButton;
		protected var _btnSaveImage:PushButton;

		
		public function GuiBase(parent:VeilPainter, uiScale:int)
		{
			StyleSizer.ComponentScale(uiScale);

			this.mouseEnabled = false; //TODO: Good to not pick up mouse...but safe for everything within this?

			//TODO: Remove these ugly refs...solve with some event system...?
			_parent = parent;
			_screenSize = parent.screenSize;
			_brush = parent.brush;
			_loadAlphaImages = parent.loadAlphaImages;
			
			//-- Create components TODO: Consider putting them in container, to be able to separate behaviour phone/tablet?
			_sldElasticity = new HUISlider(this);
			_sldElasticity.label = Strings.LBL_ELASTICITY;
			_sldElasticity.addEventListener(Event.CHANGE, onElasticityChanged);
			_sldElasticity.setSliderParams(Constants.ELASTICITY_MIN, Constants.ELASTICITY_MAX, Constants.ELASTICITY_DEFAULT);
			_sldElasticity.labelPrecision = 2;
			_sldElasticity.tick = 0.01

			_sldStrength = new HUISlider(this);
			_sldStrength.label = Strings.LBL_STRENGTH;
			_sldStrength.addEventListener(Event.CHANGE, onStrengthChanged);
			_sldStrength.setSliderParams(Constants.STRENGTH_MIN, Constants.STRENGTH_MAX, Constants.STRENGTH_DEFAULT);
			_sldStrength.labelPrecision = 3;
			_sldStrength.tick = 0.001

			_sldStrengthDegradation = new HUISlider(this);
			_sldStrengthDegradation.label = Strings.LBL_STRENGTH_DEGR;
			_sldStrengthDegradation.addEventListener(Event.CHANGE, onStrengthDegradationChanged);
			_sldStrengthDegradation.setSliderParams(Constants.DEGRADATION_MIN, Constants.DEGRADATION_MAX, Constants.DEGRADATION_DEFAULT);
			_sldStrengthDegradation.labelPrecision = 2;
			_sldStrengthDegradation.tick = 0.01;

			_lblAlphaImage = new Label(this, 0, 0, Strings.LBL_ALPHA_IMG);

			_cmbAlphaImage = new ComboBox(this);
			for each(var img:ImageWithLabel in _loadAlphaImages.images)  {
				_cmbAlphaImage.addItem(img.label);
			}
			_cmbAlphaImage.selectedIndex = 0;
			_cmbAlphaImage.numVisibleItems = _loadAlphaImages.images.length;
			_cmbAlphaImage.addEventListener(Event.SELECT, onAlphaImageChanged);

			_sldAlpha = new HUISlider(this);
			_sldAlpha.addEventListener(Event.CHANGE, onAlphaChanged);
			_sldAlpha.setSliderParams(0, 1, Constants.BRUSH_ALPHA_DEFAULT);
			_sldAlpha.labelPrecision = 1;
			_sldAlpha.tick = 0.1;

			_lblNumLinks = new Label(this, 0, 0, Strings.LBL_NUM_LINKS);

			_stpNumLinks = new NumericStepper(this);
			_stpNumLinks.addEventListener(Event.CHANGE, onNumLinksChanged);
			_stpNumLinks.step = Constants.NUM_LINKS_STEP;
			_stpNumLinks.minimum = Constants.NUM_LINKS_MIN;
			_stpNumLinks.value = Constants.NUM_LINKS_DEFAULT;
			_stpNumLinks.maximum = Constants.NUM_LINKS_MAX;

			_chkDebug = new CheckBox(this, 0, 0, Strings.LBL_DEBUG, onDebugChanged);

			_lblBlendModes = new Label(this, 0, 0, Strings.LBL_BLENDMODE);
			var blendModesAll:Array = BlendModes.getAll();
			_cmbBlendMode = new ComboBox(this, 0, 0, "", blendModesAll);
			_cmbBlendMode.numVisibleItems = blendModesAll.length;
			_cmbBlendMode.selectedIndex = Constants.BRUSH_BLENDMODE_INDEX;
			_cmbBlendMode.addEventListener(Event.SELECT, onBlendModeChanged);

			_colorPicker = new ColorChooser(this, 0, 0, Constants.BRUSH_COLOR_DEFAULT, onColorChanged);
			_colorPicker.usePopup = true;

			//-- STUFF @ right...
			_btnClear = new PushButton(this, 0, 0, Strings.LBL_CLEAR, onResetCanvas);

			_stpSizeMultiplier = new NumericStepper(this, 0, 0, onResetCanvas);
			_stpSizeMultiplier.minimum = 1;
			_stpSizeMultiplier.value = Constants.SIZE_MULTIPLIER_DEFAULT;
			_stpSizeMultiplier.maximum = 4;
			_stpSizeMultiplier.width = 52;

			_colorPickerBG = new ColorChooser(this, 0, 0, Constants.BG_COLOR_DEFAULT, onResetCanvas);
			_colorPickerBG.usePopup = true;

			_btnSaveImage = new PushButton(this, 0, 0, Strings.LBL_SAVE, onSaveImageToDesktop);
		}
		
		public function show():void
		{
			this.visible = true;
		}

		public function hide():void
		{
			this.visible = false;
		}

		protected function onSaveImageToDesktop(e:Event):void
		{
			_parent.saveImage();
		}

		protected function onResetCanvas(e:Event):void
		{
			_parent.resetCanvas(_stpSizeMultiplier.value, _colorPickerBG.value);
		}

		protected function onNumLinksChanged(e:Event):void
		{
			_brush.numLinks = _stpNumLinks.value;
		}

		protected function onElasticityChanged(e:Event):void
		{
			_brush.elasticity = _sldElasticity.value;
		}

		protected function onStrengthChanged(e:Event):void
		{
			_brush.strength = _sldStrength.value;
		}

		protected function onStrengthDegradationChanged(e:Event):void
		{
			_brush.strengthDegradation = _sldStrengthDegradation.value;
		}

		protected function onColorChanged(e:Event):void
		{
			_brush.brushColor = _colorPicker.value;
		}

		protected function onAlphaChanged(e:Event):void
		{
			_brush.brushAlpha = _sldAlpha.value;
		}

		protected function onBlendModeChanged(e:Event):void
		{
			_brush.brushBlendmode = String(_cmbBlendMode.selectedItem);
		}

		protected function onAlphaImageChanged(e:Event):void
		{
			var index:int = _cmbAlphaImage.selectedIndex;
			var img:Bitmap = _loadAlphaImages.images[index].bitmap;
			_brush.alphaImage = img;
		}

		protected function onDebugChanged(e:Event):void
		{
			_brush.debug = _chkDebug.selected;
		}
	}
}
