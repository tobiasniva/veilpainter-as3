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
		public var canvasColor:uint     = 0x111111;
		
		// BRUSH STUFF
		private var _alphas:Vector.<Bitmap>;
		
		public function addBrushAlpha(bmp:Bitmap):void
		{
			if(_alphas == null)
				_alphas = new <Bitmap>[];
			
			_alphas.push(bmp);
		}
		
		public function getBrushAlpha(index:int):Bitmap
		{
			return _alphas[index];
		}
	}
}