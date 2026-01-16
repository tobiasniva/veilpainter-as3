package view
{
	import com.bit101.components.NumericStepper;
	import flash.events.Event;
	import core.AppModel;
	import utils.BoundsFactory;
	import core.CanvasModel;

	public class GuiAppSettings extends GuiBase implements ILayout
	{
		private var _stpUiScale:NumericStepper;

		public function GuiAppSettings()
		{
			super();
		}

		override protected function onInit():void
        {
			//-- components...
			_stpUiScale = new NumericStepper(this, 0, 0, onUiScaleChanged);
		}

		public function layout(w:int, h:int, gridSize:int):void
		{
			if(AppModel.instance.debugBounds)
				BoundsFactory.drawBounds(this, w, h, 0x00ffff, 0.0); // cyan

			var uiscale:int = AppModel.instance.uiScale;

			var yOff:int = AppModel.instance.uiScale * gridSize;
			var margin:int = gridSize * 2; // margin from left/top...
			var halfX:int = gridSize * 16;
			var halfW:int = gridSize * 13;
			var fullSldW:int = gridSize * 33 + (gridSize / uiscale);

			//TODO: position components...

		}


		//-- App settings handlers...
		private function onUiScaleChanged(e:Event):void
		{
			AppModel.instance.uiScale = _stpUiScale.value;
		}
	}
}