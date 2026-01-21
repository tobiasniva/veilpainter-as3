package data
{
    import flash.display.DisplayObject;

    public class IconImages
    {
        [Embed(source="/../assets/icons/icon_test.png")]
        private static const Icon_Test:Class;

        [Embed(source="/../assets/icons/icon_preset.png")]
        private static const Icon_Preset:Class;

        public static function iconTest():DisplayObject
        {
            return new Icon_Test() as DisplayObject;
        }

        public static function iconPreset():DisplayObject
        {
            return new Icon_Preset() as DisplayObject;
        }
    }
}