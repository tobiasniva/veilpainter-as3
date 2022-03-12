package event
{
	import flash.events.Event;

	/**
	 *
	 * @author: Tobi Wan Kenobi
	 */
	public class StringEvent extends Event
	{
		public static const BRUSH_BLENDMODE_CHANGED:String     = "StringEvent.BRUSH_BLENDMODE_CHANGED";

		private var _value:String;
		
		public function StringEvent(type:String, value:String):void
		{
			_value = value;
			super(type);
		}

		override public function clone ():Event
		{
			return new StringEvent(type, value);
		}

		public function get value():String
		{
			return _value;
		}
	}
}
