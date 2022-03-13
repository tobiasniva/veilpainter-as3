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
		public var alphaImagesWithLabel:Vector.<ImageWithLabel> = new <ImageWithLabel>[];
		public var alphaImageSelectedIndex:int;
		public var color:uint;
		public var alpha:Number;
		public var blendmode:String;
		public var numLinks:int;
		public var chainLinkColor:uint;
		public var chainLinkSize:int;
		public var elasticity:Number;
		public var strength:Number;
		public var degradation:Number;
	}
}