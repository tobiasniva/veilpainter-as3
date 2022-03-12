package controller.tasks
{
	import behavior.ImageWithLabel;

	import consts.ImageConst;

	import flash.display.Bitmap;

	import model.BrushModel;

	import se.salomonsson.sequence.SequentialTask;

	/**
	 *
	 * @author: Tobi Wan Kenobi
	 */
	public class PopulateModelWithImagesTask extends SequentialTask
	{
		[Inject] public var _brushModel:BrushModel;
		
		override protected function exeStart():void
		{
			var a1:Bitmap = new ImageConst.Alpha_1();
			var a2:Bitmap = new ImageConst.Alpha_2();
			var a3:Bitmap = new ImageConst.Alpha_3();
			
			a1.smoothing = a2.smoothing = a3.smoothing = true; // smooth...
			
			var imgLbl_1:ImageWithLabel = new ImageWithLabel("alpha_1", a1);
			var imgLbl_2:ImageWithLabel = new ImageWithLabel("alpha_2", a2);
			var imgLbl_3:ImageWithLabel = new ImageWithLabel("alpha_3", a3);
			
			_brushModel.alphaImagesWithLabel.push(imgLbl_1);
			_brushModel.alphaImagesWithLabel.push(imgLbl_2);
			_brushModel.alphaImagesWithLabel.push(imgLbl_3);
			
			onCompleted();
		}
	}
}
