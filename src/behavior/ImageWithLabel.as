package behavior
{
	import flash.display.Bitmap;

	/**
	 *
	 * @author: Tobi Wan Kenobi
	 */
	public class ImageWithLabel
	{
		private var _label:String;
		private var _bitmap:Bitmap;
		
		public function ImageWithLabel(label:String, bitmap:Bitmap)
		{
			_label = label;
			_bitmap = bitmap;
		}

		public function get label():String
		{
			return _label;
		}

		public function get bitmap():Bitmap
		{
			return _bitmap;
		}
	}
}
