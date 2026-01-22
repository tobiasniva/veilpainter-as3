package data
{
    import flash.display.DisplayObject;

    public class IconImages
    {
        [Embed(source="/../assets/icons/icon_dbg.png")]
        private static const Icon_Dbg:Class;

        [Embed(source="/../assets/icons/icon_preset.png")]
        private static const Icon_Preset:Class;

        [Embed(source="/../assets/icons/icon_delete.png")]
        private static const Icon_Delete:Class;

        public static function iconDbg():DisplayObject
        {
            return new Icon_Dbg() as DisplayObject;
        }

        public static function iconPreset():DisplayObject
        {
            return new Icon_Preset() as DisplayObject;
        }

        public static function iconDelete():DisplayObject
        {
            return new Icon_Delete() as DisplayObject;
        }
    }
}