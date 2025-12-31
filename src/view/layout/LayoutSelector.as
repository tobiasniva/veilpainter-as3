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

		public function isPortrait(screenW:int, screenH:int):Boolean
		{
			return screenH >= screenW;
		}

		public function isTablet(screenW:int, screenH:int):Boolean
		{
			return Math.min(screenW, screenH) >= _tabletMinPx;
		}

		// Returns a layout key string you can map to strategies...
		public function layoutKey(screenW:int, screenH:int):String
		{
			var portrait:Boolean = isPortrait(screenW, screenH);
			var tablet:Boolean = isTablet(screenW, screenH);

			if (!tablet && portrait) return Strings.PHONE_PORTRAIT;
			if (!tablet && !portrait) return Strings.PHONE_LANDSCAPE;
			if (tablet && portrait) return Strings.TABLET_PORTRAIT;
			return Strings.TABLET_LANDSCAPE;
		}
	}
}