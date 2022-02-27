package labs
{
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.geom.Point;

	import utils.ShapeFactory;

	/**
	 *
	 * @author: Tobi Wan Kenobi
	 */
	[SWF(backgroundColor = "#ffffff", frameRate = "60", width = "800", height = "600")]
	public class MovePointsOutward extends Sprite
	{
		private static const DISTANCE:Number = 4;
		
		public function MovePointsOutward()
		{
			var p1:Point = new Point(250, 200);
			var p2:Point = new Point(400, 180);
			var p3:Point = new Point(200, 310);
			var p4:Point = new Point(400, 360);
			var points:Vector.<Point> = new <Point>[p1, p2, p3, p4];

			for each(var p:Point in points)
			{
				var shp:Shape = ShapeFactory.getCircle(2, 0x000000);
				addChild(shp);
				shp.x = p.x;
				shp.y = p.y;
				addChild(shp);
			}

			var angle_1o3:Number = getAngleBetweenPoints(p1, p3);
			var pOff_1o3:Point = new Point();
			pOff_1o3.x = p3.x + DISTANCE * Math.cos(angle_1o3);
			pOff_1o3.y = p3.y + DISTANCE * Math.sin(angle_1o3);
			var shp_1o3:Shape = ShapeFactory.getCircle(2, 0xff0000);
			shp_1o3.x = pOff_1o3.x;
			shp_1o3.y = pOff_1o3.y;
			addChild(shp_1o3);
		}

		private function getAngleBetweenPoints(p1:Point, p2:Point):Number
		{
			var dx:Number = p2.x - p1.x;
			var dy:Number = p2.y - p1.y;
			var angle:Number = Math.atan2(dy, dx);

			return angle;
		}
	}
}
