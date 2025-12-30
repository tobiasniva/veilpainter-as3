package utils
{
    import view.*;
    import flash.display.DisplayObjectContainer;

	public class GuiFactory
    {
        //-- Static GUI creation utility
		public static function createGUI(guiType:int, parent:VeilPainter):GuiBase
        {
            switch(guiType) {
                case 1:
                    return new GuiDesktop(parent);
                    break;
                case 2:
                    return new GuiPhone(parent); //TODO: Create GuiTablet...
                    break;
                case 4:
                    return new GuiPhone(parent);
                    break;
                default:
                    return new GuiDesktop(parent);
            }
        }

        //-- Static popup creation utility
        public static function createAndShowPopup(parent:DisplayObjectContainer, header:String, msg:String):void
        {
			var dlg:ModalDialog = new ModalDialog(parent);
			dlg.show(header, msg, "OK",
				function():void
				{
					trace("User clicked OK");
				}
			);
        }
    }
}