package view
{
	import com.bit101.components.NumericStepper;
	import flash.events.Event;
	import core.AppModel;
	import flash.utils.setTimeout;
	import com.bit101.components.ColorChooser;
	import core.BrushModel;
	import data.Constants;
	import com.bit101.components.CheckBox;
	import data.Strings;
	import com.bit101.components.ComboBox;
	import data.AlignHorizontal;
	import data.AlignVertical;
	import ui.components.IconPushButton;
	import data.IconImages;
	import ui.components.LabeledHSlider;

	public class GuiAppSettings extends GuiBase implements ILayout
	{
		private var _stpUiScale:NumericStepper;
		private var _stpChainLinkSize:NumericStepper;
		private var _colorpickerChainLink:ColorChooser;
		private var _chkDebugBounds:CheckBox;
		private var _cmbAlignH:ComboBox;
		private var _cmbAlignV:ComboBox;

		private var _btnIconTEMP:IconPushButton;
		private var _sldTEMP:LabeledHSlider;

		private var _panel:GuiPanel;

		public function GuiAppSettings()
		{
			super();
		}

		override protected function onInit():void
		{
			// -- components...

			// TODO: Label?
			_stpUiScale = new NumericStepper(this);
			_stpUiScale.addEventListener(Event.CHANGE, onUiScaleChanged);
			_stpUiScale.step = 1;
			_stpUiScale.minimum = 1;
			_stpUiScale.value = AppModel.instance.uiScale;
			_stpUiScale.maximum = 4;

			_colorpickerChainLink = new ColorChooser(this, 0, 0, BrushModel.instance.brushLinkColor, onChainLinkColorChanged);
			_colorpickerChainLink.usePopup = true;

			_stpChainLinkSize = new NumericStepper(this);
			_stpChainLinkSize.addEventListener(Event.CHANGE, onChainLinkSizeChanged);
			_stpChainLinkSize.step = 2;
			_stpChainLinkSize.minimum = Constants.CHAIN_LINK_SIZE_MIN;
			_stpChainLinkSize.value = BrushModel.instance.brushLinkSize;
			_stpChainLinkSize.maximum = Constants.CHAIN_LINK_SIZE_MAX;

			_chkDebugBounds = new CheckBox(this, 0, 0, Strings.LBL_DEBUG_BOUNDS, onDebugBoundsChanged);
			_chkDebugBounds.selected = AppModel.instance.debugBounds;

			_cmbAlignH = new ComboBox(this);
			_cmbAlignH.addItem({label: Strings.LBL_LEFT, value: AlignHorizontal.LEFT});
			_cmbAlignH.addItem({label: Strings.LBL_CENTER, value: AlignHorizontal.CENTER});
			_cmbAlignH.addItem({label: Strings.LBL_RIGHT, value: AlignHorizontal.RIGHT});
			_cmbAlignH.selectedIndex = AppModel.instance.uiAlignH;
			_cmbAlignH.numVisibleItems = 3;
			_cmbAlignH.addEventListener(Event.SELECT, onAlignHorizontalChanged);

			_cmbAlignV = new ComboBox(this);
			_cmbAlignV.addItem({label: Strings.LBL_TOP, value: AlignVertical.TOP});
			_cmbAlignV.addItem({label: Strings.LBL_BOTTOM, value: AlignVertical.BOTTOM});
			_cmbAlignV.selectedIndex = AppModel.instance.uiAlignV;
			_cmbAlignV.numVisibleItems = 2;
			_cmbAlignV.addEventListener(Event.SELECT, onAlignVerticalChanged);

			//TODO: TEMPS!
			_btnIconTEMP = new IconPushButton(this);
			_btnIconTEMP.icon = IconImages.iconTest();
			_btnIconTEMP.iconPosition = IconPushButton.ICON_ONLY;

			_sldTEMP = new LabeledHSlider(this, 0, 0, "Test", 0.0, onTempSliderChanged);
			_sldTEMP.minimum = 0.05;
			_sldTEMP.maximum = 0.95;
			_sldTEMP.value = 0.45;


			_panel = new GuiPanel();
			addChildAt(_panel, 0);
		}

		public function layout(w:int, h:int, gridSize:int):void
		{
			var uiscale:int = AppModel.instance.uiScale;

			var yOff:int = gridSize;
			var halfW:int = gridSize * 10;

			// TODO: position components...
			_stpChainLinkSize.x = gridSize;
			_stpChainLinkSize.y = gridSize;

			var popupAlign:String = (AppModel.instance.uiAlignV == AlignVertical.TOP) ? ColorChooser.BOTTOM_RIGHT : ColorChooser.TOP_RIGHT;
			_colorpickerChainLink.popupAlign = popupAlign;
			_colorpickerChainLink.x = w - (_colorpickerChainLink.width + gridSize + (uiscale * 5)); // Hack to line colorbox up...
			_colorpickerChainLink.y = yOff;

			yOff += gridSize * uiscale; // incr yOff

			_stpUiScale.x = gridSize;
			_stpUiScale.y = yOff;

			_chkDebugBounds.x = w - _chkDebugBounds.width - gridSize;
			_chkDebugBounds.y = yOff;

			yOff += gridSize * uiscale; // incr yOff

			_cmbAlignH.x = gridSize;
			_cmbAlignH.y = yOff;
			_cmbAlignH.width = halfW;

			_cmbAlignV.x = w - halfW - gridSize;
			_cmbAlignV.y = yOff;
			_cmbAlignV.width = halfW;

			//TODO: TEMP IconPushButton tests!
			yOff += gridSize * uiscale; // incr yOff

			_sldTEMP.x = gridSize;
			_sldTEMP.y = yOff;
			_sldTEMP.width = gridSize * 10;

			_btnIconTEMP.width = _btnIconTEMP.height;
			_btnIconTEMP.x = w - _btnIconTEMP.width - gridSize;
			_btnIconTEMP.y = yOff;


			var panelH:int = yOff + _cmbAlignV.height + gridSize;

			if (AppModel.instance.debugBounds)
				_panel.drawDebug(w, panelH);
			else
				_panel.draw( w, panelH);
		}

		// TODO: Temp stuff - remove...
		private function onTempSliderChanged(e:Event):void
		{
			// trace("tmp sld: " +  _sldTEMP.value);
		}

		// -- App settings handlers...
		private function onUiScaleChanged(e:Event):void
		{
			// TODO: Hack to avoid racing when views are removed before re-added...
			setTimeout(function():void
				{
					AppModel.instance.uiScale = _stpUiScale.value;
				}, 150);
		}

		private function onChainLinkSizeChanged(e:Event):void
		{
			BrushModel.instance.brushLinkSize = _stpChainLinkSize.value;
		}

		private function onChainLinkColorChanged(e:Event):void
		{
			BrushModel.instance.brushLinkColor = _colorpickerChainLink.value;
		}

		private function onDebugBoundsChanged(e:Event):void
		{
			AppModel.instance.debugBounds = _chkDebugBounds.selected;
		}

		private function onAlignHorizontalChanged(e:Event):void
		{
			AppModel.instance.uiAlignH = _cmbAlignH.selectedIndex;
		}

		private function onAlignVerticalChanged(e:Event):void
		{
			AppModel.instance.uiAlignV = _cmbAlignV.selectedIndex;
		}
	}
}