package view
{
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
		private var _btnBrushSettings:PushButton;
		private var _btnCanvasSettings:PushButton;
		private var _btnClear:PushButton;
		private var _btnSaveImage:PushButton;

		public function GuiNavbar()
		{
			super();
		}

		override protected function onInit():void
        {
			_btnBrushSettings = new PushButton(this, 0, 0, Strings.LBL_BRUSH, onBrushSettings);
			_btnCanvasSettings = new PushButton(this, 0, 0, Strings.LBL_CANVAS, onCanvasSettings);
			_btnClear = new PushButton(this, 0, 0, Strings.LBL_CLEAR, onClearCanvas);
			_btnSaveImage = new PushButton(this, 0, 0, Strings.LBL_SAVE, onSaveImageToDesktop);
		}

		public function layout(w:int, h:int, gridSize:int):void
		{
			if(AppModel.instance.debugBounds)
				BoundsFactory.drawBounds(this, w, h, 0xff0000);

			//TODO: Remove - will be obsolete with IconButton...
			var btnIconSquareWidth:int = Constants.UI_MAGIC_SIZE_NUMBER * AppModel.instance.uiScale;

			//-- Position and scaling...
			_btnBrushSettings.x = gridSize;
			_btnBrushSettings.y = gridSize;
			_btnBrushSettings.width = btnIconSquareWidth;
			
			_btnCanvasSettings.x = _btnBrushSettings.x + btnIconSquareWidth + gridSize;
			_btnCanvasSettings.y = gridSize;
			_btnCanvasSettings.width = btnIconSquareWidth;

			_btnClear.x = _btnCanvasSettings.x + btnIconSquareWidth + gridSize;
			_btnClear.y = gridSize;
			_btnClear.width = btnIconSquareWidth;

			_btnSaveImage.x = _btnClear.x + btnIconSquareWidth + gridSize;
			_btnSaveImage.y = gridSize;
			_btnSaveImage.width = btnIconSquareWidth;
		}

		private function onBrushSettings(e:Event):void
		{
			trace("Open BRUSH gui!");
		}

		private function onCanvasSettings(e:Event):void
		{
			trace("Open CANVAS gui!");
		}

		private function onClearCanvas(e:Event):void
		{
			//-- Hack just to trigger event to reset canvas...
			var col:uint = CanvasModel.instance.color;
			CanvasModel.instance.color = col;
		}

		private function onSaveImageToDesktop(e:Event):void
		{
			AppEventBus.instance.dispatchEvent(new SaveEvent(SaveEvent.SAVE_REQUESTED));
		}
	}
}
