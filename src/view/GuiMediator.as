package view
{
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
			//TODO: Init with stuff from model...
			
			_view.Init(_brushModel, _canvasModel);
		}
	}
}