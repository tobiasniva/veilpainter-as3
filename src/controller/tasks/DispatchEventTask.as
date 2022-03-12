package controller.tasks
{
	import flash.events.Event;

	import se.salomonsson.sequence.SequentialTask;

	/**
	 *
	 * @author Jonas Åhblom, QuickSpin AB
	 */
	public class DispatchEventTask extends SequentialTask
	{
		private var _event:Event;

		public function DispatchEventTask(event:Event)
		{
			_event = event;

			setName("DispatchEventTask (with event: " + _event + ")");
		}


		override protected function exeStart():void
		{
			dispatch(_event.clone());
			onCompleted();
		}


		override protected function exeCleanUp():void
		{
			_event = null;
		}
	}
}
