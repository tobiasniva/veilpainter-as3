package view
{
	import behavior.ImageWithLabel;
	import com.bit101.components.CheckBox;
	import com.bit101.components.ColorChooser;
	import com.bit101.components.ComboBox;
	import com.bit101.components.Label;
	import com.bit101.components.NumericStepper;
	import com.bit101.components.PushButton;
	import core.BrushModel;
	import data.AlphaImages;
	import data.BlendModes;
	import data.Constants;
	import data.Strings;
	import flash.events.Event;
	import core.AppModel;
	import ui.components.LabeledHSlider;

	public class GuiBrushSettings extends GuiBase implements ILayout
	{
		private var _sldElasticity:LabeledHSlider;
		private var _sldStrength:LabeledHSlider;
		private var _sldStrengthDegradation:LabeledHSlider;
		private var _sldOpacity:LabeledHSlider;

		private var _stpNumLinks:NumericStepper;
		private var _cmbAlphaImage:ComboBox;
		private var _cmbBlendMode:ComboBox;
		private var _colorPicker:ColorChooser;
		private var _chkDebugDraw:CheckBox;

		private var _lblAlphaImage:Label;
		private var _lblNumLinks:Label;
		private var _lblBlendModes:Label;
		private var _btnClear:PushButton;
		private var _btnSaveImage:PushButton;

		private var _panel:GuiPanel;

		public function GuiBrushSettings()
		{
			super();
		}

		override protected function onInit():void
        {
			_sldElasticity = new LabeledHSlider(this);
			_sldElasticity.label = Strings.LBL_ELASTICITY;
			_sldElasticity.addEventListener(Event.CHANGE, onElasticityChanged);
			_sldElasticity.setSliderParams(Constants.ELASTICITY_MIN, Constants.ELASTICITY_MAX, BrushModel.instance.brushElasticity);
			_sldElasticity.labelPrecision = 2;
			_sldElasticity.tick = 0.01;

			_sldStrength = new LabeledHSlider(this);
			_sldStrength.label = Strings.LBL_STRENGTH;
			_sldStrength.addEventListener(Event.CHANGE, onStrengthChanged);
			_sldStrength.setSliderParams(Constants.STRENGTH_MIN, Constants.STRENGTH_MAX, BrushModel.instance.brushStrength);
			_sldStrength.labelPrecision = 3;
			_sldStrength.tick = 0.001;

			_sldStrengthDegradation = new LabeledHSlider(this);
			_sldStrengthDegradation.label = Strings.LBL_STRENGTH_DEGR;
			_sldStrengthDegradation.addEventListener(Event.CHANGE, onStrengthDegradationChanged);
			_sldStrengthDegradation.setSliderParams(Constants.DEGRADATION_MIN, Constants.DEGRADATION_MAX, BrushModel.instance.brushDegradation);
			_sldStrengthDegradation.labelPrecision = 2;
			_sldStrengthDegradation.tick = 0.01;

			// _lblAlphaImage = new Label(this, 0, 0, Strings.LBL_ALPHA_IMG);
			_cmbAlphaImage = new ComboBox(this);
			for each (var img:ImageWithLabel in AlphaImages.getAll())
			{
				_cmbAlphaImage.addItem(img.label);
			}
			_cmbAlphaImage.selectedIndex = BrushModel.instance.brushAlphaImageIndex;
			_cmbAlphaImage.numVisibleItems = AlphaImages.getAll().length;
			_cmbAlphaImage.addEventListener(Event.SELECT, onAlphaImageChanged);

			_sldOpacity = new LabeledHSlider(this);
			_sldOpacity.label = Strings.LBL_OPACITY;
			_sldOpacity.addEventListener(Event.CHANGE, onOpacityChanged);
			_sldOpacity.setSliderParams(0, 1, BrushModel.instance.brushOpacity);
			_sldOpacity.labelPrecision = 2;
			_sldOpacity.tick = 0.01;

			// _lblNumLinks = new Label(this, 0, 0, Strings.LBL_NUM_LINKS);
			_stpNumLinks = new NumericStepper(this);
			_stpNumLinks.addEventListener(Event.CHANGE, onNumLinksChanged);
			_stpNumLinks.step = Constants.NUM_LINKS_STEP;
			_stpNumLinks.minimum = Constants.NUM_LINKS_MIN;
			_stpNumLinks.value = BrushModel.instance.brushNumLinks;
			_stpNumLinks.maximum = Constants.NUM_LINKS_MAX;

			_chkDebugDraw = new CheckBox(this, 0, 0, Strings.LBL_DEBUG, onDebugChanged);
			_chkDebugDraw.selected = AppModel.instance.debugDraw;

			// _lblBlendModes = new Label(this, 0, 0, Strings.LBL_BLENDMODE);
			var blendModesAll:Array = BlendModes.getAll(); //TODO: According to AppModel-settings Compact/Standard/Extended...
			_cmbBlendMode = new ComboBox(this, 0, 0, "", blendModesAll);
			_cmbBlendMode.numVisibleItems = blendModesAll.length;
			_cmbBlendMode.selectedIndex = BrushModel.instance.brushBlendModeIndex;
			_cmbBlendMode.addEventListener(Event.SELECT, onBlendModeChanged);

			_colorPicker = new ColorChooser(this, 0, 0, BrushModel.instance.brushColor, onColorChanged);
			_colorPicker.usePopup = true;
			_colorPicker.popupAlign = ColorChooser.BOTTOM_RIGHT;

			_panel = new GuiPanel();
			addChildAt(_panel, 0);
		}

		public function layout(w:int, h:int, gridSize:int):void
		{
			var uiscale:int = AppModel.instance.uiScale;

			var yOff:int = gridSize;
			var halfX:int = gridSize * 12;
			var halfW:int = gridSize * 13;
			var fullSldW:int = gridSize * 22;

			//-- 1st row
			_cmbBlendMode.x = gridSize;
			_cmbBlendMode.y = gridSize;
			_cmbBlendMode.width = halfW;

			// _colorPicker.width = gridSize * 6;
			_colorPicker.x = w - (_colorPicker.width + gridSize + (uiscale * 5)); // Hack to line colorbox up...
			_colorPicker.y = gridSize;

			yOff += gridSize * uiscale; // incr yOff

			// 2nd row
			_cmbAlphaImage.x = gridSize;
			_cmbAlphaImage.y = yOff;
			_cmbAlphaImage.width = halfW;

			_stpNumLinks.width = gridSize * 6.5;
			_stpNumLinks.x = w - _stpNumLinks.width - gridSize;
			_stpNumLinks.y = yOff;

			yOff += gridSize * uiscale; // incr yOff

			// 3rd row
			_sldOpacity.x = gridSize;
			_sldOpacity.y = yOff;
			_sldOpacity.width = halfW;

			_chkDebugDraw.x = w - _chkDebugDraw.width - gridSize;
			_chkDebugDraw.y = yOff + (gridSize / 2)  * (uiscale / 4); // Hack to line up when ui-scaled...

			yOff += gridSize * uiscale; // incr yOff

			// ESD-sliders
			_sldElasticity.x = gridSize;
			_sldElasticity.y = yOff;
			_sldElasticity.width = fullSldW;

			yOff += gridSize * uiscale; // incr yOff

			_sldStrength.x = gridSize;
			_sldStrength.y = yOff;
			_sldStrength.width = fullSldW;

			yOff += gridSize * uiscale; // incr yOff

			_sldStrengthDegradation.x = gridSize;
			_sldStrengthDegradation.y = yOff;
			_sldStrengthDegradation.width = fullSldW;

			var panelH:int = yOff + _sldStrengthDegradation.height + gridSize;

			if (AppModel.instance.debugBounds)
				_panel.drawDebug(w, panelH);
			else
				_panel.draw( w, panelH);
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
			//TODO: Refactor so that not both needed to handle this state - see comment in model...
			BrushModel.instance.brushBlendModeIndex = _cmbBlendMode.selectedIndex;
			BrushModel.instance.brushBlendMode = String(_cmbBlendMode.selectedItem);
		}

		protected function onAlphaImageChanged(e:Event):void
		{
			BrushModel.instance.brushAlphaImageIndex = _cmbAlphaImage.selectedIndex;
		}

		protected function onDebugChanged(e:Event):void
		{
			AppModel.instance.debugDraw = _chkDebugDraw.selected;
		}
	}
}
