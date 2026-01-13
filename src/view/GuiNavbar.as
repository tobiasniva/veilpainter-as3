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

		public function layout(w:int, h:int, padding:int):void
		{
			debugBounds(w, h);

			//TODO: Remove - will be obsolete with IconButton...
			var btnIconSquareWidth:int = Constants.UI_MAGIC_SIZE_NUMBER * AppModel.instance.uiScale;

			//-- Position and scaling...
			_btnClear.x = padding;
			_btnClear.y = padding;
			_btnClear.width = btnIconSquareWidth;

			_btnSaveImage.x = _btnClear.x + _btnClear.width + padding;
			_btnSaveImage.y = padding;
			_btnSaveImage.width = btnIconSquareWidth;

			_colorPickerBG.x = _btnSaveImage.x + _btnSaveImage.width + padding;
			_colorPickerBG.y = padding;
		}

		//-- Temp for debug visualization
		private function debugBounds(w:int, h:int):void
		{
			this.graphics.clear();
			this.graphics.lineStyle(1, 0xff0000);
			this.graphics.beginFill(0xff0000, 0.05);
			this.graphics.drawRect(0, 0, w - 1, h - 1);
			this.graphics.endFill();
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
