package view.layout
{
	import flash.geom.Rectangle;

	public class LayoutMetrics
	{
		public var screenW:int;
		public var screenH:int;
		public var uiScale:Number;
		public var isTablet:Boolean;
		public var isPortrait:Boolean;

		public function LayoutMetrics(screenWidth:int, screenHeight:int, uiScale:Number, isTablet:Boolean, isPortrait:Boolean)
		{
			this.screenW = screenWidth;
			this.screenH = screenHeight;
			this.uiScale = uiScale;
			this.isTablet = isTablet;
			this.isPortrait = isPortrait;
		}
	}
}
