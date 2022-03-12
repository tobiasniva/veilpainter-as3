package view
{
	import event.ColorEvent;

	import flash.display.Bitmap;

	import model.TempModel;

	import org.robotlegs.mvcs.Mediator;

	/**
	 *
	 * @author: Tobi Wan Kenobi
	 */
	public class CanvasMediator extends Mediator
	{
		[Inject] public var _view:CanvasView;
		[Inject] public var _model:TempModel;

		override public function onRegister():void
		{
			_view.Init(_model.canvasMulitplier, _model.canvasColor);
			addContextListener(ColorEvent.BG_COLOR_CHANGED, onBgColorChanged);
		}

		private function onBgColorChanged(e:ColorEvent):void
		{
			var mp:int = _model.canvasMulitplier;
			var col:uint = e.color;
			_view.Init(mp, col);
		}
	}
}