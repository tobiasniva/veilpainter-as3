package behavior
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Shape;
	import flash.geom.Point;

	import utils.DistortImage;
	import utils.QuadFactory;

	/**
	 *
	 * @author: Tobi Wan Kenobi
	 */
	public class Brush extends Chain
	{
		private static const SEGMENTS:int = 1; //-- Kind of a quality setting for the distortion of quad images...

		public var debug:Boolean = false;

		private var _canvas:BitmapData;
		private var _canvasSizeMultiplier:int;
		private var _alphaImage:Bitmap;
		private var _brushColor:uint;
		private var _brushAlpha:Number;
		private var _brushBlendmode:String;
		private var _quads:Vector.<Vector.<Point>>;
		private var _quadImages:Vector.<BitmapData>;
		private var _isDrawing:Boolean;

		private var _isInitialized:Boolean;

		public function Brush(canvas:BitmapData, canvasSizeMultiplier:int = 1, numLinks:int = 10, elasticity:Number = 0.85, strength:Number = 0.028, strengthDegr:Number = 0.27, fade:Boolean = false)
		{
			this.mouseChildren = this.mouseEnabled = false;

			_isDrawing = false;
			_isInitialized = false;
			_canvasSizeMultiplier = canvasSizeMultiplier;
			_canvas = canvas;

			super(numLinks, elasticity, strength, strengthDegr, fade);
		}

		override public function init():void
		{
			_quads = new Vector.<Vector.<Point>>(super.numLinks - 1, true);
			_quadImages = new Vector.<BitmapData>(super.numLinks - 1, true);

			//-- Fill quad vector with point vectors
			for(var q:int = 0; q < _quads.length; q++)
			{
				var quad:Vector.<Point> = new Vector.<Point>(4, true);
				_quads[q] = quad;
			}

			super.init();

			generateQuadImages();

			_isInitialized = true;
		}

		override public function update(target:Point):void
		{
			super.update(target);

			if(_isDrawing)
			{
				_canvas.lock();

				updateQuads();

				var totalQuads:int = _quads.length;

				for (var i:int = 0; i < totalQuads; i++)
				{
					var quad:Vector.<Point> = _quads[i];

					if(debug)
					{
						var lines:Shape = new Shape();
						lines.graphics.lineStyle(0, 0xff00ff, 0.25);
						lines.graphics.moveTo(quad[0].x, quad[0].y);
						lines.graphics.lineTo(quad[1].x, quad[1].y);
						lines.graphics.lineTo(quad[3].x, quad[3].y);
						lines.graphics.lineTo(quad[2].x, quad[2].y);
						lines.graphics.lineTo(quad[0].x, quad[0].y);
						_canvas.draw(lines);

						for each(var p:Point in quad)
						{
							var dot:Shape = new Shape();
							dot.graphics.beginFill(0xff0000, 1);
							dot.graphics.drawCircle(p.x, p.y, 2);
							_canvas.draw(dot);
						}
					}
					else
					{
						var quadImage:BitmapData = _quadImages[i];
						var shp:Shape = new Shape();
						var distort:DistortImage = new DistortImage(quadImage.width, quadImage.height, SEGMENTS, SEGMENTS);
						distort.setTransform(shp.graphics, _quadImages[i], quad[0], quad[1], quad[3], quad[2]);
						_canvas.draw(shp, null, null, _brushBlendmode, null, true);
					}
				}

				_canvas.unlock();
			}
		}

		private function generateQuadImages():void
		{
			var totalQuadImages:int = _quadImages.length;

			for(var i:int = 0; i < totalQuadImages; i++)
			{
				_quadImages[i] = QuadFactory.getQuadImage(_alphaImage, i, totalQuadImages, _brushColor, _brushAlpha);
			}
		}

		private function updateQuads():void
		{
			//-- Get previous/current positions from chain...
			for(var n:int = 0; n < _quads.length; n++)
			{
				_quads[n][0] = super.previousLinkPositions[n];
				_quads[n][1] = super.previousLinkPositions[n+1];
				_quads[n][2] = super.currentLinkPositions[n];
				_quads[n][3] = super.currentLinkPositions[n+1];
			}

			//-- Scale points according to canvas size...
			for(var i:int = 0; i < _quads.length; i++)
			{
				var quad:Vector.<Point> = _quads[i];

				for(var j:int = 0; j < quad.length; j++)
				{
					var pOld:Point = _quads[i][j];
					var pNew:Point = new Point();
					pNew.x = pOld.x * _canvasSizeMultiplier;
					pNew.y = pOld.y * _canvasSizeMultiplier;

					_quads[i][j] = pNew;
				}
			}
		}

		/*
			Getters/setters
		 */

		public function set brushColor(value:uint):void
		{
			_brushColor = value;
			if(_isInitialized) generateQuadImages();
		}

		public function set brushAlpha(value:Number):void
		{
			_brushAlpha = value;
			if(_isInitialized) generateQuadImages();
		}

		public function set alphaImage(value:Bitmap):void
		{
			_alphaImage = value;
			if(_isInitialized) generateQuadImages();
		}

		public function set brushBlendmode(value:String):void
		{
			_brushBlendmode = value;
		}

		public function set isDrawing(value:Boolean):void
		{
			_isDrawing = value;
		}

		public function set canvas(value:BitmapData):void
		{
			_canvas = value;
		}

		public function set canvasSizeMultiplier(value:int):void
		{
			_canvasSizeMultiplier = value;
		}
	}
}