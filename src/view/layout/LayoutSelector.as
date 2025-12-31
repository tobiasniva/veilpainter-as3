package view.layout
{
    import data.Strings;

	public final class LayoutSelector
	{
		private var _tabletMinPx:int;

		public function LayoutSelector(tabletMinPx:int = 900)
		{
			_tabletMinPx = tabletMinPx;
		}

		// Returns a layout key string you can map to strategies...
		public function layoutKey(screenW:int, screenH:int):String
		{
			var portrait:Boolean = screenH >= screenW;
			var tablet:Boolean = Math.min(screenW, screenH) >= _tabletMinPx;

			if (!tablet && portrait) return Strings.PHONE_PORTRAIT;
			if (!tablet && !portrait) return Strings.PHONE_LANDSCAPE;
			if (tablet && portrait) return Strings.TABLET_PORTRAIT;
			return Strings.TABLET_LANDSCAPE;
		}
	}
}