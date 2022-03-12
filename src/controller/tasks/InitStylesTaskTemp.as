package controller.tasks
{
	import com.bit101.components.Style;

	import se.salomonsson.sequence.SequentialTask;

	import ui.StyleSizer;

	/**
	 *
	 * @author: Tobi Wan Kenobi
	 */
	public class InitStylesTaskTemp extends SequentialTask
	{

		override protected function exeStart():void
		{
			//TODO: Figure out this, since we don't have access to screensizes yet...
			
			StyleSizer.ComponentScale(3);
//			Style.setStyle(Style.DARK);
			Style.setStyle(Style.LIGHT);
			
			onCompleted();
		}
	}
}
