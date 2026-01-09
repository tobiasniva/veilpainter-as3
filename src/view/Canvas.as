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
	import flash.events.MouseEvent;

	public class Canvas extends Sprite
	{
		private var _bmp:Bitmap;
		private var _bmpData:BitmapData;

		public function Canvas()
		{
			super();
			if (stage)
				init();
			else
				addEventListener(Event.ADDED_TO_STAGE, init);
		}

		private function init(e:Event = null):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			AppEventBus.instance.addEventListener(CanvasEvent.SETTINGS_CHANGED, clearCanvas);
			CanvasModel.instance.multiplier = Constants.CANVAS_MULTIPLIER_DEFAULT;

			//-- Mouse/touch to detect input for toggle stuff (e.g. drawing)
			addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
			//NOTE! stage - to end touch also outside of screen (desktop)
			stage.addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
		}

		private function onMouseDown(e:MouseEvent):void
		{
			// trace("touch start!");
			AppEventBus.instance.dispatchEvent(new CanvasEvent(CanvasEvent.TOUCH_START));
		}

		private function onMouseUp(e:MouseEvent):void
		{
			// trace("touch end...");
			AppEventBus.instance.dispatchEvent(new CanvasEvent(CanvasEvent.TOUCH_END));
		}

		private function clearCanvas(e:CanvasEvent = null):void
		{
			var bmpSize:Point = AppModel.instance.stageSize;
			var canvasCol:uint = CanvasModel.instance.color;

			// Guard against invalid size (can happen during init/resizes)
			if (bmpSize.x <= 0 || bmpSize.y <= 0)
				return;

			// Dispose previous...
			if (_bmpData)
			{
				_bmpData.dispose();
				_bmpData = null;
			}

			// Create new...
			_bmpData = new BitmapData(bmpSize.x, bmpSize.y, false, canvasCol);
			CanvasModel.instance.bitmapData = _bmpData;

			// Create bitmap if needed - otherwise update existing...
			if (_bmp == null)
				_bmp = new Bitmap(_bmpData);
			else
				_bmp.bitmapData = _bmpData;

			// Add to displaylist...
			if (!contains(_bmp))
				addChildAt(_bmp, 0);

			trace("Canvas created - size: " + bmpSize + ", color: " + canvasCol);
		}
	}
}