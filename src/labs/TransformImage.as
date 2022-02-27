package labs
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.utils.getTimer;

	import utils.GridFactory;

	/**
	 *
	 * @author: Tobi Wan Kenobi
	 */
	[SWF(backgroundColor = "#ffffff", frameRate = "60", width = "1024", height = "640")]
	public class TransformImage extends Sprite
	{
		[Embed(source="../../assets/mop_384x256.png")]
		private var BmpMop:Class;
		
		private static const GRID_SIZE:int = 100;
		private static const COL_AXIS:uint = 0x666666;
		private static const COL_GRID:uint = 0xe6e6e6;

		private var _origo:Point;
		private var _grid:Shape;
		private var _bmpData:BitmapData;
		private var _bmp:Bitmap;
		
		public function TransformImage()
		{
			_origo = new Point(512, 320);
			drawGrid(_origo.x, _origo.y);
			
			_bmpData = new BitmapData(stage.stageWidth, stage.stageHeight, false, 0xcccccc);
			
			var bmpMop:Bitmap = new BmpMop();
			var mtx:Matrix = new Matrix();
//			mtx.translate(_origo.x, (_origo.y - bmpMop.height));
			mtx.translate(_origo.x -100, (_origo.y - 200));
			
			_bmpData.draw(bmpMop, mtx);
			_bmp = new Bitmap(_bmpData);
			addChildAt(_bmp, 0);
			
//			stage.addEventListener(MouseEvent.CLICK, transformImageWithMatrix);
			stage.addEventListener(MouseEvent.CLICK, transformPixels);
		}

		private function transformPixels(e:MouseEvent):void
		{
			//-- New bmp data to write to
			var newBmpData:BitmapData = new BitmapData(_bmpData.width, _bmpData.height, true);
			newBmpData.lock();

			var width:int = _bmpData.width;
			var height:int = _bmpData.height;
			var origoNrm:Point = new Point(_origo.x / 1000, _origo.y / 1000);

			var pNrm:Point = new Point();
			var p:Point    = new Point();
			var len:Number      = 0;
			var angle:Number    = 0;
			var sqrLen:Number   = 0;
			var dblAngle:Number = 0;
			var newPos:Point;
			var newX:int;
			var newY:int;
			
			var timestamp:Number = getTimer();
			
			var scalar:int = 1000;
			
			for(var i:int = 0; i < width; i++)
			{
				for(var j:int = 0; j < height; j++)
				{
					var curPixel:uint = _bmpData.getPixel(i, j);
					
					pNrm.x = i / scalar
					pNrm.y = j / scalar;
					p.x    = pNrm.x - origoNrm.x;
					p.y    = pNrm.y - origoNrm.y;
					len     = Math.sqrt((p.x * p.x) + (p.y * p.y));
					angle   = Math.atan2(p.y, p.x);
					
//					sqrLen      = (len * len) / 2;
					sqrLen      = (len * len);
					dblAngle    = angle * 2;
					newPos      = Point.polar(sqrLen, dblAngle);
					
					newX = int(newPos.x * scalar + _origo.x);
					newY = int(newPos.y * scalar + _origo.y);
					
					newBmpData.setPixel(newX, newY, curPixel);
				}
			}

			newBmpData.unlock();
			_bmp.bitmapData = newBmpData;
			
			trace(getTimer() - timestamp);
		}
		
		private function transformImageWithMatrix(e:MouseEvent):void
		{
			// a  c  tx
			// b  d  ty
			
			var mtx:Matrix = new Matrix();
			mtx.a = Math.cos(0.2);
			mtx.b = Math.sin(0.2);
			mtx.c = -Math.sin(0.2);
			mtx.d = Math.cos(0.2);
			mtx.tx = 1;
			mtx.ty = 1;
			
			_bmp.transform.matrix = mtx;
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
