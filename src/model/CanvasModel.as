package model
{
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
		public var canvasBmpData:BitmapData;
	}
}