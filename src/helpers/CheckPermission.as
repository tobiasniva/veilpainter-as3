package helpers
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.PermissionEvent;
	import flash.filesystem.File;
	import flash.permissions.PermissionStatus;

	/**
	 *
	 * @author: Tobi Wan Kenobi
	 */
	public class CheckPermission extends Sprite
	{
		private var f:File;

		public function StartCheck():void
		{
			if(File.permissionStatus != PermissionStatus.GRANTED)
			{
				f = File.documentsDirectory.resolvePath("dummy.png");
				f.addEventListener(PermissionEvent.PERMISSION_STATUS, onPermission);
				f.requestPermission();
			}
			else
			{
				permissionSucceeded();
			}
		}

		private function onPermission(e:PermissionEvent)
		{
			trace("onPermission " + e.status);
			f.removeEventListener(PermissionEvent.PERMISSION_STATUS, onPermission);

			if(File.permissionStatus != PermissionStatus.GRANTED)
			{
				permissionFailed();
			}
			else
			{
				permissionSucceeded();
			}
		}

		private function permissionSucceeded():void
		{
			trace("Permission ok.");
			dispatchEvent(new Event(Event.COMPLETE));
		}

		private function permissionFailed():void
		{
			dispatchEvent(new Event(Event.CANCEL));
		}
	}
}
