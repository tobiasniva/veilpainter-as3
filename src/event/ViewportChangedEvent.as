package event
{
	import flash.events.Event;
	import flash.geom.Rectangle;

	public class ViewportChangedEvent extends Event
	{
		public static const VIEWPORT_CHANGED:String = "viewportChanged";

		public var safeRect:Rectangle;
		public var screenW:int;
		public var screenH:int;

		public function ViewportChangedEvent(safeRect:Rectangle)
		{
			super(VIEWPORT_CHANGED, false, false);
			this.safeRect = safeRect;
			this.screenW = int(safeRect.width);
			this.screenH = int(safeRect.height);
		}

		override public function clone():Event
		{
			return new ViewportChangedEvent(safeRect.clone());
		}
	}
}
