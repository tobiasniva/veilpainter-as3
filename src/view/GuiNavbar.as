package view
{
	import com.bit101.components.ColorChooser;
	import com.bit101.components.PushButton;
	import data.Constants;
	import data.Strings;
	import flash.events.Event;
	import core.AppEventBus;
	import core.CanvasModel;
	import events.SaveEvent;
	import core.AppModel;
	import utils.BoundsFactory;

	public class GuiNavbar extends GuiBase implements ILayout
	{
		private var _colorPickerBG:ColorChooser;
		private var _btnClear:PushButton;
		private var _btnSaveImage:PushButton;

		public function GuiNavbar()
		{
			super();
		}

		override protected function onInit():void
        {
			//TODO: Should also move to canvas-settings...
			_colorPickerBG = new ColorChooser(this, 0, 0, Constants.CANVAS_COLOR_DEFAULT, onResetCanvas);
			_colorPickerBG.popupAlign = ColorChooser.TOP_LEFT;
			_colorPickerBG.usePopup = true;

			_btnClear = new PushButton(this, 0, 0, Strings.LBL_CLEAR, onResetCanvas);
			_btnSaveImage = new PushButton(this, 0, 0, Strings.LBL_SAVE, onSaveImageToDesktop);
		}

		public function layout(w:int, h:int, gridSize:int):void
		{
			if(AppModel.instance.debugBounds)
				BoundsFactory.drawBounds(this, w, h, 0xff0000);

			//TODO: Remove - will be obsolete with IconButton...
			var btnIconSquareWidth:int = Constants.UI_MAGIC_SIZE_NUMBER * AppModel.instance.uiScale;

			//-- Position and scaling...
			_btnClear.x = gridSize;
			_btnClear.y = gridSize;
			_btnClear.width = btnIconSquareWidth;

			_btnSaveImage.x = _btnClear.x + _btnClear.width + gridSize;
			_btnSaveImage.y = gridSize;
			_btnSaveImage.width = btnIconSquareWidth;

			_colorPickerBG.x = _btnSaveImage.x + _btnSaveImage.width + gridSize;
			_colorPickerBG.y = gridSize;
		}

		//TODO: Figure out after canvas-gui is added...
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
