package event
{
	import flash.events.Event;

	public class MiscEvent extends Event
	{
		public static const SAVE_IMAGE:String = "MiscEvent.SAVE_IMAGE";

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