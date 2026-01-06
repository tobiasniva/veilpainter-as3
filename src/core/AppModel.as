package core {

	import flash.display.BlendMode;

    public class AppModel
	{
        private static var _instance:AppModel;

		//-- App wise
		public var uiScale:Number 				= 1;
		public var stageWidth:int				= 720;
		public var stageHeight:int				= 1280;

		//-- canvas
		public var bgColor:uint 				= 0x222222;

		//-- brush
        public var brushColor:uint 				= 0x99aacc;
        public var brushAlpha:Number 			= 0.5;
        public var brushBlendMode:String 		= BlendMode.NORMAL;
        public var brushBlendModeIndex:int 		= 0;

        public var brushLinkColor:uint 			= 0x808080;
        public var brushLinkSize:int 			= 4;
        public var brushNumLinks:int 			= 4;
        
		public var brushElasticity:Number		= 0.85;
        public var brushStrength:Number			= 0.028;
        public var brushDegradation:Number		= 2.7;

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