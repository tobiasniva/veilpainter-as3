package utils
{
	import flash.display.Shape;

	/**
	 *
	 * @author: Tobi Wan Kenobi
	 */
	public class ShapeFactory
	{
		public static function getCircle(size:int = 4, color:uint = 0x000000, alpha:Number = 1.0):Shape
		{
			var shp:Shape = new Shape();
			shp.graphics.beginFill(color, alpha);
			shp.graphics.drawCircle(0, 0, size);
			
			return shp;
		}

		public static function getHairCross(size:int = 8, color:uint = 0xff0000, alpha:Number = 1.0):Shape
		{
			var shp:Shape = new Shape();
			
			shp.graphics.lineStyle(0, color, alpha);
			shp.graphics.drawCircle(0, 0, size);
			
			shp.graphics.moveTo(-(size + size * 0.5), 0);
			shp.graphics.lineTo(size + size * 0.5, 0);
			shp.graphics.moveTo(0, -(size + size * 0.5));
			shp.graphics.lineTo(0, size + size * 0.5);

			return shp;
		}
	}
}
