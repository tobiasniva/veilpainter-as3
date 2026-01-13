package view
{
    import flash.display.Sprite;
    import flash.events.Event;

    public class GuiBase extends Sprite
    {
        private var _initialized:Boolean = false;

        public function GuiBase()
        {
            super();
            mouseEnabled = false;

            if (stage)
                handleAddedToStage();
            else
                addEventListener(Event.ADDED_TO_STAGE, handleAddedToStage);
        }

        private function handleAddedToStage(e:Event = null):void
        {
            removeEventListener(Event.ADDED_TO_STAGE, handleAddedToStage);
            addEventListener(Event.REMOVED_FROM_STAGE, handleRemovedFromStage);

            if (!_initialized)
            {
                _initialized = true;
                onInit(); // -- one-time init hook
            }

            onAddedToStage(); // -- optional hook...
        }

        private function handleRemovedFromStage(e:Event):void
        {
            removeEventListener(Event.REMOVED_FROM_STAGE, handleRemovedFromStage);
            onRemovedFromStage(); // -- hook removal...
        }

        // -- Hooks for subclasses...
        protected function onInit():void
        {
        }

        protected function onAddedToStage():void
        {
        }
        
        protected function onRemovedFromStage():void
        {
        }
    }
}
