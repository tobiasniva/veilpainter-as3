package events
{
    import flash.events.Event;

    public class UIEvent extends Event
    {
        public static const SELECTED_SETTINGS_INDEX_CHANGED:String = "selectedSettingsIndexChanged";


        public function UIEvent(type:String)
        {
            super(type, false, false);
        }

        override public function clone():Event
        {
            return new UIEvent(type);
        }
    }
}