package model
{
	import behavior.ImageWithLabel;

	import org.robotlegs.mvcs.Actor;

	/**
	 *
	 * @author: Tobi Wan Kenobi
	 */
	public class BrushModel extends Actor
	{
		// BRUSH STUFF
		public var alphasWithLabel:Vector.<ImageWithLabel> = new <ImageWithLabel>[];
		public var color:uint;
		public var alpha:Number;
		public var blendmode:String;
		public var blendmodeIndex:int;
		public var numLinks:int;
		public var chainLinkColor:uint;
		public var chainLinkSize:int;
		public var ealsticity:Number;
		public var strength:Number;
		public var degradation:Number;
	}
}