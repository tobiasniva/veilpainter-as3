package model
{
	import behavior.ImageWithLabel;

	import event.MiscEvent;

	import flash.display.BitmapData;

	import org.robotlegs.mvcs.Actor;

	/**
	 *
	 * @author: Tobi Wan Kenobi
	 * A place for stuff used in various places in app...split up in mulitple models later...
	 */
	public class TempModel extends Actor
	{
		// -- state?
		
		// CANVAS STUFF
		public var canvasMulitplier:int = 1;
		public var canvasColor:uint     = 0x662222;
		
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
		
		// BRUSH STUFF
		public var alphasWithLabel:Vector.<ImageWithLabel> = new <ImageWithLabel>[];
	}
}