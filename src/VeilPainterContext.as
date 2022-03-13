package
{
	import controller.commands.CanvasUpdatedCommand;
	import controller.commands.InitAppCommand;
	import controller.commands.QuitAppCommand;
	import controller.commands.SaveImageCommand;

	import event.AppEvent;
	import event.BmpDataEvent;
	import event.MiscEvent;

	import flash.display.DisplayObjectContainer;

	import model.BrushModel;
	import model.CanvasModel;
	import model.UiModel;

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
			injector.mapSingleton(CanvasModel);
			injector.mapSingleton(BrushModel);
			injector.mapSingleton(UiModel);
			
			// Views
			mediatorMap.mapView(CanvasView,         CanvasMediator);
			mediatorMap.mapView(BrushView,          BrushMediator);
			mediatorMap.mapView(GuiPhoneView,       GuiMediator,        GuiBaseView);
			
			// Commands
			commandMap.mapEvent(AppEvent.STARTUP,   InitAppCommand);
			commandMap.mapEvent(AppEvent.QUIT,      QuitAppCommand);
			//
			commandMap.mapEvent(BmpDataEvent.CANVAS_BMPDATA_CHANGED,    CanvasUpdatedCommand);
			commandMap.mapEvent(MiscEvent.SAVE_IMAGE,                   SaveImageCommand);

			
			// Kickstart whole operation...
			super.startup();
			dispatchEvent(new AppEvent(AppEvent.STARTUP));
		}
	}
}
