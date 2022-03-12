package event
{
	import flash.events.Event;

	/**
	 *
	 * @author: Tobi Wan Kenobi
	 */
	public class NumberEvent extends Event
	{
		public static const BRUSH_ELASTICITY_CHANGED:String     = "NumberEvent.BRUSH_ELASTICITY_CHANGED";
		public static const BRUSH_STRENGTH_CHANGED:String       = "NumberEvent.BRUSH_STRENGTH_CHANGED";
		public static const BRUSH_DEGRADATION_CHANGED:String    = "NumberEvent.BRUSH_DEGRADATION_CHANGED";
		public static const BRUSH_ALPHA_CHANGED:String          = "NumberEvent.BRUSH_ALPHA_CHANGED";

		private var _value:Number;
		
		public function NumberEvent(type:String, value:Number):void
		{
			_value = value;
			super(type);
		}

		override public function clone ():Event
		{
			return new NumberEvent(type, value);
		}

		public function get value():Number
		{
			return _value;
		}
	}
}
