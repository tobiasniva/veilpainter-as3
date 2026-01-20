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
	import events.UIEvent;
	import flash.events.MouseEvent;

	public class GuiNavbar extends GuiBase implements ILayout
	{
		private var _btnBrushSettings:PushButton;
		private var _btnCanvasSettings:PushButton;
		private var _btnSettings:PushButton;
		private var _btnClear:PushButton;
		private var _btnSaveImage:PushButton;

		// -- public for outside layout use...
		private var _btnSize:int;
		public function get btnSize():int
		{
			return _btnSize;
		}

		public function GuiNavbar()
		{
			super();
		}

		override protected function onInit():void
		{
			// -- We make navbar icon buttons slightly larger than normal ui elements...
			_btnSize = (Constants.UI_MAGIC_SIZE_NUMBER * 1.5) * AppModel.instance.uiScale;

			_btnBrushSettings = new PushButton(this, 0, 0, Strings.LBL_BRUSH);
			_btnCanvasSettings = new PushButton(this, 0, 0, Strings.LBL_CANVAS);
			_btnSettings = new PushButton(this, 0, 0, Strings.LBL_SETTINGS);
			_btnClear = new PushButton(this, 0, 0, Strings.LBL_CLEAR, onClearCanvas);
			_btnSaveImage = new PushButton(this, 0, 0, Strings.LBL_SAVE, onSaveImageToDesktop);

			// -- support toggle state in buttons
			_btnBrushSettings.toggle = true;
			_btnCanvasSettings.toggle = true;
			_btnSettings.toggle = true;

			_btnBrushSettings.addEventListener(MouseEvent.CLICK, function(e:*):void
				{
					onSelect(0);
				});
			_btnCanvasSettings.addEventListener(MouseEvent.CLICK, function(e:*):void
				{
					onSelect(1);
				});
			_btnSettings.addEventListener(MouseEvent.CLICK, function(e:*):void
				{
					onSelect(2);
				});
		}

		public function layout(w:int, h:int, gridSize:int):void
		{
			if (AppModel.instance.debugBounds)
				BoundsFactory.drawBounds(this, w, h, 0xff0000, 0.0); // red

			// -- Position and scaling...
			_btnBrushSettings.x = gridSize;
			_btnBrushSettings.y = gridSize;
			_btnBrushSettings.width = _btnSize;
			_btnBrushSettings.height = _btnSize;

			_btnCanvasSettings.x = _btnBrushSettings.x + _btnSize + gridSize;
			_btnCanvasSettings.y = gridSize;
			_btnCanvasSettings.width = _btnSize;
			_btnCanvasSettings.height = _btnSize;

			_btnSettings.x = _btnCanvasSettings.x + _btnSize + gridSize;
			_btnSettings.y = gridSize;
			_btnSettings.width = _btnSize;
			_btnSettings.height = _btnSize;

			_btnClear.x = _btnSettings.x + _btnSize + gridSize;
			_btnClear.y = gridSize;
			_btnClear.width = _btnSize;
			_btnClear.height = _btnSize;

			_btnSaveImage.x = _btnClear.x + _btnSize + gridSize;
			_btnSaveImage.y = gridSize;
			_btnSaveImage.width = _btnSize;
			_btnSaveImage.height = _btnSize;
		}

		private function buttonStateFromModel():void
		{
			_btnBrushSettings.selected = (AppModel.instance.uiSelectedSettingIndex == 0);
			_btnCanvasSettings.selected = (AppModel.instance.uiSelectedSettingIndex == 1);
			_btnSettings.selected = (AppModel.instance.uiSelectedSettingIndex == 2);
		}

		private function onSelect(index:int):void
		{
			var actualIndex:int = index;

			index == AppModel.instance.uiSelectedSettingIndex ? actualIndex = -1 : actualIndex = index;

			AppModel.instance.uiSelectedSettingIndex = actualIndex;
			buttonStateFromModel();
			showSettings(actualIndex);
		}

		private function showSettings(index:int):void
		{
			switch (index)
			{
				case 0:
					AppEventBus.instance.dispatchEvent(new UIEvent(UIEvent.SHOW_BRUSH_SETTINGS));
					break;

				case 1:
				AppEventBus.instance.dispatchEvent(new UIEvent(UIEvent.SHOW_CANVAS_SETTINGS));
					break;

				case 2:
					AppEventBus.instance.dispatchEvent(new UIEvent(UIEvent.SHOW_APP_SETTINGS));
					break;

				default:
					AppEventBus.instance.dispatchEvent(new UIEvent(UIEvent.HIDE_ACTIVE));
					break;

			};
		}

		private function onClearCanvas(e:Event):void
		{
			// -- Hack just to trigger event to reset canvas...
			var col:uint = CanvasModel.instance.color;
			CanvasModel.instance.color = col;
		}

		private function onSaveImageToDesktop(e:Event):void
		{
			AppEventBus.instance.dispatchEvent(new SaveEvent(SaveEvent.SAVE_REQUESTED));
		}
	}
}
