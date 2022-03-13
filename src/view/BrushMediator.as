package view
{
	import event.ColorEvent;
	import event.NumberEvent;

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
			addContextListener(ColorEvent.BRUSH_COLOR_CHANGED, onBrushColorChanged);
			addContextListener(NumberEvent.BRUSH_ELASTICITY_CHANGED, onBrushElasticityChanged);
			_view.Init(_canvasModel, _brushModel);
		}

		private function onBrushElasticityChanged(e:NumberEvent):void
		{
			trace("BrushMediator::onBrushElasticityChanged() - " + e.value);
			_view.brush.elasticity = e.value;
		}

		private function onBrushColorChanged(e:ColorEvent):void
		{
			trace("BrushMediator::onBrushColorChanged() - " + e.color);
			_view.brush.brushColor = e.color;
		}
	}
}