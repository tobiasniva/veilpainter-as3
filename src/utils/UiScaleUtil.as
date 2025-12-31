package utils
{
    import flash.system.Capabilities;

	public final class UiScaleUtil
	{
		// Prevent instantiation
		public function UiScaleUtil() {}

		// Decide a sane integer UI scale (2, 3, or 4) based on DPI and screen size.
		public static function computeUiScale():int
		{
			var dpi:Number = Capabilities.screenDPI;
			if (dpi <= 0 || isNaN(dpi))
				dpi = 240;

			// Coarse, predictable buckets
			if (dpi < 200) return 2;
			if (dpi < 420) return 3;
			return 4;
		}
	}
}