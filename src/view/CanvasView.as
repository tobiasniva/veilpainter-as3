package view
{
	import consts.Constants;
	import consts.ImageConst;

	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.geom.Point;

	/**
	 *
	 * @author: Tobi Wan Kenobi
	 */
	public class CanvasView extends Sprite
	{
		private var _bmp:Bitmap;
		private var _bmpData:BitmapData;

		private var _testEmbedded:Bitmap = new ImageConst.Alpha_1();
		
		public function Init(sizeMultiplier:int, bgColor:uint):void
		{
			var screenSize:Point = new Point(stage.fullScreenWidth, stage.fullScreenHeight);
			var bmpSize:Point = new Point(screenSize.x * sizeMultiplier, screenSize.y * sizeMultiplier);
			
			_bmpData = new BitmapData(bmpSize.x, bmpSize.y, false, bgColor);
			_bmp = new Bitmap(_bmpData);
			addChildAt(_bmp, 0);
			
			addChild(_testEmbedded);
		}
	}
}
