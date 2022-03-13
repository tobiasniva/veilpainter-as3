package controller.commands
{
	import controller.tasks.AddViewToContextTask;
	import controller.tasks.InitAllModelsTask;
	import controller.tasks.InitStylesTaskTemp;
	import controller.tasks.PopulateModelWithImagesTask;

	import se.salomonsson.sequence.robotlegs.SequenceCommand;

	import view.BrushView;
	import view.CanvasView;
	import view.GuiPhoneView;

	/**
	 *
	 * @author: Tobi Wan Kenobi
	 */
	public class InitAppCommand extends SequenceCommand
	{
		override public function execute():void
		{
			trace("InitAppCommand");
			
			//-- Add listener for hardware buttons...
//			NativeApplication.nativeApplication.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
//			NativeApplication.nativeApplication.addEventListener(Event.DEACTIVATE, onDeactivate);

			addSequentialTask(new PopulateModelWithImagesTask());
			addSequentialTask(new InitAllModelsTask());
			addSequentialTask(new InitStylesTaskTemp());
			
			//TODO: Add views...
			addSequentialTask(new AddViewToContextTask(contextView, new CanvasView()));
			addSequentialTask(new AddViewToContextTask(contextView, new BrushView()));
			addSequentialTask(new AddViewToContextTask(contextView, new GuiPhoneView()));
			
			start();
		}
	}
}
