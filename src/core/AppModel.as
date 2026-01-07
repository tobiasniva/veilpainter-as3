package core {

    import data.Constants;
    import flash.geom.Point;
    import events.BrushEvent;

    public class AppModel
    {
        private static var _instance:AppModel;

        //-- App wise
        public var stageSize:Point              = new Point(0, 0);                          //-- Needs init outsisde...
        public var uiScale:Number               = Constants.UI_SCALE_DEFAULT;

        //-- canvas
        public var canvasColor:uint             = Constants.CANVAS_COLOR_DEFAULT;
        public var canvasMultiplier:int         = Constants.CANVAS_MULTIPLIER_DEFAULT;

        //-- brush (private backing fields)
        private var _brushColor:uint            = Constants.BRUSH_COLOR_DEFAULT;
        private var _brushOpacity:Number         = Constants.BRUSH_OPACITY_DEFAULT;
        private var _brushAlphaImage:int        = 0;
        private var _brushBlendMode:String      = Constants.BRUSH_BLENDMODE_DEFAULT;
        private var _brushBlendModeIndex:int    = Constants.BRUSH_BLENDMODE_INDEX;
        private var _brushLinkColor:uint        = Constants.CHAIN_LINK_COLOR;
        private var _brushLinkSize:int          = Constants.CHAIN_LINK_SIZE;
        private var _brushNumLinks:int          = Constants.NUM_LINKS_DEFAULT;
        private var _brushElasticity:Number     = Constants.ELASTICITY_DEFAULT;
        private var _brushStrength:Number       = Constants.STRENGTH_DEFAULT;
        private var _brushDegradation:Number    = Constants.DEGRADATION_DEFAULT;

        //-- configs
        public var debugDraw:Boolean            = false;
        public var uiHideOnDraw:Boolean         = Constants.UI_HIDE_ON_DRAW_DEFAULT;


        //-- Brush getters/setters with event dispatch
        public function get brushColor():uint { return _brushColor; }
        public function set brushColor(value:uint):void {
            if (_brushColor != value) {
                _brushColor = value;
                AppEventBus.instance.dispatchEvent(new BrushEvent(BrushEvent.SETTINGS_CHANGED, true));
            }
        }

        public function get brushOpacity():Number { return _brushOpacity; }
        public function set brushOpacity(value:Number):void {
            if (_brushOpacity != value) {
                _brushOpacity = value;
                AppEventBus.instance.dispatchEvent(new BrushEvent(BrushEvent.SETTINGS_CHANGED, true));
            }
        }

        public function get brushAlphaImage():int { return _brushAlphaImage; }
        public function set brushAlphaImage(value:int):void {
            if (_brushAlphaImage != value) {
                _brushAlphaImage = value;
                AppEventBus.instance.dispatchEvent(new BrushEvent(BrushEvent.SETTINGS_CHANGED, true));
            }
        }

        public function get brushBlendMode():String { return _brushBlendMode; }
        public function set brushBlendMode(value:String):void {
            if (_brushBlendMode != value) {
                _brushBlendMode = value;
                AppEventBus.instance.dispatchEvent(new BrushEvent(BrushEvent.SETTINGS_CHANGED, true));
            }
        }

        public function get brushBlendModeIndex():int { return _brushBlendModeIndex; }
        public function set brushBlendModeIndex(value:int):void {
            if (_brushBlendModeIndex != value) {
                _brushBlendModeIndex = value;
                AppEventBus.instance.dispatchEvent(new BrushEvent(BrushEvent.SETTINGS_CHANGED));
            }
        }

        public function get brushLinkColor():uint { return _brushLinkColor; }
        public function set brushLinkColor(value:uint):void {
            if (_brushLinkColor != value) {
                _brushLinkColor = value;
                AppEventBus.instance.dispatchEvent(new BrushEvent(BrushEvent.SETTINGS_CHANGED));
            }
        }

        public function get brushLinkSize():int { return _brushLinkSize; }
        public function set brushLinkSize(value:int):void {
            if (_brushLinkSize != value) {
                _brushLinkSize = value;
                AppEventBus.instance.dispatchEvent(new BrushEvent(BrushEvent.SETTINGS_CHANGED));
            }
        }

        public function get brushNumLinks():int { return _brushNumLinks; }
        public function set brushNumLinks(value:int):void {
            if (_brushNumLinks != value) {
                _brushNumLinks = value;
                AppEventBus.instance.dispatchEvent(new BrushEvent(BrushEvent.SETTINGS_CHANGED));
            }
        }

        public function get brushElasticity():Number { return _brushElasticity; }
        public function set brushElasticity(value:Number):void {
            if (_brushElasticity != value) {
                _brushElasticity = value;
                AppEventBus.instance.dispatchEvent(new BrushEvent(BrushEvent.SETTINGS_CHANGED));
            }
        }

        public function get brushStrength():Number { return _brushStrength; }
        public function set brushStrength(value:Number):void {
            if (_brushStrength != value) {
                _brushStrength = value;
                AppEventBus.instance.dispatchEvent(new BrushEvent(BrushEvent.SETTINGS_CHANGED));
            }
        }

        public function get brushDegradation():Number { return _brushDegradation; }
        public function set brushDegradation(value:Number):void {
            if (_brushDegradation != value) {
                _brushDegradation = value;
                AppEventBus.instance.dispatchEvent(new BrushEvent(BrushEvent.SETTINGS_CHANGED));
            }
        }

        //-- Model instance stuff...
        public function AppModel(enforcer:SingletonEnforcer) {}

        public static function get instance():AppModel {
            if (_instance == null) {
                _instance = new AppModel(new SingletonEnforcer());
            }
            return _instance;
        }
    }
}

class SingletonEnforcer {}