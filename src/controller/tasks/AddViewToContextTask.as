package controller.tasks
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;

	import se.salomonsson.sequence.SequentialTask;

	/**
	 *
	 * @author: Tobi Wan Kenobi
	 */
	public class AddViewToContextTask extends SequentialTask
	{
		private var _contextView:DisplayObjectContainer;
		private var _view:DisplayObject;

		public function AddViewToContextTask(contextView:DisplayObjectContainer, view:DisplayObject)
		{
			_contextView = contextView;
			_view = view;
		}
		
		override protected function exeStart():void
		{
			trace("AddViewToContextTask - view: " + _view);
			
			_contextView.addChild(_view);

			onCompleted();
		}
	}
}
