package events
{
    import flash.events.Event;

    public class BrushEvent extends Event
    {
        public static const SETTINGS_CHANGED:String = "brushSettingsChanged";
        public var shouldRegenerate:Boolean;

        public function BrushEvent(type:String, shouldRegenerate:Boolean = false)
        {
            super(type, false, false);
            this.shouldRegenerate = shouldRegenerate;
        }

        override public function clone():Event
        {
            return new BrushEvent(type, shouldRegenerate);
        }
    }
}