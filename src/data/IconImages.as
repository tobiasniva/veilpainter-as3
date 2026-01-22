package data
{
    import flash.display.DisplayObject;

    public class IconImages
    {
        [Embed(source="/../assets/icons/icon_brush.png")]
        private static const Icon_Brush:Class;

        [Embed(source="/../assets/icons/icon_canvas.png")]
        private static const Icon_Canvas:Class;

        [Embed(source="/../assets/icons/icon_dbg.png")]
        private static const Icon_Dbg:Class;

        [Embed(source="/../assets/icons/icon_delete_small.png")]
        private static const Icon_Delete_Small:Class;

        [Embed(source="/../assets/icons/icon_delete.png")]
        private static const Icon_Delete:Class;

        [Embed(source="/../assets/icons/icon_preset_small.png")]
        private static const Icon_Preset_Small:Class;

        [Embed(source="/../assets/icons/icon_save.png")]
        private static const Icon_Save:Class;

        [Embed(source="/../assets/icons/icon_settings.png")]
        private static const Icon_Settings:Class;

        public static function iconBrush():DisplayObject
        {
            return new Icon_Brush() as DisplayObject;
        }

        public static function iconCanvas():DisplayObject
        {
            return new Icon_Canvas() as DisplayObject;
        }

        public static function iconDbg():DisplayObject
        {
            return new Icon_Dbg() as DisplayObject;
        }

        public static function iconDelete_Small():DisplayObject
        {
            return new Icon_Delete_Small() as DisplayObject;
        }

        public static function iconDelete():DisplayObject
        {
            return new Icon_Delete() as DisplayObject;
        }

        public static function iconPreset_Small():DisplayObject
        {
            return new Icon_Preset_Small() as DisplayObject;
        }

        public static function iconSave():DisplayObject
        {
            return new Icon_Save() as DisplayObject;
        }

        public static function iconSettings():DisplayObject
        {
            return new Icon_Settings() as DisplayObject;
        }
    }
}