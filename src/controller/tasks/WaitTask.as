package controller.tasks
{
	import flash.display.DisplayObjectContainer;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.utils.Timer;

	import se.salomonsson.sequence.SequentialTask;

	public class WaitTask extends SequentialTask
	{
		[Inject] public var contextView:DisplayObjectContainer;
		private var _seconds:Number;
		private var _timer:Timer;
		private var _isClickAbortable:Boolean;
		
		public function WaitTask(seconds:Number = 1.0, isClickAbortable:Boolean = false)
		{
			_seconds = seconds;
			_isClickAbortable = isClickAbortable;
		}

		override protected function exeStart():void
		{
			_timer = new Timer(_seconds * 1000, 1);
			_timer.addEventListener(TimerEvent.TIMER_COMPLETE, onTimerComplete);
			_timer.start();
			
			if(_isClickAbortable)
				contextView.addEventListener(MouseEvent.CLICK, onClicked);
		}

		private function onClicked(e:MouseEvent):void
		{
			removeListeners();
			onCompleted();
		}

		private function onTimerComplete(e:TimerEvent):void
		{
			removeListeners();
			onCompleted();
		}

		private function removeListeners():void
		{
			if(contextView != null)
				contextView.removeEventListener(MouseEvent.CLICK, onClicked);
			
			if(_timer != null)
			{
				_timer.removeEventListener(TimerEvent.TIMER_COMPLETE, onTimerComplete);
				_timer = null;
			}
		}

		override protected function exeCleanUp():void
		{
			_timer = null;
		}

		override protected function exeAbort():void
		{
			trace("WaitTask - ABORTED!");
			exeCleanUp();
		}
	}
}
