package core {

    import data.Constants;
    import flash.display.BitmapData;
    import events.CanvasEvent;

    public class CanvasModel
    {
        private static var _instance:CanvasModel;

        private var _bitmapData:BitmapData;
        private var _color:uint       = Constants.CANVAS_COLOR_DEFAULT;
        private var _multiplier:int   = Constants.CANVAS_MULTIPLIER_DEFAULT;

        //-- Canvas getters/setters with event dispatch
        public function get bitmapData():BitmapData { return _bitmapData; }
        public function set bitmapData(value:BitmapData):void {
            if (_bitmapData != value) {
                _bitmapData = value;
                AppEventBus.instance.dispatchEvent(new CanvasEvent(CanvasEvent.SETTINGS_CHANGED));
            }
        }

        public function get color():uint { return _color; }
        public function set color(value:uint):void {
            if (_color != value) {
                _color = value;
                AppEventBus.instance.dispatchEvent(new CanvasEvent(CanvasEvent.SETTINGS_CHANGED));
            }
        }

        public function get multiplier():int { return _multiplier; }
        public function set multiplier(value:int):void {
            if (_multiplier != value) {
                _multiplier = value;
                AppEventBus.instance.dispatchEvent(new CanvasEvent(CanvasEvent.SETTINGS_CHANGED));
            }
        }


        //-- CanvasModel instance...
        public function CanvasModel(enforcer:SingletonEnforcer) {}

        public static function get instance():CanvasModel {
            if (_instance == null) {
                _instance = new CanvasModel(new SingletonEnforcer());
            }
            return _instance;
        }
    }
}

class SingletonEnforcer {}