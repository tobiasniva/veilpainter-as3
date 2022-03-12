package controller.tasks
{
	import consts.Constants;

	import model.BrushModel;
	import model.CanvasModel;
	import model.UiModel;

	import se.salomonsson.sequence.SequentialTask;

	/**
	 *
	 * @author: Tobi Wan Kenobi
	 */
	public class InitAllModelsTask extends SequentialTask
	{
		[Inject] public var _canvasModel:CanvasModel;
		[Inject] public var _brushModel:BrushModel;
		[Inject] public var _uiModel:UiModel;
		
		override protected function exeStart():void
		{
			//TODO: Consider this a composite task, where we check prefs/sharedObject first...
			
			_canvasModel.sizeMultiplier     = Constants.CANVAS_SIZE_MULTI_DEFAULT;
			_canvasModel.color              = Constants.CANVAS_COLOR_DEFAULT;

			_brushModel.color               = Constants.BRUSH_COLOR_DEFAULT;
			_brushModel.alpha               = Constants.BRUSH_ALPHA_DEFAULT;
			_brushModel.blendmode           = Constants.BRUSH_BLENDMODE_DEFAULT;
			_brushModel.blendmodeIndex      = Constants.BRUSH_BLENDMODE_INDEX;
			_brushModel.numLinks            = Constants.NUM_LINKS_DEFAULT;
			_brushModel.chainLinkColor      = Constants.CHAIN_LINK_COLOR;
			_brushModel.chainLinkSize       = Constants.CHAIN_LINK_SIZE;
			_brushModel.ealsticity          = Constants.ELASTICITY_DEFAULT;
			_brushModel.strength            = Constants.STRENGTH_DEFAULT;
			_brushModel.degradation         = Constants.DEGRADATION_DEFAULT;

			onCompleted();
		}
	}
}
