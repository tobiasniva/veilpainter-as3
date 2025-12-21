package utils
{
    import flash.net.FileReference;
    import flash.utils.ByteArray;
    import flash.events.Event;
    import flash.events.IOErrorEvent;

    /**
     * Simple helper to save a ByteArray as a file via the OS save UI (Android SAF-style picker).
     */
    public final class SaveImageWithDialog
    {
        private static var _fr:FileReference;
        private static var _onComplete:Function;
        private static var _onCancel:Function;
        private static var _onError:Function;

        public function SaveImageWithDialog()
        {
            throw new Error("SaveImageWithDialog is static. Do not instantiate.");
        }

        /**
         * Opens the system Save dialog and writes the given bytes to a user-chosen location.
         *
         * @param bytes        ByteArray with file contents (PNG data in your case)
         * @param filename     Suggested filename shown in the Save dialog
         * @param onComplete   Optional: function():void
         * @param onCancel     Optional: function():void
         * @param onError      Optional: function(errorText:String):void
         */
        public static function saveBytes(bytes:ByteArray,
                                        filename:String,
                                        onComplete:Function = null,
                                        onCancel:Function = null,
                                        onError:Function = null):void
        {
            if (bytes == null || bytes.length == 0)
            {
                if (onError != null) onError("No data to save.");
                return;
            }

            // Some encoders leave the position at the end; reset to ensure full write.
            bytes.position = 0;

            // Prevent re-entry (double-tap Save) from colliding with an active FileReference.
            if (_fr != null)
            {
                if (onError != null) onError("A save operation is already in progress.");
                return;
            }

            _onComplete = onComplete;
            _onCancel = onCancel;
            _onError = onError;

            _fr = new FileReference();
            _fr.addEventListener(Event.COMPLETE, handleComplete);
            _fr.addEventListener(Event.CANCEL, handleCancel);
            _fr.addEventListener(IOErrorEvent.IO_ERROR, handleError);

            try
            {
                _fr.save(bytes, filename);
            }
            catch (e:Error)
            {
                // If save() throws immediately (rare), clean up and report.
                var msg:String = (e && e.message) ? e.message : "Unknown error";
                cleanup();
                if (_onError != null) _onError(msg);
            }
        }

        /** Convenience wrapper for PNG bytes. */
        public static function savePNG(pngBytes:ByteArray,
                                       filename:String,
                                       onComplete:Function = null,
                                       onCancel:Function = null,
                                       onError:Function = null):void
        {
            saveBytes(pngBytes, filename, onComplete, onCancel, onError);
        }

        private static function handleComplete(e:Event):void
        {
            var cb:Function = _onComplete;
            cleanup();
            if (cb != null) cb();
        }

        private static function handleCancel(e:Event):void
        {
            var cb:Function = _onCancel;
            cleanup();
            if (cb != null) cb();
        }

        private static function handleError(e:IOErrorEvent):void
        {
            var cb:Function = _onError;
            var msg:String = (e && e.text) ? e.text : "IO error";
            cleanup();
            if (cb != null) cb(msg);
        }

        private static function cleanup():void
        {
            if (_fr != null)
            {
                _fr.removeEventListener(Event.COMPLETE, handleComplete);
                _fr.removeEventListener(Event.CANCEL, handleCancel);
                _fr.removeEventListener(IOErrorEvent.IO_ERROR, handleError);
            }
            _fr = null;

            _onComplete = null;
            _onCancel = null;
            _onError = null;
        }
    }
}
