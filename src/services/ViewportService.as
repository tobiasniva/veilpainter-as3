package services
{
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.StageOrientationEvent;
	import flash.geom.Point;
	import core.AppModel;

	public final class ViewportService extends EventDispatcher
	{
		private var _stage:Stage;

		private var _lastW:int = -1;
		private var _lastH:int = -1;

		public function ViewportService(stage:Stage)
		{
			_stage = stage;
			start();
		}

		public function start(dispatchInitial:Boolean = true):void
		{
			_stage.addEventListener(Event.RESIZE, onMaybeChanged);
			_stage.addEventListener(StageOrientationEvent.ORIENTATION_CHANGE, onMaybeChanged);

			if (dispatchInitial)
				updateAndDispatch(true);
		}

		private function onMaybeChanged(e:Event):void
		{
			updateAndDispatch(false);
		}

		private function updateAndDispatch(force:Boolean):void
		{
			var w:int = _stage.stageWidth;
			var h:int = _stage.stageHeight;

			if (!force && w == _lastW && h == _lastH)
				return;

			_lastW = w;
			_lastH = h;

			// Update stageSize in model = kicks off event flow for all others to react to...
			AppModel.instance.stageSize = new Point(w, h);
		}
	}
}
