package data
{
	import flash.display.BlendMode;

	/**
	 *
	 * @author: Tobi Wan Kenobi
	 */
	public class BlendModes
	{
		//-- STANDARD - curated list - defaults...
		public static function getStandard():Array
		{
			var arr:Array = [];
			
			arr.push(BlendMode.NORMAL);
			arr.push(BlendMode.ADD);
			arr.push(BlendMode.MULTIPLY);
			arr.push(BlendMode.OVERLAY);
			
			arr.push(BlendMode.SCREEN);
			arr.push(BlendMode.DIFFERENCE);
			arr.push(BlendMode.ERASE);
			arr.push(BlendMode.SUBTRACT);
			
			return arr;
		}

		//-- COMPACT list with most 'useful' ones
		public static function getCompact():Array
		{
			var arr:Array = [];
			
			arr.push(BlendMode.NORMAL);
			arr.push(BlendMode.ADD);
			arr.push(BlendMode.MULTIPLY);
			arr.push(BlendMode.OVERLAY);
			return arr;
		}

		//-- EXTENDED list with all modes...
		public static function getAll():Array
		{
			var arr:Array = [];
			
			// we put the most common at top of list
			arr.push(BlendMode.NORMAL);
			arr.push(BlendMode.ADD);
			arr.push(BlendMode.MULTIPLY);
			arr.push(BlendMode.OVERLAY);
			
			arr.push(BlendMode.SCREEN);
			arr.push(BlendMode.LIGHTEN);
			arr.push(BlendMode.DARKEN);
			arr.push(BlendMode.HARDLIGHT);
			
			arr.push(BlendMode.ALPHA);
			arr.push(BlendMode.DIFFERENCE);
			arr.push(BlendMode.ERASE);
			arr.push(BlendMode.INVERT);
			arr.push(BlendMode.LAYER);
			arr.push(BlendMode.SUBTRACT);
			
			return arr;
		}
	}
}
