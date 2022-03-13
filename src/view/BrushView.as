package view
{
	import behavior.Brush;

	import consts.Constants;

	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;

	import model.BrushModel;
	import model.CanvasModel;

	import utils.ShapeFactory;

	/**
	 *
	 * @author: Tobi Wan Kenobi
	 */
	public class BrushView extends Sprite
	{
		public var brush:Brush;
		
		public function Init(canvasModel:CanvasModel, brushModel:BrushModel):void
		{
			removeListeners(); //-- if we init with other brushes later on...
			
			//TODO: Kill brush if already exists...
			
			brush = new Brush(canvasModel.canvasBmpData, canvasModel.sizeMultiplier, brushModel.numLinks);
			brush.alphaImage            = brushModel.alphaImagesWithLabel[0].bitmap; //TODO: BrushModel should have active one...
			brush.elasticity            = brushModel.elasticity;
			brush.strength              = brushModel.strength;
			brush.strengthDegradation   = brushModel.degradation;
//			brush.fade = true;
			brush.brushColor            = brushModel.color;
			brush.brushAlpha            = brushModel.alpha;
			brush.brushBlendmode        = brushModel.blendmode;
			brush.shape                 = ShapeFactory.getCircle(brushModel.chainLinkSize, brushModel.chainLinkColor);
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
			//TODO: We seem to hit the stage everytime a circle/chainlink is under the pointer...?
			if (e.type == MouseEvent.MOUSE_DOWN && (e.target == this || e.target == stage))
			{
				brush.isDrawing = true;
//				_gui.hide();
				trace("isDrawing = true, target: " + e.target);
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
