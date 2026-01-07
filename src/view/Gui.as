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
	import core.AppModel;
	import data.AlphaImages;
	import data.BlendModes;
	import data.Constants;
	import data.Strings;
	import flash.display.Sprite;
	import flash.events.Event;
	import view.layout.IGuiLayout;
	import view.layout.LayoutMetrics;
	import utils.LoadAlphaImages;
	import core.AppEventBus;
	import events.DrawEvent;

	public class Gui extends Sprite
	{
		private var _parent:VeilPainter;
		private var _loadAlphaImages:LoadAlphaImages;

		// Components (same set as GuiBase)
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

		private var _lblAlphaImage:Label;
		private var _lblNumLinks:Label;
		private var _lblBlendModes:Label;
		private var _btnClear:PushButton;
		private var _btnSaveImage:PushButton;

		public function Gui(parent:VeilPainter)
		{
			super();

			_parent = parent; //TODO: Refactor so not needed...

			Style.setStyle(Style.DARK);
			this.mouseEnabled = false;

			createComponents();

			AppEventBus.instance.addEventListener(DrawEvent.DRAW_STARTED, onDrawStarted);
			AppEventBus.instance.addEventListener(DrawEvent.DRAW_ENDED, onDrawEnded);
		}

		private function createComponents():void
		{
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

			_btnClear = new PushButton(this, 0, 0, Strings.LBL_CLEAR, onResetCanvas);

			_stpSizeMultiplier = new NumericStepper(this, 0, 0, onResetCanvas);
			_stpSizeMultiplier.minimum = 1;
			_stpSizeMultiplier.value = Constants.CANVAS_MULTIPLIER_DEFAULT;
			_stpSizeMultiplier.maximum = 4;
			_stpSizeMultiplier.width = 52;

			_colorPickerBG = new ColorChooser(this, 0, 0, Constants.CANVAS_COLOR_DEFAULT, onResetCanvas);
			_colorPickerBG.usePopup = true;

			_btnSaveImage = new PushButton(this, 0, 0, Strings.LBL_SAVE, onSaveImageToDesktop);
		}

		// Call this whenever screen/orientation/scale changes
		public function applyLayout(layoutMetrics:LayoutMetrics, layout:IGuiLayout):void
		{
			layout.apply(this, layoutMetrics);
		}

		// --- Expose components for layout strategies (read-only) ---
		public function get sldElasticity():HUISlider { return _sldElasticity; }
		public function get sldStrength():HUISlider { return _sldStrength; }
		public function get sldStrengthDegradation():HUISlider { return _sldStrengthDegradation; }
		public function get sldAlpha():HUISlider { return _sldAlpha; }

		public function get stpNumLinks():NumericStepper { return _stpNumLinks; }
		public function get cmbAlphaImage():ComboBox { return _cmbAlphaImage; }
		public function get cmbBlendMode():ComboBox { return _cmbBlendMode; }
		public function get colorPicker():ColorChooser { return _colorPicker; }
		public function get colorPickerBG():ColorChooser { return _colorPickerBG; }
		public function get stpSizeMultiplier():NumericStepper { return _stpSizeMultiplier; }
		public function get chkDebug():CheckBox { return _chkDebug; }

		public function get lblAlphaImage():Label { return _lblAlphaImage; }
		public function get lblNumLinks():Label { return _lblNumLinks; }
		public function get lblBlendModes():Label { return _lblBlendModes; }
		public function get btnClear():PushButton { return _btnClear; }
		public function get btnSaveImage():PushButton { return _btnSaveImage; }

		// --- Handlers...
		private function onDrawStarted(e:DrawEvent):void
		{
			setVisibility(!AppModel.instance.uiHideOnDraw);
		}

		private function onDrawEnded(e:DrawEvent):void
		{
			setVisibility(true);
		}

		private function setVisibility(isVisible:Boolean):void
		{
			this.visible = isVisible;
		}

		protected function onResetCanvas(e:Event):void
		{
			_parent.resetCanvas();
		}

		protected function onNumLinksChanged(e:Event):void
		{
			AppModel.instance.brushNumLinks = _stpNumLinks.value;
		}

		protected function onElasticityChanged(e:Event):void
		{
			AppModel.instance.brushElasticity = _sldElasticity.value;
		}

		protected function onStrengthChanged(e:Event):void
		{
			AppModel.instance.brushStrength = _sldStrength.value;
		}

		protected function onStrengthDegradationChanged(e:Event):void
		{
			AppModel.instance.brushDegradation = _sldStrengthDegradation.value;
		}

		protected function onColorChanged(e:Event):void
		{
			AppModel.instance.brushColor = _colorPicker.value;
		}

		protected function onAlphaChanged(e:Event):void
		{
			AppModel.instance.brushAlpha = _sldAlpha.value;
		}

		protected function onBlendModeChanged(e:Event):void
		{
			AppModel.instance.brushBlendMode = String(_cmbBlendMode.selectedItem);
		}

		protected function onAlphaImageChanged(e:Event):void
		{
			AppModel.instance.brushAlphaImage = _cmbAlphaImage.selectedIndex;
		}

		protected function onDebugChanged(e:Event):void
		{
			AppModel.instance.debugDraw = _chkDebug.selected;
		}

		//TODO: Figure out after canvas is refactored...
		protected function onSaveImageToDesktop(e:Event):void
		{
			_parent.saveImage();
		}
	}
}
