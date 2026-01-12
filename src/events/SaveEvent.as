package events
{
    import flash.events.Event;

    public class SaveEvent extends Event
    {
        public static const SAVE_REQUESTED:String = "saveRequested";

        public function SaveEvent(type:String)
        {
            super(type, false, false);
        }

        override public function clone():Event
        {
            return new SaveEvent(type);
        }
    }
}