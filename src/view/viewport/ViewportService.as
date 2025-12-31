package view.viewport
{
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.StageOrientationEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;

	import event.ViewportChangedEvent;

	public final class ViewportService extends EventDispatcher
	{
		private var _stage:Stage;
		private var _getSafeArea:Function;

		private var _lastW:int = -1;
		private var _lastH:int = -1;

		public function ViewportService(stage:Stage, getSafeArea:Function)
		{
			_stage = stage;
			_getSafeArea = getSafeArea;
		}

		public function start(dispatchInitial:Boolean = true):void
		{
			_stage.addEventListener(Event.RESIZE, onMaybeChanged);
			_stage.addEventListener(StageOrientationEvent.ORIENTATION_CHANGE, onMaybeChanged);

			if (dispatchInitial)
				updateAndDispatch(true);
		}

		public function stop():void
		{
			_stage.removeEventListener(Event.RESIZE, onMaybeChanged);
			_stage.removeEventListener(StageOrientationEvent.ORIENTATION_CHANGE, onMaybeChanged);
		}

		private function onMaybeChanged(e:Event):void
		{
			updateAndDispatch(false);
		}

		private function updateAndDispatch(force:Boolean):void
		{
			var p:Point = _getSafeArea() as Point;
			if (!p) return;

			var w:int = int(p.x);
			var h:int = int(p.y);

			if (!force && w == _lastW && h == _lastH)
				return;

			_lastW = w;
			_lastH = h;

			// Wrap Point into Rectangle ONLY for the event - since your event expects Rectangle...
			dispatchEvent(new ViewportChangedEvent(new Rectangle(0, 0, w, h)));
		}
	}
}
