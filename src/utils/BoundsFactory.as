package utils
{
	import flash.display.Sprite;

	public class BoundsFactory
	{
		public static function drawBounds(parent:Sprite, width:int, height:int, color:uint = 0xff0000, alpha:Number = 0.05):void
		{
            parent.graphics.clear();
			parent.graphics.lineStyle(1, color);
			parent.graphics.beginFill(color, alpha);
			parent.graphics.drawRect(0, 0, width - 1, height - 1);
			parent.graphics.endFill();
		}
	}
}
