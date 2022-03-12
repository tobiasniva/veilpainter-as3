package view
{
	import event.ColorEvent;
	import event.MiscEvent;

	import model.BrushModel;
	import model.CanvasModel;

	import org.robotlegs.mvcs.Mediator;

	/**
	 *
	 * @author: Tobi Wan Kenobi
	 */
	public class BrushMediator extends Mediator
	{
		[Inject] public var _view:BrushView;
		[Inject] public var _canvasModel:CanvasModel;
		[Inject] public var _brushModel:BrushModel;

		override public function onRegister():void
		{
			addContextListener(MiscEvent.CANVAS_BMPDATA_CHANGED, onCanvasBmpDataChanged);
			addContextListener(ColorEvent.BRUSH_COLOR_CHANGED, onBrushColorChanged);
			_view.Init(_canvasModel, _brushModel);
		}

		private function onBrushColorChanged(e:ColorEvent):void
		{
			_view.brush.brushColor = e.color;
		}

		private function onCanvasBmpDataChanged(e:MiscEvent):void
		{
			trace("BrushMediator::onCanvasBmpDataChanged");
			_view.Init(_canvasModel, _brushModel);
		}
	}
}