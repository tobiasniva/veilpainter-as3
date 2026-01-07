package events
{
    import flash.events.Event;

    public class DrawEvent extends Event
    {
        public static const DRAW_STARTED:String = "inputDrawStarted";
        public static const DRAW_ENDED:String   = "inputDrawEnded";

        public function DrawEvent(type:String)
        {
            super(type, false, false);
        }

        override public function clone():Event
        {
            return new DrawEvent(type);
        }
    }
}