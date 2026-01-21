package view
{
	import com.bit101.components.ColorChooser;
	import com.bit101.components.NumericStepper;
	import flash.events.Event;
	import core.AppModel;
	import core.CanvasModel;
	import com.bit101.components.Panel;

	public class GuiCanvasSettings extends GuiBase implements ILayout
	{
		private var _stpSizeMultiplier:NumericStepper;
		private var _colorPickerBG:ColorChooser;
		private var _panel:Panel;

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
			_colorPickerBG.popupAlign = ColorChooser.BOTTOM_RIGHT;
			_colorPickerBG.usePopup = true;

			// _panel = new Panel(this, 0, 0);
			// _panel.alpha = 0.5;
			// _panel.mouseEnabled = false;
			// _panel.mouseChildren = false;
			// addChildAt(_panel, 0);
		}

		public function layout(w:int, h:int, gridSize:int):void
		{
			var uiscale:int = AppModel.instance.uiScale;

			//TODO: position components...
			_stpSizeMultiplier.x = gridSize;
			_stpSizeMultiplier.y = gridSize;
			_stpSizeMultiplier.enabled = false; // Disabled for now...

			_colorPickerBG.x = w - (_colorPickerBG.width + gridSize + (uiscale * 5)); // Hack to line colorbox up...
			_colorPickerBG.y = gridSize;

			// _panel.setSize(w, _colorPickerBG.height + (gridSize * 2));
			// this.scrollRect = new Rectangle(0, 0, w, _panel.height); //NOTE: Safeguard to give correct height to outside...
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