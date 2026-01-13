package core {

    import data.Constants;
    import flash.geom.Point;
    import events.StageEvent;

    public class AppModel
    {
        //TODO: Consider splitting even further - UIModel?

        private static var _instance:AppModel;

        //-- App wise
        private var _stageSize:Point            = new Point(0, 0);
        private var _uiScale:Number             = Constants.UI_SCALE_DEFAULT;

        //-- configs
        public var debugDraw:Boolean            = false;
        public var debugBounds:Boolean          = false;
        public var uiHideOnDraw:Boolean         = Constants.UI_HIDE_ON_DRAW_DEFAULT;


        //-- AppModel getters/setters with event dispatch
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