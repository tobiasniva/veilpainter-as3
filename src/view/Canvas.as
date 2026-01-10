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
	import events.StageEvent;

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
			addEventListener(Event.REMOVED_FROM_STAGE, onRemovedFromStage);

			AppEventBus.instance.addEventListener(CanvasEvent.SETTINGS_CHANGED, clearCanvas);
			AppEventBus.instance.addEventListener(StageEvent.STAGE_SIZE_CHANGED, onStageSizeChanged);
			CanvasModel.instance.multiplier = Constants.CANVAS_MULTIPLIER_DEFAULT;

			// -- Mouse/touch to detect input for toggle stuff (e.g. drawing)
			addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
			// NOTE! stage - to end touch also outside of screen (desktop)
			stage.addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
		}

		private function onStageSizeChanged(e:StageEvent):void
		{
			clearCanvas();
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
			if (!bmpSize)
				return;

			// Sanitize to valid BitmapData ctor inputs
			var w:int = Math.ceil(bmpSize.x); // ceil avoids 0 when 0.1..0.9
			var h:int = Math.ceil(bmpSize.y);

			// BitmapData requires >= 1
			if (w < 1 || h < 1)
				return;

			// Defensive clamp (8191 is a common safe cap; adjust if you know your target supports 16383)
			if (w > 8191)
				w = 8191;
			if (h > 8191)
				h = 8191;

			var canvasCol:uint = CanvasModel.instance.color;

			if (_bmpData)
			{
				_bmpData.dispose();
				_bmpData = null;
			}

			_bmpData = new BitmapData(w, h, false, canvasCol);
			CanvasModel.instance.bitmapData = _bmpData;

			if (_bmp == null)
				_bmp = new Bitmap(_bmpData);
			else
				_bmp.bitmapData = _bmpData;

			if (!contains(_bmp))
				addChildAt(_bmp, 0);

			trace("Canvas created - size: " + bmpSize + ", color: " + canvasCol);
		}

		// -- CLEAN UP
		private function onRemovedFromStage(e:Event):void
		{
			AppEventBus.instance.removeEventListener(CanvasEvent.SETTINGS_CHANGED, clearCanvas);
			AppEventBus.instance.removeEventListener(StageEvent.STAGE_SIZE_CHANGED, onStageSizeChanged);

			removeEventListener(Event.REMOVED_FROM_STAGE, onRemovedFromStage);
			removeEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);

			if (stage)
				stage.removeEventListener(MouseEvent.MOUSE_UP, onMouseUp);
		}
	}
}