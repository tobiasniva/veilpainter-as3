package event
{
	import flash.events.Event;

	/**
	 *
	 * @author: Tobi Wan Kenobi
	 */
	public class ColorEvent extends Event
	{
		public static const CANVAS_COLOR_CHANGED:String = "ColorEvent.CANVAS_COLOR_CHANGED";
		public static const BRUSH_COLOR_CHANGED:String  = "ColorEvent.BRUSH_COLOR_CHANGED";

		private var _color:uint;
		
		public function ColorEvent(type:String, color:uint):void
		{
			_color = color;
			super(type);
		}

		override public function clone ():Event
		{
			return new ColorEvent(type, color);
		}

		public function get color():uint
		{
			return _color;
		}
	}
}
