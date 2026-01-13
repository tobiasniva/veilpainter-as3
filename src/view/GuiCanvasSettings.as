package view
{
	import com.bit101.components.ColorChooser;
	import com.bit101.components.NumericStepper;
	import data.Constants;
	import flash.events.Event;
	import core.AppModel;
	import utils.BoundsFactory;
	import core.CanvasModel;

	public class GuiCanvasSettings extends GuiBase implements ILayout
	{
		private var _colorPickerBG:ColorChooser;
		private var _stpSizeMultiplier:NumericStepper;

		public function GuiCanvasSettings()
		{
			super();
		}

		override protected function onInit():void
        {
			_stpSizeMultiplier = new NumericStepper(this);
			_stpSizeMultiplier.addEventListener(Event.CHANGE, onSizeMultiplierChanged);
			_stpSizeMultiplier.minimum = 1;
			_stpSizeMultiplier.value = 1;
			_stpSizeMultiplier.maximum = 4;

			_colorPickerBG = new ColorChooser(this, 0, 0, Constants.CANVAS_COLOR_DEFAULT, onResetCanvas);
			_colorPickerBG.popupAlign = ColorChooser.TOP_LEFT;
			_colorPickerBG.usePopup = true;
		}

		public function layout(w:int, h:int, gridSize:int):void
		{
			if(AppModel.instance.debugBounds)
				BoundsFactory.drawBounds(this, w, h, 0x0000ff);

			var uiscale:int = AppModel.instance.uiScale;

			var yOff:int = AppModel.instance.uiScale * gridSize;
			var margin:int = gridSize * 2; // margin from left/top...
			var halfX:int = gridSize * 16;
			var halfW:int = gridSize * 13;
			var fullSldW:int = gridSize * 33 + (gridSize / uiscale);

			//TODO: position components...

		}


		//-- Canvas settings handlers...
		private function onSizeMultiplierChanged(e:Event):void
		{
			CanvasModel.instance.multiplier = _stpSizeMultiplier.value;
		}

		private function onResetCanvas(e:Event):void
		{
			CanvasModel.instance.color = _colorPickerBG.value;
		}
	}
}