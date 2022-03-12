package view
{
	import behavior.Brush;

	import consts.Constants;
	import consts.ImageConst;

	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;

	import utils.ShapeFactory;

	/**
	 *
	 * @author: Tobi Wan Kenobi
	 */
	public class CanvasView extends Sprite
	{
		private var _bmp:Bitmap;
		private var _bmpData:BitmapData;
		private var brush:Brush; //TODO: Move to own view...		
		
		public function Init(sizeMultiplier:int, bgColor:uint):void
		{
			var screenSize:Point = new Point(stage.fullScreenWidth, stage.fullScreenHeight);
			var bmpSize:Point = new Point(screenSize.x * sizeMultiplier, screenSize.y * sizeMultiplier);
			_bmpData = new BitmapData(bmpSize.x, bmpSize.y, false, bgColor);
			_bmp = new Bitmap(_bmpData);
			addChildAt(_bmp, 0);

			//-- create brush
			brush = new Brush(_bmpData, sizeMultiplier, Constants.NUM_LINKS_DEFAULT);
			brush.alphaImage           = new ImageConst.Alpha_1(); //TODO: from model...
			brush.elasticity           = Constants.ELASTICITY_DEFAULT;
			brush.strength             = Constants.STRENGTH_DEFAULT;
			brush.strengthDegradation  = Constants.DEGRADATION_DEFAULT;
//			brush.fade = true;
			brush.brushColor           = Constants.BRUSH_COLOR_DEFAULT;
			brush.brushAlpha           = Constants.BRUSH_ALPHA_DEFAULT;
			brush.brushBlendmode       = Constants.BRUSH_BLENDMODE_DEFAULT;
			brush.shape = ShapeFactory.getCircle(Constants.CHAIN_LINK_SIZE, Constants.CHAIN_LINK_COLOR);
			addChildAt(brush, getChildIndex(_bmp) + 1);
			
			stage.addEventListener(MouseEvent.MOUSE_DOWN, toggleDrawing);
			stage.addEventListener(MouseEvent.MOUSE_UP, toggleDrawing);
			stage.addEventListener(Event.ENTER_FRAME, update);
		}

		private function update(e:Event):void
		{
			var target:Point = new Point(mouseX, mouseY);
			brush.update(target);
		}

		private function toggleDrawing(e:MouseEvent):void
		{
//			if (e.type == MouseEvent.MOUSE_DOWN && e.target == stage)
			if (e.type == MouseEvent.MOUSE_DOWN && e.target == this)
			{
				brush.isDrawing = true;
//				_gui.hide();
				trace("isDrawing = true");
			}
			else
			{
				brush.isDrawing = false;
//				_gui.show();
				trace("isDrawing = false");
			}
		}
	}
}
