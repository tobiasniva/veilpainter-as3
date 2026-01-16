package view
{
	import com.bit101.components.NumericStepper;
	import flash.events.Event;
	import core.AppModel;
	import utils.BoundsFactory;
	import flash.utils.setTimeout;
	import com.bit101.components.ColorChooser;
	import core.BrushModel;
	import data.Constants;
	import com.bit101.components.CheckBox;
	import data.Strings;

	public class GuiAppSettings extends GuiBase implements ILayout
	{
		private var _stpUiScale:NumericStepper;
		private var _stpChainLinkSize:NumericStepper;
		private var _colorpickerChainLink:ColorChooser;
		private var _chkDebugBounds:CheckBox;

		public function GuiAppSettings()
		{
			super();
		}

		override protected function onInit():void
		{
			// -- components...

			//TODO: Label?
			_stpUiScale = new NumericStepper(this);
			_stpUiScale.addEventListener(Event.CHANGE, onUiScaleChanged);
			_stpUiScale.step = 1;
			_stpUiScale.minimum = 1;
			_stpUiScale.value = AppModel.instance.uiScale;
			_stpUiScale.maximum = 4;

			_colorpickerChainLink = new ColorChooser(this, 0, 0, BrushModel.instance.brushLinkColor, onChainLinkColorChanged);
			_colorpickerChainLink.usePopup = true;
			_colorpickerChainLink.popupAlign = ColorChooser.BOTTOM_RIGHT;

			_stpChainLinkSize = new NumericStepper(this);
			_stpChainLinkSize.addEventListener(Event.CHANGE, onChainLinkSizeChanged);
			_stpChainLinkSize.step = 2;
			_stpChainLinkSize.minimum = Constants.CHAIN_LINK_SIZE_MIN;
			_stpChainLinkSize.value = BrushModel.instance.brushLinkSize;
			_stpChainLinkSize.maximum = Constants.CHAIN_LINK_SIZE_MAX;

			_chkDebugBounds = new CheckBox(this, 0, 0, Strings.LBL_DEBUG_BOUNDS, onDebugBoundsChanged);
			_chkDebugBounds.selected = AppModel.instance.debugBounds;
		}

		public function layout(w:int, h:int, gridSize:int):void
		{
			if (AppModel.instance.debugBounds)
				BoundsFactory.drawBounds(this, w, h, 0x00ffff, 0.0); // cyan

			var uiscale:int = AppModel.instance.uiScale;

			var yOff:int = gridSize;

			// TODO: position components...
			_stpChainLinkSize.x = gridSize;
			_stpChainLinkSize.y = gridSize;

			_colorpickerChainLink.x = w - (_colorpickerChainLink.width + gridSize + (uiscale * 5)); // Hack to line colorbox up...
			_colorpickerChainLink.y = yOff;

			yOff += gridSize * uiscale; // incr yOff

			_stpUiScale.x = gridSize;
			_stpUiScale.y = yOff;

			yOff += gridSize * uiscale;

			_chkDebugBounds.x = w - _chkDebugBounds.width - gridSize;
			_chkDebugBounds.y = yOff;
		}

		// -- App settings handlers...
		private function onUiScaleChanged(e:Event):void
		{
			trace("uiscale: " + _stpUiScale.value);

			setTimeout(function():void
				{
					AppModel.instance.uiScale = _stpUiScale.value;
				}, 150);
		}

		private function onChainLinkSizeChanged(event:Event):void
		{
			BrushModel.instance.brushLinkSize = _stpChainLinkSize.value;
		}

		private function onChainLinkColorChanged(event:Event):void
		{
			BrushModel.instance.brushLinkColor = _colorpickerChainLink.value;
		}

		private function onDebugBoundsChanged(event:Event):void
		{
			AppModel.instance.debugBounds = _chkDebugBounds.selected;
		}
	}
}