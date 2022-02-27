package labs
{
	import com.bit101.components.Label;

	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.geom.Point;

	import utils.GridFactory;
	import utils.ShapeFactory;

	/**
	 *
	 * @author: Tobi Wan Kenobi
	 */
	[SWF(backgroundColor = "#ffffff", frameRate = "60", width = "800", height = "600")]
	public class TransformPoints extends Sprite
	{
		private static const GRID_SIZE:int = 200;
		private static const COL_AXIS:uint = 0x666666;
		private static const COL_GRID:uint = 0xe6e6e6;
		
		private static const POINT_COL:uint     = 0x0000ff;
		private static const POINT_SIZE:int     = 2;
		private static const POINT_TR_COL:uint  = 0xff0000;
		private static const POINT_TR_SIZE:int  = 2;

		private var _origo:Point;
		private var _grid:Shape;
		private var _containerPoints:Sprite;
		private var _points:Vector.<Point>;
		private var _pointsTransformed:Vector.<Point>;
		
		public function TransformPoints()
		{
			_containerPoints = new Sprite();
			addChild(_containerPoints);

			_points = new <Point>[];
			for(var i:int = 0; i < 11; i++)
			{
				for(var j:int = 0; j < 11; j++)
				{
					var p:Point = new Point();
					p.x = 0 + (i * 0.1); 
					p.y = -0.8 + (j * 0.1); 
					addPoint(p.x, p.y);
				}
			}
			
			_origo = new Point(400, 500);
			drawGrid(_origo.x, _origo.y);
			updatePoints();
			
			stage.addEventListener(MouseEvent.RIGHT_CLICK, moveOrigo);
			stage.addEventListener(MouseEvent.CLICK, transformPoints);
		}

		private function transformPoints(e:MouseEvent):void
		{
			_pointsTransformed = new <Point>[];
			for each(var p:Point in _points)
			{
				var pT:Point = new Point();
				
				var len:Number = Math.sqrt((p.x * p.x) + (p.y * p.y));
				var angle:Number = Math.atan2(p.y, p.x);
				
				var sqrLen:Number   = len * len;
//				var sqrLen:Number   = (len * len) / 2;
				var dblAngle:Number = angle * 2;
				var newPos:Point    = Point.polar(sqrLen, dblAngle);

				pT = newPos;

				_pointsTransformed.push(pT);
			}
			
			updatePoints(0.25);
		}
		
		private function updatePoints(origPointAlpha:Number = 1.0, showLabelCoord:Boolean = false):void
		{
			_containerPoints.removeChildren();
			
			for each(var p:Point in _points)
			{
				var shp:Shape = ShapeFactory.getCircle(POINT_SIZE, POINT_COL);
				shp.x = _origo.x + (p.x * GRID_SIZE);
				shp.y = _origo.y + (p.y * GRID_SIZE);
				shp.alpha = origPointAlpha;
				_containerPoints.addChild(shp);
				
				if(showLabelCoord)
					var lbl:Label = new Label(_containerPoints, shp.x + 10, shp.y - 15, String(p.x + "," + p.y));
			}

			for each(var pT:Point in _pointsTransformed)
			{
				var shp2:Shape = ShapeFactory.getCircle(POINT_TR_SIZE, POINT_TR_COL);
				shp2.x = _origo.x + (pT.x * GRID_SIZE);
				shp2.y = _origo.y + (pT.y * GRID_SIZE);
				_containerPoints.addChild(shp2);

				if(showLabelCoord)
					var lbl2:Label = new Label(_containerPoints, shp2.x + 10, shp2.y - 15, String(pT.x + "," + pT.y));
			}
		}

		private function addPoint(x:Number, y:Number):void
		{
			var p:Point = new Point(x, y);
			_points.push(p);
		}
		
		private function moveOrigo(e:MouseEvent):void
		{
			var x:int = Math.round(stage.mouseX);
			var y:int = Math.round(stage.mouseY);
			_origo = new Point(x, y);
			
			drawGrid(x, y);
			updatePoints();
		}

		private function drawGrid(origoX:int, origoY:int):void
		{
			if(_grid != null)
				if(_grid.parent)
					removeChild(_grid);
			
			var orig:Point = new Point(origoX, origoY);
			_grid = GridFactory.getGrid(stage.stageWidth, stage.stageHeight, orig, GRID_SIZE, COL_GRID, COL_AXIS);
			addChildAt(_grid, 0);
		}
	}
}
