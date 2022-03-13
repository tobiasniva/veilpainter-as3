package event
{
	import flash.events.Event;

	/**
	 *
	 * @author: Tobi Wan Kenobi
	 */
	public class IntEvent extends Event
	{
		public static const BRUSH_NUMLINKS_CHANGED:String       = "IntEvent.BRUSH_NUMLINKS_CHANGED";
		public static const BRUSH_ALPHA_IMG_CHANGED:String      = "IntEvent.BRUSH_ALPHA_IMG_CHANGED";
		
		private var _value:int;
		
		public function IntEvent(type:String, value:int):void
		{
			_value = value;
			super(type);
		}

		override public function clone ():Event
		{
			return new IntEvent(type, value);
		}

		public function get value():int
		{
			return _value;
		}
	}
}
