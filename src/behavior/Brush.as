package behavior
{
	import core.AppModel;
	import core.AppEventBus;
	import data.AlphaImages;
	import events.BrushEvent;
	import events.DrawEvent;

	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Shape;
	import flash.geom.Point;

	import utils.DistortImage;
	import utils.ShapeFactory;
	import utils.QuadFactory;

	public class Brush extends Chain
	{
		private static const SEGMENTS:int = 1; //-- Kind of a quality setting for the distortion of quad images...

		private var _canvas:BitmapData;
		private var _canvasSizeMultiplier:int;
		private var _alphaImage:Bitmap;
		private var _brushColor:uint;
		private var _brushOpacity:Number;
		private var _brushBlendmode:String;
		private var _quads:Vector.<Vector.<Point>>;
		private var _quadImages:Vector.<BitmapData>;
		private var _isDrawing:Boolean;

		private var _isInitialized:Boolean;

		public function Brush(canvas:BitmapData, initAlphaImage:Bitmap)
		{
			this.mouseChildren = this.mouseEnabled = false;

			_isDrawing = false;
			_isInitialized = false;
			_canvasSizeMultiplier = AppModel.instance.canvasMultiplier;
			_canvas = canvas;

			//TODO: init these by triggering setters below...race condition?
			var numLinks:int = AppModel.instance.brushNumLinks;
			var elasticity:Number = AppModel.instance.brushElasticity;
			var strength:Number = AppModel.instance.brushStrength;
			var strengthDegr:Number = AppModel.instance.brushDegradation;
			var fade:Boolean = false;
			super(numLinks, elasticity, strength, strengthDegr, fade);

			//-- set initial values...
			_brushColor 	= AppModel.instance.brushColor;
			_brushOpacity 	= AppModel.instance.brushOpacity;
			_brushBlendmode = AppModel.instance.brushBlendMode;
			_alphaImage = initAlphaImage; //-- alpha image before shape, cause triggers init...
			shape = ShapeFactory.getCircle(AppModel.instance.brushLinkSize, AppModel.instance.brushLinkColor);

			//-- add listeners to gui changing brush properties...
			AppEventBus.instance.addEventListener(BrushEvent.SETTINGS_CHANGED, onSettingsChanged);

			//-- listeners for started/ended drawing - subject to change when refactor goes forward...
			AppEventBus.instance.addEventListener(DrawEvent.DRAW_STARTED, onDrawStarted);
			AppEventBus.instance.addEventListener(DrawEvent.DRAW_ENDED, onDrawEnded);

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

					if(AppModel.instance.debugDraw)
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
				_quadImages[i] = QuadFactory.getQuadImage(_alphaImage, i, totalQuadImages, _brushColor, _brushOpacity);
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

		private function onSettingsChanged(e:BrushEvent):void
		{
			_brushColor = AppModel.instance.brushColor;
			_brushOpacity = AppModel.instance.brushOpacity;
			_alphaImage = AlphaImages.getAll()[AppModel.instance.brushAlphaImage].bitmap;
			_brushBlendmode = AppModel.instance.brushBlendMode;
			_canvasSizeMultiplier = AppModel.instance.canvasMultiplier;
			
			numLinks = AppModel.instance.brushNumLinks;
			elasticity = AppModel.instance.brushElasticity;
			strength = AppModel.instance.brushStrength;
			strengthDegradation = AppModel.instance.brushDegradation;

			if(e.shouldRegenerate)
				generateQuadImages();
		}

		private function onDrawStarted(e:DrawEvent):void
		{
			_isDrawing = true;
		}

		private function onDrawEnded(e:DrawEvent):void
		{
			_isDrawing = false;
		}

		//-- TODO: Figure out later...
		public function set canvas(value:BitmapData):void
		{
			_canvas = value;
		}
	}
}