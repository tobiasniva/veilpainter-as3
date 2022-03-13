package controller.commands
{
	import event.BmpDataEvent;

	import model.CanvasModel;

	import se.salomonsson.sequence.robotlegs.SequenceCommand;

	/**
	 *
	 * @author: Tobi Wan Kenobi
	 */
	public class CanvasUpdatedCommand extends SequenceCommand
	{
		[Inject] public var _bmpDataEvent:BmpDataEvent;
		[Inject] public var _canvasModel:CanvasModel;
		
		override public function execute():void
		{
			trace("CanvasUpdatedCommand");

			_canvasModel.canvasBmpData = _bmpDataEvent.bmpData;
			
			dispatch(new BmpDataEvent(BmpDataEvent.NOTIFY_BRUSH_WITH_BMPDATA, _canvasModel.canvasBmpData));
			
			start();
		}
	}
}
