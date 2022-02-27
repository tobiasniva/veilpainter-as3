package utils
{
	import flash.geom.Point;

	/**
	 *
	 * @author: Tobi Wan Kenobi
	 */
	public class Misc
	{
		public static function getPolarPoint(startPt:Point, degrees:Number, distance:Number):Point
		{
			var destinationPt:Point = new Point();
			destinationPt.x = startPt.x + Math.round(distance * Math.cos(degrees * Math.PI / 180 ));
			destinationPt.y = startPt.y + Math.round(distance * Math.sin(degrees * Math.PI / 180 ));
			
			return destinationPt;
		}
	}
}
