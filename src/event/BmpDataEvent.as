package event
{
	import flash.display.BitmapData;
	import flash.events.Event;

	/**
	 *
	 * @author: Tobi Wan Kenobi
	 */
	public class BmpDataEvent extends Event
	{
		public static const CANVAS_BMPDATA_CHANGED:String       = "BmpDataEvent.CANVAS_COLOR_CHANGED";
		public static const NOTIFY_BRUSH_WITH_BMPDATA:String    = "BmpDataEvent.NOTIFY_BRUSH_WITH_BMPDATA";

		private var _bmpData:BitmapData;
		
		public function BmpDataEvent(type:String, bmpData:BitmapData):void
		{
			_bmpData = bmpData;
			super(type);
		}

		override public function clone ():Event
		{
			return new BmpDataEvent(type, bmpData);
		}

		public function get bmpData():BitmapData
		{
			return _bmpData;
		}
	}
}
