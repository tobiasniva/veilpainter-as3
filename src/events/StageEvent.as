package events
{
    import flash.events.Event;

    public class StageEvent extends Event
    {
        public static const STAGE_SIZE_CHANGED:String   = "stageSizeChanged";
        public static const UI_SCALE_CHANGED:String     = "uiScaleChanged";

        public function StageEvent(type:String)
        {
            super(type, false, false);
        }

        override public function clone():Event
        {
            return new StageEvent(type);
        }
    }
}