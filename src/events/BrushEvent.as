package events
{
    import flash.events.Event;

    public class BrushEvent extends Event
    {
        public static const SETTINGS_CHANGED:String = "brushSettingsChanged";

        public function BrushEvent(type:String)
        {
            super(type, false, false);
        }

        override public function clone():Event
        {
            return new BrushEvent(type);
        }
    }
}