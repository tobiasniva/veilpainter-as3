package event
{
	import flash.events.Event;

	/**
	 *
	 * COPY FROM MARBLEFALLS...
	 */
	public class AppEvent extends Event
	{
		public static const STARTUP:String 		= "AppEvent.STARTUP";
		public static const QUIT:String 		= "AppEvent.QUIT";
		public static const HW_BACK:String      = "AppEvent.HW_BACK";

		public function AppEvent(type:String):void
		{
			super(type);
		}

		override public function clone ():Event
		{
			return new AppEvent(type);
		}
	}
}