package event
{
	import flash.events.Event;

	public class MiscEvent extends Event
	{
		public static const CANVAS_BMPDATA_CHANGED:String = "MiscEvent.CANVAS_BMPDATA_CHANGED";

		public function MiscEvent(type:String):void
		{
			super(type);
		}

		override public function clone ():Event
		{
			return new MiscEvent(type);
		}
	}
}