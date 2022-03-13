package controller.commands
{
	import com.adobe.images.PNGEncoder;

	import flash.display.BitmapData;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.globalization.DateTimeFormatter;
	import flash.utils.ByteArray;

	import model.CanvasModel;

	import se.salomonsson.sequence.robotlegs.SequenceCommand;

	/**
	 *
	 * @author: Tobi Wan Kenobi
	 */
	public class SaveImageCommand extends SequenceCommand
	{
		[Inject] public var _canvasModel:CanvasModel;
		
		override public function execute():void
		{
			trace("SaveImageCommand");

			var _bmpData:BitmapData = _canvasModel.canvasBmpData;
			
			var byteArray:ByteArray = PNGEncoder.encode(_bmpData);

			var d:Date = new Date();
			var dtf:DateTimeFormatter = new DateTimeFormatter("en-US");
			dtf.setDateTimePattern("yyyyMMdd_hhmmss");

			var imgName:String = "VeilPainter_" + dtf.format(d) + ".png";

			var file:File = File.documentsDirectory.resolvePath("VeilPainter/" + imgName);
			trace("Should save to: " + file.nativePath);

			var fileStream:FileStream = new FileStream();
			fileStream.open(file, FileMode.WRITE);
			fileStream.writeBytes(byteArray);
			fileStream.close();
			
			start();
		}
	}
}
