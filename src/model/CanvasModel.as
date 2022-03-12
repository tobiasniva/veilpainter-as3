package model
{
	import event.MiscEvent;

	import flash.display.BitmapData;

	import org.robotlegs.mvcs.Actor;

	/**
	 *
	 * @author: Tobi Wan Kenobi
	 * Canvas related...
	 */
	public class CanvasModel extends Actor
	{
		public var sizeMultiplier:int;
		public var color:uint;
		
		private var _canvasBmpData:BitmapData;
		
		public function set canvasBmpData(bmpData:BitmapData):void
		{
			_canvasBmpData = bmpData;
			dispatch(new MiscEvent(MiscEvent.CANVAS_BMPDATA_CHANGED));
		}
		
		public function get canvasBmpData():BitmapData
		{
			return _canvasBmpData;
		}
	}
}