package utils
{
	import behavior.ImageWithLabel;

	import flash.display.Bitmap;
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.filesystem.File;
	import flash.net.URLRequest;

	/**
	 *
	 * @author: Tobi Wan Kenobi
	 */
	public class LoadAlphaImages extends Sprite
	{
		private var _images:Vector.<ImageWithLabel>;

		private var _counter:int;
		private var _totalImages:int;

		public function LoadAlphaImages()
		{
			_images = new <ImageWithLabel>[];

			var folder:File = File.applicationDirectory.resolvePath("alphas");
			var files:Array = folder.getDirectoryListing();

			_totalImages = files.length;

			for each(var file:File in files)
			{
				var loader:Loader = new Loader();
				var urlReq:URLRequest = new URLRequest(file.url);

				loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onLoadComplete);
				loader.load(urlReq);
			}
		}

		private function onLoadComplete(e:Event):void
		{
			_counter++;

			var bmpAlpha:Bitmap = e.target.content as Bitmap;
			var url:String = e.target.url;
			var spl:Array = url.split("/");
			var name:String = spl[spl.length - 1];

			_images.push(new ImageWithLabel(name, bmpAlpha));

			if (_counter == _totalImages)
			{
				_images.sort(alphabetical);

				dispatchEvent(new Event(Event.COMPLETE));
			}
		}

		public function get images():Vector.<ImageWithLabel>
		{
			return _images;
		}

		private function alphabetical(a1:ImageWithLabel, a2:ImageWithLabel):int
		{
			var name1:String = a1.label;
			var name2:String = a2.label;

			if (name1 < name2)
			{
				return -1;
			}
			else if (name1 > name2)
			{
				return 1;
			}
			else
			{
				return 0;
			}
		}
	}
}
