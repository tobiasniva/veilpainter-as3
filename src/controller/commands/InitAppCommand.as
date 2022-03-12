package controller.commands
{
	import consts.ImageConst;

	import event.ColorEvent;

	import flash.display.Bitmap;

	import model.TempModel;

	import se.salomonsson.sequence.robotlegs.SequenceCommand;

	import view.CanvasView;

	/**
	 *
	 * @author: Tobi Wan Kenobi
	 */
	public class InitAppCommand extends SequenceCommand
	{
		[Inject] public var _model:TempModel;

		override public function execute():void
		{
			trace("InitAppCommand");
			
			//-- Add listener for hardware buttons...
//			NativeApplication.nativeApplication.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
//			NativeApplication.nativeApplication.addEventListener(Event.DEACTIVATE, onDeactivate);

			//TODO: Load/embed all images (alphas etc)
			var a1:Bitmap = new ImageConst.Alpha_1();
			var a2:Bitmap = new ImageConst.Alpha_2();
			var a3:Bitmap = new ImageConst.Alpha_3();
			a1.smoothing = true;
			a2.smoothing = true;
			a3.smoothing = true;
			_model.addBrushAlpha(a1);
			_model.addBrushAlpha(a2);
			_model.addBrushAlpha(a3);
			
			//TODO: Init _model - load prefs or set defaults...
			
			//TODO: Add/init all views...
			contextView.addChild(new CanvasView());
			dispatch(new ColorEvent(ColorEvent.BG_COLOR_CHANGED, 0x330000));
			
//			contextView.addChild(new HolderView());
//			addSequentialTask(new InitUserSettingsTask());
			
			start();
		}
	}
}
