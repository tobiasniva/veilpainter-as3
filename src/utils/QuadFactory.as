package utils
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Shape;
	import flash.geom.Point;
	import flash.geom.Rectangle;

	/**
	 *
	 * @author: Tobi Wan Kenobi
	 */
	public class QuadFactory
	{

		public static function getQuadImage(bmpAlpha:Bitmap, num:int, totalNum:int, col:uint = 0xffff00, alpha:Number = 1.0):BitmapData
		{
			var w:int = bmpAlpha.width / totalNum;
			var h:int = bmpAlpha.height;

			var rectSource:Rectangle = new Rectangle(num * w, 0, w, h);

			//-- Just puts the overall alpha value in an uint for the color...
			var rgb:uint = col;
			var a:uint = (uint)(alpha * 255);
			var argb:uint = a << 24 | rgb;

			var img:BitmapData	= new BitmapData(w, h, true, argb);
			var mask:BitmapData = new BitmapData(w, h, true);
			mask.copyPixels(bmpAlpha.bitmapData, rectSource, new Point(0, 0));

			var mergeBmp:BitmapData = new BitmapData(w, h, true, 0);
			var rect:Rectangle = new Rectangle(0, 0, w, h);
			mergeBmp.copyPixels(img, rect, new Point(0, 0), mask, new Point(0, 0), true); //-- Merge alphasWithLabel

			return mergeBmp;
		}

		/*
			Some help...
		 */
		public static function getAngleBetweenPoints(p1:Point, p2:Point):Number
		{
			var dx:Number = p2.x - p1.x;
			var dy:Number = p2.y - p1.y;
			var angle:Number = Math.atan2(dy, dx);

			return angle;
		}

		public static function movePointForOverlap(pToMove:Point, pAwayFrom:Point, overlap:Number):Point
		{
			var pMoved:Point = new Point();

			var angle:Number = getAngleBetweenPoints(pAwayFrom, pToMove);
			pMoved.x = pToMove.x + overlap * Math.cos(angle);
			pMoved.y = pToMove.y + overlap * Math.sin(angle);

			return pMoved;
		}
	}
}
