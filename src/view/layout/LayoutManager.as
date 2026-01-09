package view.layout
{
	import view.Gui;
	import data.Strings;
	import core.AppModel;

	public final class LayoutManager
	{
		private var _gui:Gui;
		private var _uiScale:Number;
		private var _selector:LayoutSelector;

		private var _layouts:Object = {};
		private var _lastKey:String = null;
		private var _lastW:int = -1;
		private var _lastH:int = -1;

		public function LayoutManager(gui:Gui, uiScale:Number, selector:LayoutSelector = null)
		{
			_gui = gui;
			_uiScale = uiScale;
			_selector = selector ? selector : new LayoutSelector();
		}

		public function registerLayout(key:String, layout:IGuiLayout):void
		{
			_layouts[key] = layout;
		}

		public function set uiScale(value:Number):void
		{
			_uiScale = value;
		}
		
		// whenever screen size or orientation changes...
		public function refresh(force:Boolean = false):void
		{
			var screenW:int = AppModel.instance.stageSize.x;
			var screenH:int = AppModel.instance.stageSize.y;

			if (!force && screenW == _lastW && screenH == _lastH)
				return;

			_lastW = screenW;
			_lastH = screenH;

			var key:String = _selector.layoutKey(screenW, screenH);
			var layout:IGuiLayout = _layouts[key] as IGuiLayout;

			if (!layout)
			{
				layout = _layouts[Strings.PHONE_PORTRAIT] as IGuiLayout;
				if (!layout) return;
				key = Strings.PHONE_PORTRAIT;
			}

			_lastKey = key;

			var m:LayoutMetrics = new LayoutMetrics(screenW, screenH, _uiScale);
			_gui.applyLayout(m, layout);
		}
	}
}