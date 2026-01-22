package view
{
	import data.Constants;
	import flash.events.Event;
	import core.AppEventBus;
	import core.CanvasModel;
	import events.SaveEvent;
	import core.AppModel;
	import data.SettingsViewActive;
	import ui.components.IconPushButton;
	import data.IconImages;

	public class GuiNavbar extends GuiBase implements ILayout
	{
		private var _btnBrushSettings:IconPushButton;
		private var _btnCanvasSettings:IconPushButton;
		private var _btnAppSettings:IconPushButton;
		private var _btnClear:IconPushButton;
		private var _btnSaveImage:IconPushButton;
		private var _panel:GuiPanel;

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

			_btnBrushSettings = new IconPushButton(this, 0, 0, null, onBrushSettings);
			_btnBrushSettings.icon = IconImages.iconBrush();
			_btnCanvasSettings = new IconPushButton(this, 0, 0, null, onCanvasSettings);
			_btnCanvasSettings.icon = IconImages.iconCanvas();
			_btnAppSettings = new IconPushButton(this, 0, 0, null, onAppSettings);
			_btnAppSettings.icon = IconImages.iconSettings();
			_btnClear = new IconPushButton(this, 0, 0, null, onClearCanvas);
			_btnClear.icon = IconImages.iconDelete();
			_btnSaveImage = new IconPushButton(this, 0, 0, null, onSaveImageToDesktop);
			_btnSaveImage.icon = IconImages.iconSave();

			// -- support toggle state in buttons
			_btnBrushSettings.toggle = true;
			_btnCanvasSettings.toggle = true;
			_btnAppSettings.toggle = true;

			_panel = new GuiPanel();
			addChildAt(_panel, 0);
		}

		public function layout(w:int, h:int, gridSize:int):void
		{
			// -- Position/scale components...
			_btnBrushSettings.x = gridSize;
			_btnBrushSettings.y = gridSize;
			_btnBrushSettings.width = _btnSize;
			_btnBrushSettings.height = _btnSize;

			_btnCanvasSettings.x = _btnBrushSettings.x + _btnSize + gridSize;
			_btnCanvasSettings.y = gridSize;
			_btnCanvasSettings.width = _btnSize;
			_btnCanvasSettings.height = _btnSize;

			_btnAppSettings.x = _btnCanvasSettings.x + _btnSize + gridSize;
			_btnAppSettings.y = gridSize;
			_btnAppSettings.width = _btnSize;
			_btnAppSettings.height = _btnSize;

			_btnClear.x = _btnAppSettings.x + _btnSize + gridSize;
			_btnClear.y = gridSize;
			_btnClear.width = _btnSize;
			_btnClear.height = _btnSize;

			_btnSaveImage.x = _btnClear.x + _btnSize + gridSize;
			_btnSaveImage.y = gridSize;
			_btnSaveImage.width = _btnSize;
			_btnSaveImage.height = _btnSize;

			updateButtonStates();

			_panel.renderDebugOnly(AppModel.instance.debugBounds, w, h);
		}

		private function onShowSettings(index:int):void
		{
			var activeView:int = index;
			index == AppModel.instance.uiActiveSettingView ? activeView = SettingsViewActive.NONE : activeView = index;
			AppModel.instance.uiActiveSettingView = activeView;
			updateButtonStates();
		}

		private function updateButtonStates():void
		{
			_btnBrushSettings.selected = (AppModel.instance.uiActiveSettingView == SettingsViewActive.BRUSH);
			_btnCanvasSettings.selected = (AppModel.instance.uiActiveSettingView == SettingsViewActive.CANVAS);
			_btnAppSettings.selected = (AppModel.instance.uiActiveSettingView == SettingsViewActive.APP);
		}

		private function onBrushSettings(e:Event):void
		{
			onShowSettings(SettingsViewActive.BRUSH);
		}

		private function onCanvasSettings(e:Event):void
		{
			onShowSettings(SettingsViewActive.CANVAS);
		}

		private function onAppSettings(e:Event):void
		{
			onShowSettings(SettingsViewActive.APP);
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
