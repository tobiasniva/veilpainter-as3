package view
{
	import com.bit101.components.ColorChooser;
	import com.bit101.components.NumericStepper;
	import com.bit101.components.PushButton;
	import data.Constants;
	import data.Strings;
	import flash.display.Sprite;
	import flash.events.Event;
	import core.AppEventBus;
	import core.CanvasModel;
	import events.SaveEvent;

	public class GuiNavbar extends Sprite
	{
		private var _stpSizeMultiplier:NumericStepper;
		private var _colorPickerBG:ColorChooser;
		private var _btnClear:PushButton;
		private var _btnSaveImage:PushButton;

		public function GuiNavbar()
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
			_stpSizeMultiplier = new NumericStepper(this, 0, 0, onResetCanvas);
			_stpSizeMultiplier.minimum = 1;
			_stpSizeMultiplier.value = Constants.CANVAS_MULTIPLIER_DEFAULT;
			_stpSizeMultiplier.maximum = 4;
			_stpSizeMultiplier.width = 52;
			_stpSizeMultiplier.enabled = false; // TODO: Enable when implemented

			_colorPickerBG = new ColorChooser(this, 0, 0, Constants.CANVAS_COLOR_DEFAULT, onResetCanvas);
			_colorPickerBG.usePopup = true;

			_btnClear = new PushButton(this, 0, 0, Strings.LBL_CLEAR, onResetCanvas);
			_btnSaveImage = new PushButton(this, 0, 0, Strings.LBL_SAVE, onSaveImageToDesktop);
		}

		//TODO: Figure out after canvas is refactored...
		protected function onResetCanvas(e:Event):void
		{
			CanvasModel.instance.color = _colorPickerBG.value;
		}
		protected function onSaveImageToDesktop(e:Event):void
		{
			AppEventBus.instance.dispatchEvent(new SaveEvent(SaveEvent.SAVE_REQUESTED));
		}
	}
}
