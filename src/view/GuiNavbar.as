package view
{
	import com.bit101.components.ColorChooser;
	import com.bit101.components.PushButton;
	import data.Constants;
	import data.Strings;
	import flash.display.Sprite;
	import flash.events.Event;
	import core.AppEventBus;
	import core.CanvasModel;
	import events.SaveEvent;
	import core.AppModel;

	public class GuiNavbar extends Sprite
	{
		// private var _stpSizeMultiplier:NumericStepper;
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

			createComponents();
		}

		private function init(e:Event = null):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
		}

		private function createComponents():void
		{
			//TODO: Should move to canvas-settings anyway...
			// _stpSizeMultiplier = new NumericStepper(this, 0, 0, onResetCanvas);
			// _stpSizeMultiplier.minimum = 1;
			// _stpSizeMultiplier.value = Constants.CANVAS_MULTIPLIER_DEFAULT;
			// _stpSizeMultiplier.maximum = 4;
			// _stpSizeMultiplier.width = 52;
			// _stpSizeMultiplier.enabled = false;

			//TODO: Should also move to canvas-settings...
			_colorPickerBG = new ColorChooser(this, 0, 0, Constants.CANVAS_COLOR_DEFAULT, onResetCanvas);
			_colorPickerBG.popupAlign = ColorChooser.TOP_LEFT;
			_colorPickerBG.usePopup = true;

			_btnClear = new PushButton(this, 0, 0, Strings.LBL_CLEAR, onResetCanvas);
			_btnSaveImage = new PushButton(this, 0, 0, Strings.LBL_SAVE, onSaveImageToDesktop);
		}

		public function layout(w:int, h:int, padding:int):void
		{
			debugBounds(w, h);

			var btnIconSquareWidth:int = Constants.UI_MAGIC_SIZE_NUMBER * AppModel.instance.uiScale;
			trace(btnIconSquareWidth);

			//TODO: Layout properly - scale and position based on uiScale...
			_btnClear.x = padding;
			_btnClear.y = padding;
			_btnClear.width = btnIconSquareWidth;

			_btnSaveImage.x = _btnClear.x + _btnClear.width + padding;
			_btnSaveImage.y = padding;
			_btnSaveImage.width = btnIconSquareWidth;

			_colorPickerBG.x = _btnSaveImage.x + _btnSaveImage.width + padding;
			_colorPickerBG.y = padding;
		}

		private function debugBounds(w:int, h:int):void
		{
			//-- Temp for debug visualization
			this.graphics.clear();
			this.graphics.lineStyle(1, 0xff0000);
			this.graphics.beginFill(0xff0000, 0.05);
			this.graphics.drawRect(0, 0, w - 1, h - 1);
			this.graphics.endFill();
		}

		//TODO: Figure out after canvas is refactored...
		private function onResetCanvas(e:Event):void
		{
			CanvasModel.instance.color = _colorPickerBG.value;
		}

		private function onSaveImageToDesktop(e:Event):void
		{
			AppEventBus.instance.dispatchEvent(new SaveEvent(SaveEvent.SAVE_REQUESTED));
		}
	}
}
