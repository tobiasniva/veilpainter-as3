package event
{
	import flash.events.Event;

	public class MiscEvent extends Event
	{
		public static const DUMMY_EVENT:String   = "MiscEvent.DUMMY_EVENT";

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