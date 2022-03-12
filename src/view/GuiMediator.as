package view
{
	import model.TempModel;

	import org.robotlegs.mvcs.Mediator;

	/**
	 *
	 * @author: Tobi Wan Kenobi
	 */
	public class GuiMediator extends Mediator
	{
		[Inject] public var _view:GuiBaseView;
		[Inject] public var _model:TempModel;

		override public function onRegister():void
		{
			//TODO: Init with stuff from model...
			
			_view.Init(_model.alphasWithLabel);
		}
	}
}