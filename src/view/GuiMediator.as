package view
{
	import event.ColorEvent;

	import model.BrushModel;
	import model.CanvasModel;

	import org.robotlegs.mvcs.Mediator;

	/**
	 *
	 * @author: Tobi Wan Kenobi
	 */
	public class GuiMediator extends Mediator
	{
		[Inject] public var _view:GuiBaseView;
		[Inject] public var _brushModel:BrushModel;
		[Inject] public var _canvasModel:CanvasModel;

		override public function onRegister():void
		{
			addViewListener(ColorEvent.CANVAS_COLOR_CHANGED, onCanvasColorChanged);
			addViewListener(ColorEvent.BRUSH_COLOR_CHANGED, onBrushColorChanged);
			
			_view.Init(_brushModel, _canvasModel);
		}

		private function onBrushColorChanged(e:ColorEvent):void
		{
			trace("GuiMediator::onBrushColorChanged");
			dispatch(new ColorEvent(ColorEvent.BRUSH_COLOR_CHANGED, e.color))
			
		}

		private function onCanvasColorChanged(e:ColorEvent):void
		{
			trace("GuiMediator::onCanvasColorChanged");
			dispatch(new ColorEvent(ColorEvent.CANVAS_COLOR_CHANGED, e.color));
		}
	}
}