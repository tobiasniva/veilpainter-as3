package controller.commands
{
	import flash.desktop.NativeApplication;

	import org.robotlegs.mvcs.Command;

	/**
	 *
	 * @author: Tobi Wan Kenobi
	 */
	public class QuitAppCommand extends Command
	{

		override public function execute():void
		{
			trace("QuitAppCommand");
			
			NativeApplication.nativeApplication.exit();
		}
	}
}
