package events
{
    import flash.events.Event;

    public class CanvasEvent extends Event
    {
        public static const CANVAS_TOUCH_START:String = "canvasTouchStart";
        public static const CANVAS_TOUCH_END:String   = "canvasTouchEnd";

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