package view
{
	import behavior.Brush;

	import consts.Constants;
	import consts.ImageConst;

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
	public class BrushView extends Sprite
	{
		private var brush:Brush;
		
		public function Init(bmpData:BitmapData, sizeMultiplier:int):void
		{
			removeListeners(); //-- if we init with other brushes later on...
			
			//TODO: Kill brush if already exists...
			
			brush = new Brush(bmpData, sizeMultiplier, Constants.NUM_LINKS_DEFAULT);
			brush.alphaImage            = new ImageConst.Alpha_1(); //TODO: from model...
			brush.elasticity            = Constants.ELASTICITY_DEFAULT;
			brush.strength              = Constants.STRENGTH_DEFAULT;
			brush.strengthDegradation   = Constants.DEGRADATION_DEFAULT;
//			brush.fade = true;
			brush.brushColor            = Constants.BRUSH_COLOR_DEFAULT;
			brush.brushAlpha            = Constants.BRUSH_ALPHA_DEFAULT;
			brush.brushBlendmode        = Constants.BRUSH_BLENDMODE_DEFAULT;
			brush.shape                 = ShapeFactory.getCircle(Constants.CHAIN_LINK_SIZE, Constants.CHAIN_LINK_COLOR);
			addChild(brush);

			addListeners();
		}

		private function addListeners():void
		{
			stage.addEventListener(MouseEvent.MOUSE_DOWN, toggleDrawing);
			stage.addEventListener(MouseEvent.MOUSE_UP, toggleDrawing);
			stage.addEventListener(Event.ENTER_FRAME, update);
		}
		
		private function removeListeners():void
		{
			stage.removeEventListener(MouseEvent.MOUSE_DOWN, toggleDrawing);
			stage.removeEventListener(MouseEvent.MOUSE_UP, toggleDrawing);
			stage.removeEventListener(Event.ENTER_FRAME, update);
		}
		
		private function update(e:Event):void
		{
			var target:Point = new Point(mouseX, mouseY);
			brush.update(target);
		}

		private function toggleDrawing(e:MouseEvent):void
		{
			if (e.type == MouseEvent.MOUSE_DOWN && e.target == stage)
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
