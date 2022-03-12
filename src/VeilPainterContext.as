package
{
	import controller.commands.InitAppCommand;
	import controller.commands.QuitAppCommand;

	import event.AppEvent;

	import flash.display.DisplayObjectContainer;

	import model.TempModel;

	import org.robotlegs.mvcs.Context;

	import view.BrushMediator;
	import view.BrushView;
	import view.CanvasMediator;
	import view.CanvasView;
	import view.GuiBaseView;
	import view.GuiMediator;
	import view.GuiPhoneView;

	/**
	 *
	 * @author: Tobi Wan Kenobi
	 */
	public class VeilPainterContext extends Context
	{
		public function VeilPainterContext(contextView:DisplayObjectContainer)
		{
			super(contextView);
		}

		override public function startup():void
		{
			// Models and helpers
			injector.mapSingleton(TempModel);
			
			// Views
			mediatorMap.mapView(CanvasView,         CanvasMediator);
			mediatorMap.mapView(BrushView,          BrushMediator);
			mediatorMap.mapView(GuiPhoneView,       GuiMediator,        GuiBaseView);
			
			// Commands
			commandMap.mapEvent(AppEvent.STARTUP,   InitAppCommand);
			commandMap.mapEvent(AppEvent.QUIT,      QuitAppCommand);

			// Kickstart whole operation...
			super.startup();
			dispatchEvent(new AppEvent(AppEvent.STARTUP));
		}
	}
}
