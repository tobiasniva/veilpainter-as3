package services
{
    import core.AppEventBus;
    import core.CanvasModel;
    import events.SaveEvent;
    import flash.display.BitmapData;
    import flash.utils.ByteArray;
    import flash.filesystem.File;
    import flash.globalization.DateTimeFormatter;
    import utils.SaveImageWithDialog;
    import com.adobe.images.PNGEncoder;


    public class SaveImageService
    {
        private static var _initialized:Boolean = false;

        public static function init():void
        {
            if (_initialized) return;
            _initialized = true;

            AppEventBus.instance.addEventListener(SaveEvent.SAVE_REQUESTED, onSaveRequested);
        }

        public static function shutdown():void
        {
            if (!_initialized) return;
            _initialized = false;

            AppEventBus.instance.removeEventListener(SaveEvent.SAVE_REQUESTED, onSaveRequested);
        }

        private static function onSaveRequested(e:SaveEvent):void
        {
            saveCanvasPng();
        }

        public static function saveCanvasPng():void
        {
            trace("perm status: " + File.permissionStatus);

            var bmp:BitmapData = CanvasModel.instance.bitmapData;
            if (!bmp)
            {
                trace("Save aborted: no bitmapData available in CanvasModel.");
                return;
            }

            // Important: clone so you don't risk encoding a BitmapData that changes/disposes mid-encode
            var clone:BitmapData;
            try
            {
                clone = bmp.clone();
            }
            catch (err:Error)
            {
                trace("Save failed: could not clone bitmapData: " + err.message);
                return;
            }

            var bytes:ByteArray;
            try
            {
                bytes = PNGEncoder.encode(clone);
            }
            catch (err2:Error)
            {
                trace("Save failed: PNG encode error: " + err2.message);
                clone.dispose();
                return;
            }

            clone.dispose();

            var imgName:String = buildFilename();

            SaveImageWithDialog.savePNG(
                bytes,
                imgName,
                function():void { trace("Saved: " + imgName); },
                function():void { trace("User canceled"); },
                function(err:String):void
                {
                    trace("Save failed: " + err);
                    // TODO: show popup/hint (e.g. try Downloads)
                }
            );
        }

        private static function buildFilename():String
        {
            var dtf:DateTimeFormatter = new DateTimeFormatter("en-US");
            dtf.setDateTimePattern("yyyyMMdd_HHmmss");
            return "veil_" + dtf.format(new Date()) + ".png";
        }
    }
}
