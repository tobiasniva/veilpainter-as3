package view
{
	import event.MiscEvent;

	import model.TempModel;

	import org.robotlegs.mvcs.Mediator;

	/**
	 *
	 * @author: Tobi Wan Kenobi
	 */
	public class BrushMediator extends Mediator
	{
		[Inject] public var _view:BrushView;
		[Inject] public var _model:TempModel;

		override public function onRegister():void
		{
			addContextListener(MiscEvent.CANVAS_BMPDATA_CHANGED, onCanvasChanged);
			_view.Init(_model.canvasBmpData, _model.canvasMulitplier);
		}

		private function onCanvasChanged(e:MiscEvent):void
		{
			_view.Init(_model.canvasBmpData, _model.canvasMulitplier);
		}
	}
}