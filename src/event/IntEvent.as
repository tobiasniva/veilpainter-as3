package event
{
	import flash.events.Event;

	/**
	 *
	 * @author: Tobi Wan Kenobi
	 */
	public class IntEvent extends Event
	{
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
