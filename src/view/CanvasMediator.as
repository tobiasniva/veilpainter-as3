package view
{
	import event.ColorEvent;

	import flash.events.Event;

	import model.CanvasModel;

	import org.robotlegs.mvcs.Mediator;

	/**
	 *
	 * @author: Tobi Wan Kenobi
	 */
	public class CanvasMediator extends Mediator
	{
		[Inject] public var _view:CanvasView;
		[Inject] public var _canvasModel:CanvasModel;

		override public function onRegister():void
		{
			addViewListener(CanvasView.CANVAS_CREATED, onCanvasCreated);
			addContextListener(ColorEvent.CANVAS_COLOR_CHANGED, onCanvasColorChanged);

			_view.Init(_canvasModel.sizeMultiplier, _canvasModel.colorDefault);
		}

		private function onCanvasCreated(e:Event):void
		{
			_canvasModel.canvasBmpData = _view.bmpData;
		}

		private function onCanvasColorChanged(e:ColorEvent):void
		{
			trace("CanvasMediator::onCanvasColorChanged()");
			var mp:int = _canvasModel.sizeMultiplier;
			var col:uint = e.color;
			_view.Init(mp, col);
		}
	}
}