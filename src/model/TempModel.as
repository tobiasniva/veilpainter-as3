package model
{
	import flash.display.Bitmap;

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
		public var canvasColor:uint     = 0x222222;
		
		// BRUSH STUFF
		public var alphas:Vector.<Bitmap> = new <Bitmap>[];
	}
}