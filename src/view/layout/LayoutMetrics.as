package view.layout
{
	import flash.geom.Rectangle;

	public class LayoutMetrics
	{
		public var logicalW:int;
		public var logicalH:int;

		public var uiScale:Number;     // root scale (if you use a scaled uiRoot)
		public var isTablet:Boolean;
		public var isPortrait:Boolean;

		// Optional: safe rect in logical coords (if you later support notches/cutouts)
		public var safe:Rectangle;

		public function LayoutMetrics(logicalW:int, logicalH:int, uiScale:Number,
									  isTablet:Boolean, isPortrait:Boolean)
		{
			this.logicalW = logicalW;
			this.logicalH = logicalH;
			this.uiScale = uiScale;
			this.isTablet = isTablet;
			this.isPortrait = isPortrait;

			this.safe = new Rectangle(0, 0, logicalW, logicalH);
		}
	}
}
