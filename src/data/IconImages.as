package data
{
    import flash.display.DisplayObject;

    public class IconImages
    {
        [Embed(source="/../assets/icons/icon_test.png")]
        private static const Icon_Test:Class;

        public static function iconTest():DisplayObject
        {
            return new Icon_Test() as DisplayObject;
        }
    }
}