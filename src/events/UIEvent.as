package events
{
    import flash.events.Event;

    public class UIEvent extends Event
    {
        public static const SHOW_BRUSH_SETTINGS:String = "showBrushSettings";
        public static const SHOW_CANVAS_SETTINGS:String = "showCanvasSettings";
        public static const SHOW_APP_SETTINGS:String = "showAppSettings";

        public static const HIDE_ACTIVE:String = "hideActiveSettings";

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