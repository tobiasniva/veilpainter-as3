package events
{
    import flash.events.Event;

    public class CanvasEvent extends Event
    {
        public static const TOUCH_START:String      = "canvasTouchStart";
        public static const TOUCH_END:String        = "canvasTouchEnd";

        public static const SETTINGS_CHANGED:String = "canvasSettingsChanged";

        public function CanvasEvent(type:String)
        {
            super(type, false, false);
        }

        override public function clone():Event
        {
            return new CanvasEvent(type);
        }
    }
}