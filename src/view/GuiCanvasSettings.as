package view
{
	import com.bit101.components.ColorChooser;
	import com.bit101.components.NumericStepper;
	import flash.events.Event;
	import core.AppModel;
	import core.CanvasModel;
	import data.AlignVertical;
	import ui.components.IconPushButton;
	import data.IconImages;

	public class GuiCanvasSettings extends GuiBase implements ILayout
	{
		private var _stpSizeMultiplier:NumericStepper;
		private var _colorPickerBG:ColorChooser;
		private var _btnClear:IconPushButton;
		private var _panel:GuiPanel;

		public function GuiCanvasSettings()
		{
			super();
		}

		override protected function onInit():void
        {
			_stpSizeMultiplier = new NumericStepper(this);
			_stpSizeMultiplier.addEventListener(Event.CHANGE, onSizeMultiplierChanged);
			_stpSizeMultiplier.minimum = 1;
			_stpSizeMultiplier.value = CanvasModel.instance.multiplier;
			_stpSizeMultiplier.maximum = 4;

			_colorPickerBG = new ColorChooser(this, 0, 0, CanvasModel.instance.color, onCanvasColorChanged);
			_colorPickerBG.usePopup = true;

			//TODO: Somewhat temp - we always want a shortcut to clear canvas in the navbar?
			_btnClear = new IconPushButton(this, 0, 0, null, onCanvasColorChanged);
			_btnClear.icon = IconImages.iconDelete_Small();

			_panel = new GuiPanel();
			addChildAt(_panel, 0);
		}

		public function layout(w:int, h:int, gridSize:int):void
		{
			var uiscale:int = AppModel.instance.uiScale;
			var yOff:int = gridSize;
			var halfW:int = gridSize * 10;

			//TODO: position components...
			_stpSizeMultiplier.x = gridSize;
			_stpSizeMultiplier.y = yOff;
			_stpSizeMultiplier.enabled = false; // Disabled for now...

			var popupAlign:String = (AppModel.instance.uiAlignV == AlignVertical.TOP) ? ColorChooser.BOTTOM_RIGHT : ColorChooser.TOP_RIGHT;
			_colorPickerBG.popupAlign = popupAlign;
			_colorPickerBG.x = w - (_colorPickerBG.width + gridSize + (uiscale * 5)); // Hack to line colorbox up...
			_colorPickerBG.y = yOff;

			yOff += gridSize * uiscale; // incr yOff

			_btnClear.width = _btnClear.height;
			_btnClear.x = w - _btnClear.width - gridSize;
			_btnClear.y = yOff;

			var panelH:int = yOff + _btnClear.height + gridSize;

			if (AppModel.instance.debugBounds)
				_panel.drawDebug(w, panelH);
			else
				_panel.draw( w, panelH);
		}

		//-- Canvas settings handlers...
		private function onSizeMultiplierChanged(e:Event):void
		{
			CanvasModel.instance.multiplier = _stpSizeMultiplier.value;
		}

		private function onCanvasColorChanged(e:Event):void
		{
			CanvasModel.instance.color = _colorPickerBG.value;
		}
	}
}