package view.layout
{
	import flash.display.Stage;
	import flash.events.Event;
    import view.layout.LayoutMetrics;
	import view.Gui;
    import data.Strings;

	public final class LayoutManager
	{
		private var _stage:Stage;
		private var _gui:Gui;

		private var _uiScale:Number;
		private var _selector:LayoutSelector;

		private var _layouts:Object = {};

		private var _lastLayoutKey:String = null;
		private var _lastStageW:int = -1;
		private var _lastStageH:int = -1;

		public function LayoutManager(stage:Stage, gui:Gui, uiScale:Number, selector:LayoutSelector = null)
		{
			_stage = stage;
			_gui = gui;
			_uiScale = uiScale;
			_selector = selector ? selector : new LayoutSelector();
		}

		public function registerLayout(key:String, layout:IGuiLayout):void
		{
			_layouts[key] = layout;
		}

		public function start():void
		{
			_stage.addEventListener(Event.RESIZE, onStageResize);
			refresh(true);
		}

		public function stop():void
		{
			_stage.removeEventListener(Event.RESIZE, onStageResize);
		}

		public function set uiScale(value:Number):void
		{
			// With minimalComps ComponentScale, changing at runtime generally requires rebuilding GUI.
			// This setter exists for future use; for now, store it and re-layout.
			_uiScale = value;
			refresh(true);
		}

		public function get uiScale():Number { return _uiScale; }

		private function onStageResize(e:Event):void
		{
			refresh(false);
		}

		/**
		 * Recompute metrics and apply the best layout.
		 * @param force If true, applies even if stage dims/layout key did not change.
		 */
		public function refresh(force:Boolean = false):void
		{
			var stageW:int = _stage.stageWidth;
			var stageH:int = _stage.stageHeight;

			// Avoid redundant work
			if (!force && stageW == _lastStageW && stageH == _lastStageH)
				return;

			_lastStageW = stageW;
			_lastStageH = stageH;

			var key:String = _selector.layoutKey(stageW, stageH);

			var layout:IGuiLayout = _layouts[key] as IGuiLayout;
			if (!layout)
			{
				// Fallback: prefer phone_portrait if missing
				layout = _layouts[Strings.PHONE_PORTRAIT] as IGuiLayout;
				if (!layout) return; // nothing registered; fail silently
				key = Strings.PHONE_PORTRAIT;
			}

			// If layout key unchanged and not forced, you can still re-apply for safety.
			if (!force && key == _lastLayoutKey)
			{
				// Many apps still want to re-apply on resize, but we already check stage dims changed above.
				// Keep going; stage size changed means we should re-layout.
			}

			_lastLayoutKey = key;

			// Compute logical sizes for your layouts.
			// IMPORTANT: Because you use StyleSizer.ComponentScale(uiScale),
			// you should layout in "logical units" = physical / uiScale.
			var m:LayoutMetrics = new LayoutMetrics(stageW, stageH, _uiScale);

			_gui.applyLayout(m, layout);
		}
	}
}
