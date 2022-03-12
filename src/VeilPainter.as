package
{
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageDisplayState;
	import flash.display.StageQuality;
	import flash.display.StageScaleMode;

	[SWF(backgroundColor="#000000", frameRate="60", width="1024", height="768")]
	public class VeilPainter extends Sprite
	{
		protected var _context:VeilPainterContext;

		public function VeilPainter()
		{
			stage.quality       = StageQuality.HIGH; // Borrowed from MarbleFalls...
			stage.scaleMode 	= StageScaleMode.NO_SCALE;
			stage.align 		= StageAlign.TOP_LEFT;
			stage.displayState 	= StageDisplayState.FULL_SCREEN;
//			stage.displayState 	= StageDisplayState.FULL_SCREEN_INTERACTIVE; //-- Needed to be able to type into e.g. color chooser!

			_context = new VeilPainterContext(this);

			// used for our "press F1 to trace the status of any running sequence". Great for finding sequences that has stuck.
//			SequenceHandler.debugStage = _context.contextView.stage;
		}
	}
}
