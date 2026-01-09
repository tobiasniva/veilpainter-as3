package view
{
    import flash.display.Sprite;
    import flash.display.Bitmap;
    import flash.display.BitmapData;
    import flash.events.Event;
    import flash.geom.Point;
    import core.CanvasModel;
    import core.AppModel;
    import data.Constants;
    import core.AppEventBus;
    import events.CanvasEvent;

    public class Canvas extends Sprite
	{
		private var _bmp:Bitmap;
		private var _bmpData:BitmapData;

		public function Canvas()
		{
			super();
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}

		private function init(e:Event = null):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);

			//-- listeners
			AppEventBus.instance.addEventListener(CanvasEvent.SETTINGS_CHANGED, clearCanvas);

			//-- Init
			CanvasModel.instance.multiplier = Constants.CANVAS_MULTIPLIER_DEFAULT;

			clearCanvas();

			// addChild(_bmp);
		}


		//TODO!!! CYCLICAL DEPENDECY - canvas reset from GUI, new bitmapData set in model...
		//...that triggers this, and then we set new bmpData in model yet again!!!
		
		private function clearCanvas(e:CanvasEvent = null):void
		{
			var bmpSize:Point = AppModel.instance.stageSize;
			var canvasCol:uint = CanvasModel.instance.color;

			// Guard against invalid size (can happen during init/resizes)
			if (bmpSize.x <= 0 || bmpSize.y <= 0)
				return;

			// Dispose previous BitmapData (IMPORTANT)
			if (_bmpData)
			{
				_bmpData.dispose();
				_bmpData = null;
			}

			// Create new backing store
			_bmpData = new BitmapData(bmpSize.x, bmpSize.y, false, canvasCol);
			// CanvasModel.instance.bitmapData = _bmpData;

			// Create bitmap if needed; otherwise update existing bitmap
			if (_bmp == null)
				_bmp = new Bitmap(_bmpData);
			else
				_bmp.bitmapData = _bmpData;

			// Ensure it is on this display list (not just "has a stage")
			if (!contains(_bmp))
				addChildAt(_bmp, 0); // index 0 keeps it as background canvas
		}

    }
}