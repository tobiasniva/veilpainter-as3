package core {

    import data.Constants;
    import flash.geom.Point;

    public class AppModel
    {
        //TODO: Consider splitting even further - UIModel?

        private static var _instance:AppModel;

        //-- App wise
        public var stageSize:Point              = new Point(0, 0);
        public var uiScale:Number               = Constants.UI_SCALE_DEFAULT;

        //-- configs
        public var debugDraw:Boolean            = false;
        public var uiHideOnDraw:Boolean         = Constants.UI_HIDE_ON_DRAW_DEFAULT;

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