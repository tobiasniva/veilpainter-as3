package view
{
	import com.bit101.components.ColorChooser;
	import com.bit101.components.NumericStepper;
	import flash.events.Event;
	import core.AppModel;
	import utils.BoundsFactory;
	import core.CanvasModel;

	public class GuiCanvasSettings extends GuiBase implements ILayout
	{
		private var _stpSizeMultiplier:NumericStepper;
		private var _colorPickerBG:ColorChooser;

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
		}

		public function layout(w:int, h:int, gridSize:int):void
		{
			if(AppModel.instance.debugBounds)
				BoundsFactory.drawBounds(this, w, h, 0x0000ff, 0.0);

			var uiscale:int = AppModel.instance.uiScale;

			//TODO: position components...
			_stpSizeMultiplier.x = gridSize;
			_stpSizeMultiplier.y = gridSize;
			_stpSizeMultiplier.enabled = false; // Disabled for now...

			_colorPickerBG.x = w - (_colorPickerBG.width + gridSize + (uiscale * 5)); // Hack to line colorbox up...
			_colorPickerBG.y = gridSize;
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