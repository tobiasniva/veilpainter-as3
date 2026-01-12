package view
{
	import behavior.ImageWithLabel;
	import com.bit101.components.CheckBox;
	import com.bit101.components.ColorChooser;
	import com.bit101.components.ComboBox;
	import com.bit101.components.HUISlider;
	import com.bit101.components.Label;
	import com.bit101.components.NumericStepper;
	import com.bit101.components.PushButton;
	import com.bit101.components.Style;
	import core.BrushModel;
	import data.AlphaImages;
	import data.BlendModes;
	import data.Constants;
	import data.Strings;
	import flash.display.Sprite;
	import flash.events.Event;
	import view.layout.IGuiLayout;
	import view.layout.LayoutMetrics;
	import core.AppEventBus;
	import events.CanvasEvent;
	import core.AppModel;
	import core.CanvasModel;
	import ui.StyleSizer;
	import events.StageEvent;
	import view.layout.PhonePortraitLayout;
	import events.SaveEvent;

	public class GuiBrushPanel extends Sprite
	{
		private var _sldElasticity:HUISlider;
		private var _sldStrength:HUISlider;
		private var _sldStrengthDegradation:HUISlider;
		private var _sldOpacity:HUISlider;

		private var _stpNumLinks:NumericStepper;
		private var _cmbAlphaImage:ComboBox;
		private var _cmbBlendMode:ComboBox;
		private var _colorPicker:ColorChooser;
		private var _colorPickerBG:ColorChooser;
		private var _stpSizeMultiplier:NumericStepper;
		private var _chkDebug:CheckBox;

		private var _lblAlphaImage:Label;
		private var _lblNumLinks:Label;
		private var _lblBlendModes:Label;
		private var _btnClear:PushButton;
		private var _btnSaveImage:PushButton;

		public function GuiBrushPanel()
		{
			super();
			this.mouseEnabled = false;
			if (stage)
				init();
			else
				addEventListener(Event.ADDED_TO_STAGE, init);
		}

		private function init(e:Event = null):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
		}

		private function createComponents():void
		{
			//TODO: Position everything in a grid-system, based on stageSize and uiScale...

			_sldElasticity = new HUISlider(this);
			_sldElasticity.label = Strings.LBL_ELASTICITY;
			_sldElasticity.addEventListener(Event.CHANGE, onElasticityChanged);
			_sldElasticity.setSliderParams(Constants.ELASTICITY_MIN, Constants.ELASTICITY_MAX, Constants.ELASTICITY_DEFAULT);
			_sldElasticity.labelPrecision = 2;
			_sldElasticity.tick = 0.01;

			_sldStrength = new HUISlider(this);
			_sldStrength.label = Strings.LBL_STRENGTH;
			_sldStrength.addEventListener(Event.CHANGE, onStrengthChanged);
			_sldStrength.setSliderParams(Constants.STRENGTH_MIN, Constants.STRENGTH_MAX, Constants.STRENGTH_DEFAULT);
			_sldStrength.labelPrecision = 3;
			_sldStrength.tick = 0.001;

			_sldStrengthDegradation = new HUISlider(this);
			_sldStrengthDegradation.label = Strings.LBL_STRENGTH_DEGR;
			_sldStrengthDegradation.addEventListener(Event.CHANGE, onStrengthDegradationChanged);
			_sldStrengthDegradation.setSliderParams(Constants.DEGRADATION_MIN, Constants.DEGRADATION_MAX, Constants.DEGRADATION_DEFAULT);
			_sldStrengthDegradation.labelPrecision = 2;
			_sldStrengthDegradation.tick = 0.01;

			_lblAlphaImage = new Label(this, 0, 0, Strings.LBL_ALPHA_IMG);

			_cmbAlphaImage = new ComboBox(this);
			for each (var img:ImageWithLabel in AlphaImages.getAll())
			{
				_cmbAlphaImage.addItem(img.label);
			}
			_cmbAlphaImage.selectedIndex = 0;
			_cmbAlphaImage.numVisibleItems = AlphaImages.getAll().length;
			_cmbAlphaImage.addEventListener(Event.SELECT, onAlphaImageChanged);

			_sldOpacity = new HUISlider(this);
			_sldOpacity.addEventListener(Event.CHANGE, onOpacityChanged);
			_sldOpacity.setSliderParams(0, 1, Constants.BRUSH_OPACITY_DEFAULT);
			_sldOpacity.labelPrecision = 2;
			_sldOpacity.tick = 0.01;

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
		}

		//-- Brush settings handlers...
		protected function onNumLinksChanged(e:Event):void
		{
			BrushModel.instance.brushNumLinks = _stpNumLinks.value;
		}

		protected function onElasticityChanged(e:Event):void
		{
			BrushModel.instance.brushElasticity = _sldElasticity.value;
		}

		protected function onStrengthChanged(e:Event):void
		{
			BrushModel.instance.brushStrength = _sldStrength.value;
		}

		protected function onStrengthDegradationChanged(e:Event):void
		{
			BrushModel.instance.brushDegradation = _sldStrengthDegradation.value;
		}

		protected function onColorChanged(e:Event):void
		{
			BrushModel.instance.brushColor = _colorPicker.value;
		}

		protected function onOpacityChanged(e:Event):void
		{
			BrushModel.instance.brushOpacity = _sldOpacity.value;
		}

		protected function onBlendModeChanged(e:Event):void
		{
			BrushModel.instance.brushBlendMode = String(_cmbBlendMode.selectedItem);
		}

		protected function onAlphaImageChanged(e:Event):void
		{
			BrushModel.instance.brushAlphaImageIndex = _cmbAlphaImage.selectedIndex;
		}

		protected function onDebugChanged(e:Event):void
		{
			AppModel.instance.debugDraw = _chkDebug.selected;
		}
	}
}
