package core
{
    import flash.events.EventDispatcher;

    public class AppEventBus extends EventDispatcher {

        private static var _instance:AppEventBus;

        public function AppEventBus(enforcer:SingletonEnforcer) {
            super();
        }

        public static function get instance():AppEventBus {
            if (_instance == null) {
                _instance = new AppEventBus(new SingletonEnforcer());
            }
            return _instance;
        }
    }
}

class SingletonEnforcer {}
