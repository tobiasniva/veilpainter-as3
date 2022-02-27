package labs
{
	import flash.display.Bitmap;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.geom.Point;

	import utils.DistortImage;

	import utils.ShapeFactory;

	/**
	 *
	 * @author: Tobi Wan Kenobi
	 */
	[SWF(backgroundColor = "#ffffff", frameRate = "60", width = "800", height = "600")]
	public class DistortImageTest extends Sprite
	{
		[Embed(source="../../assets/uv.jpg")]
//		[Embed(source="../../assets/gradient.jpg")]
//		[Embed(source="../../assets/checker.png")]
		private static const ImageClass:Class;

		private var handles:Vector.<Sprite>;
		private var dist:DistortImage;
		private var bmp:Bitmap = new ImageClass();
		private var shp1:Shape;
		private var shp2:Shape;

		public function DistortImageTest()
		{
			addHandlesAndImage();
			stage.addEventListener(MouseEvent.MOUSE_UP, onStopDrag);
		}

		private function updateStuff(e:MouseEvent):void
		{
			var tLeft:Point = new Point(handles[0].x, handles[0].y);
			var tRight:Point = new Point(handles[1].x, handles[1].y);
			var mLeft:Point = new Point(handles[2].x, handles[2].y);
			var mRight:Point = new Point(handles[3].x, handles[3].y);
			var bLeft:Point = new Point(handles[4].x, handles[4].y);
			var bRight:Point = new Point(handles[5].x, handles[5].y);

			shp1.graphics.clear();
			dist.setTransform(shp1.graphics, bmp.bitmapData, tLeft, tRight, mRight, mLeft);

			shp2.graphics.clear();
			dist.setTransform(shp2.graphics, bmp.bitmapData, mLeft, mRight, bRight, bLeft);
		}

		private function onStopDrag(e:MouseEvent):void
		{
			stage.removeEventListener(MouseEvent.MOUSE_MOVE, updateStuff);

			for each(var spr:Sprite in handles)
			{
				spr.stopDrag();
			}
		}

		private function onStartDrag(e:MouseEvent):void
		{
			var spr:Sprite = Sprite(e.currentTarget);
			spr.startDrag();
			stage.addEventListener(MouseEvent.MOUSE_MOVE, updateStuff);
		}

		private function addHandlesAndImage():void
		{
			var p1:Point = new Point(200, 200);
			var p2:Point = new Point(400, 200);
			var p3:Point = new Point(200, 400);
			var p4:Point = new Point(400, 400);
			var p5:Point = new Point(200, 500);
			var p6:Point = new Point(400, 525);
			var points:Vector.<Point> = new <Point>[p1, p2, p3, p4, p5, p6];

			shp1 = new Shape();
			shp1.graphics.beginBitmapFill(bmp.bitmapData);
			shp1.graphics.drawRect(0, 0, bmp.width, bmp.height);
			addChild(shp1);

			shp2 = new Shape();
			shp2.graphics.beginBitmapFill(bmp.bitmapData);
			shp2.graphics.drawRect(0, 0, bmp.width, bmp.height);
			addChild(shp2);

			dist = new DistortImage(bmp.width, bmp.height, 2, 2);

			handles = new <Sprite>[];

			for each(var p:Point in points)
			{
				var spr:Sprite = new Sprite();
				var shp:Shape = ShapeFactory.getCircle(8, 0x0000ff);
				spr.addChild(shp);
				spr.x = p.x;
				spr.y = p.y;
				addChild(spr);
				spr.addEventListener(MouseEvent.MOUSE_DOWN, onStartDrag);
				handles.push(spr);
			}
		}
	}
}
