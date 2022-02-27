package labs
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.BitmapData;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.geom.PerspectiveProjection;
	import flash.geom.Point;
	import flash.geom.Rectangle;

	import utils.ShapeFactory;

	/**
	 *
	 * @author: Tobi Wan Kenobi
	 */
	[SWF(backgroundColor="#ffffff", frameRate="60", width="800", height="600")]
	public class BitmapFillTest extends Sprite
	{
		[Embed(source="../../assets/uv.jpg")]
		private static const ImageClass:Class;
		
		private var shp1:Shape;
		private var shp2:Shape;
		private var bmpData:BitmapData;
		private var ps:Vector.<Point>;
		private var handles:Vector.<Sprite>;
		
		public function BitmapFillTest()
		{
			var p1:Point = new Point(300, 100);
			var p2:Point = new Point(500, 75);
			var p3:Point = new Point(325, 200);
			var p4:Point = new Point(450, 225);
			
			var p5:Point = new Point(100, 250);
			var p6:Point = new Point(225, 375);
			
			ps = new <Point>[p1, p2, p3, p4, p5, p6];
			handles = new <Sprite>[];
			
			bmpData = new ImageClass().bitmapData;
			
			shp1 = new Shape();
			shp2 = new Shape();
			
			updateQuad(shp1, ps[0], ps[1], ps[2], ps[3]);
			updateQuad(shp2, ps[2], ps[3], ps[4], ps[5]);
			
			addChild(shp1);
			addChild(shp2);
			
			for each(var p:Point in ps)
			{
				var spr:Sprite = new Sprite();
				var shp:Shape = ShapeFactory.getCircle(8, 0xff0000);
				spr.x = p.x;
				spr.y = p.y;
				spr.addChild(shp);
				spr.addEventListener(MouseEvent.MOUSE_DOWN, onStartDrag);
				handles.push(spr);
				addChild(spr);
			}
			
			stage.addEventListener(MouseEvent.MOUSE_UP, onStopDrag);
		}

		private function onStartDrag(e:MouseEvent):void
		{
			var shp:Sprite = e.currentTarget as Sprite;
			shp.startDrag();
			stage.addEventListener(MouseEvent.MOUSE_MOVE, onUpdateQuads);
		}

		private function onStopDrag(e:MouseEvent):void
		{
			stage.removeEventListener(MouseEvent.MOUSE_MOVE, onUpdateQuads);

			for each(var spr:Sprite in handles)
			{
				spr.stopDrag();
			}
		}

		private function onUpdateQuads(e:MouseEvent):void
		{
			for(var i:int = 0; i < ps.length; i++)
			{
				ps[i] = new Point(handles[i].x, handles[i].y);
			}
			
			updateQuad(shp1, ps[0], ps[1], ps[2], ps[3]);
			updateQuad(shp2, ps[2], ps[3], ps[4], ps[5]);
		}

		private function updateQuad(shp:Shape, p1:Point, p2:Point, p3:Point, p4:Point):Shape
		{
			var pCenter:Point = getIntersection(p1, p4, p2, p3);

			// Lenghts of first diagonal		
			var d1:Number = Point.distance(p1, pCenter);
			var d4:Number = Point.distance(pCenter, p4);

			// Lengths of second diagonal		
			var d2:Number = Point.distance(p2, pCenter);
			var d3:Number = Point.distance(pCenter, p3);

			// Ratio between diagonals
			var f:Number = (d1 + d4) / (d2 + d3);
			
			// Draws the triangles
			shp.graphics.clear();
			shp.graphics.beginBitmapFill(bmpData, null, false, true);

			shp.graphics.drawTriangles(
					Vector.<Number>([p1.x, p1.y, p2.x, p2.y, p3.x, p3.y, p4.x, p4.y]),
					Vector.<int>([0, 1, 2, 1, 3, 2]),
					Vector.<Number>([0,0,(1/d4)*f, 1,0,(1/d3), 0,1,(1/d2), 1,1,(1/d1)*f])
			);
			
			return shp;
		}
		
		private function getIntersection(p1:Point, p2:Point, p3:Point, p4:Point):Point
		{
			var a1:Number = p2.y - p1.y;
			var b1:Number = p1.x - p2.x;
			var a2:Number = p4.y - p3.y;
			var b2:Number = p3.x - p4.x;

			var denom:Number = a1 * b2 - a2 * b1;
			if (denom == 0) return null;

			var c1:Number = p2.x * p1.y - p1.x * p2.y;
			var c2:Number = p4.x * p3.y - p3.x * p4.y;

			var p:Point = new Point((b1 * c2 - b2 * c1) / denom, (a2 * c1 - a1 * c2) / denom);

			if (Point.distance(p, p2) > Point.distance(p1, p2)) return null;
			if (Point.distance(p, p1) > Point.distance(p1, p2)) return null;
			if (Point.distance(p, p4) > Point.distance(p3, p4)) return null;
			if (Point.distance(p, p3) > Point.distance(p3, p4)) return null;

			return p;
		}
	}
}
