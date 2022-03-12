package view
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Point;

	/**
	 *
	 * @author: Tobi Wan Kenobi
	 */
	public class CanvasView extends Sprite
	{
		public static const CANVAS_CREATED:String = "CanvasView.CANVAS_CREATED";
		
		private var _bmp:Bitmap;
		private var _bmpData:BitmapData;
		
		public function Init(sizeMultiplier:int, bgColor:uint):void
		{
			this.mouseChildren = this.mouseEnabled = false;
			
			var screenSize:Point = new Point(stage.fullScreenWidth, stage.fullScreenHeight);
			var bmpSize:Point = new Point(screenSize.x * sizeMultiplier, screenSize.y * sizeMultiplier);
			_bmpData = new BitmapData(bmpSize.x, bmpSize.y, false, bgColor);
			_bmp = new Bitmap(_bmpData);
			addChild(_bmp);

			dispatchEvent(new Event(CanvasView.CANVAS_CREATED));
		}
		
		public function get bmpData():BitmapData
		{
			return _bmpData;
		}
	}
}