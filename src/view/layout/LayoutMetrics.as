package view.layout
{
	import flash.geom.Rectangle;

	public class LayoutMetrics
	{
		public var screenW:int;
		public var screenH:int;
		public var uiScale:int;

		public function LayoutMetrics(screenWidth:int, screenHeight:int, uiScale:int)
		{
			this.screenW = screenWidth;
			this.screenH = screenHeight;
			this.uiScale = uiScale;
		}
	}
}