package core {

    import data.Constants;
    import flash.geom.Point;
    import events.StageEvent;
    import events.UIEvent;
    import data.SettingsViewActive;

    public class AppModel
    {
        //TODO: Consider splitting even further - UIModel?

        private static var _instance:AppModel;

        //-- App wise
        private var _stageSize:Point            = new Point(0, 0);
        private var _uiScale:Number             = Constants.UI_SCALE_DEFAULT;
        private var _uiActiveSettingsView:int   = SettingsViewActive.NONE;

        //-- configs
        private var _debugDraw:Boolean          = false; //TODO: Figure out where supposed to live - if more bruhes etc?
        private var _debugBounds:Boolean        = Constants.UI_DEBUG_BOUNDS_DEFAULT;

        public var uiHideOnDraw:Boolean         = Constants.UI_HIDE_ON_DRAW_DEFAULT; //TODO: Implement getter/setter...

        //-- AppModel getters/setters with event dispatch
        public function get uiActiveSettingView():int { return _uiActiveSettingsView; }
        public function set uiActiveSettingView(value:int):void
        {
        	_uiActiveSettingsView = value;
            AppEventBus.instance.dispatchEvent(new UIEvent(UIEvent.SELECTED_SETTINGS_INDEX_CHANGED));
        } 

        public function get debugDraw():Boolean { return _debugDraw; }
        public function set debugDraw(value:Boolean):void
        {
        	_debugDraw = value;
        }

        public function get debugBounds():Boolean {	return _debugBounds; }
        public function set debugBounds(value:Boolean):void {
            if (_debugBounds != value) {
        	    _debugBounds = value;
                AppEventBus.instance.dispatchEvent(new StageEvent(StageEvent.UI_SCALE_CHANGED));
            }
        }

        public function get stageSize():Point { return _stageSize; }
        public function set stageSize(value:Point):void {
            if (_stageSize != value) {
                _stageSize = value;
                AppEventBus.instance.dispatchEvent(new StageEvent(StageEvent.STAGE_SIZE_CHANGED));
            }
        }

        public function get uiScale():Number { return _uiScale; }
        public function set uiScale(value:Number):void {
            if (_uiScale != value) {
                _uiScale = value;
                AppEventBus.instance.dispatchEvent(new StageEvent(StageEvent.UI_SCALE_CHANGED));
            }
        }


        //-- AppModel instance stuff...
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