package core {

    import data.Constants;
	import flash.geom.Point;

    public class AppModel
	{
        private static var _instance:AppModel;

		//-- App wise
		public var stageSize:Point				= new Point(0, 0);
		public var uiScale:Number 				= Constants.UI_SCALE_DEFAULT;

		//-- canvas
		public var canvasColor:uint 			= Constants.CANVAS_COLOR_DEFAULT;
        public var canvasMultiplier:int         = Constants.CANVAS_MULTIPLIER_DEFAULT;

		//-- brush
        public var brushColor:uint 				= Constants.BRUSH_COLOR_DEFAULT;
        public var brushAlpha:Number 			= Constants.BRUSH_ALPHA_DEFAULT;
        public var brushBlendMode:String 		= Constants.BRUSH_BLENDMODE_DEFAULT;
        public var brushBlendModeIndex:int 		= Constants.BRUSH_BLENDMODE_INDEX;

        public var brushLinkColor:uint 			= Constants.CHAIN_LINK_COLOR;
        public var brushLinkSize:int 			= Constants.CHAIN_LINK_SIZE;
        public var brushNumLinks:int 			= Constants.NUM_LINKS_DEFAULT;
        
		public var brushElasticity:Number		= Constants.ELASTICITY_DEFAULT;
        public var brushStrength:Number			= Constants.STRENGTH_DEFAULT;
        public var brushDegradation:Number		= Constants.DEGRADATION_DEFAULT;

		//-- configs
		public var debugDraw:Boolean = false;


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