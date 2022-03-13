package view
{
	import event.BmpDataEvent;
	import event.ColorEvent;
	import event.IntEvent;
	import event.NumberEvent;
	import event.StringEvent;

	import model.BrushModel;
	import model.CanvasModel;

	import org.robotlegs.mvcs.Mediator;

	/**
	 *
	 * @author: Tobi Wan Kenobi
	 */
	public class BrushMediator extends Mediator
	{
		[Inject] public var _view:BrushView;
		[Inject] public var _canvasModel:CanvasModel;
		[Inject] public var _brushModel:BrushModel;

		override public function onRegister():void
		{
			addContextListener(ColorEvent.BRUSH_COLOR_CHANGED, onBrushColorChanged);
			addContextListener(NumberEvent.BRUSH_ELASTICITY_CHANGED, onBrushElasticityChanged);
			addContextListener(IntEvent.BRUSH_NUMLINKS_CHANGED, onBrushNumlinksChanged);
			addContextListener(NumberEvent.BRUSH_STRENGTH_CHANGED, onBrushStrengthChanged);
			addContextListener(NumberEvent.BRUSH_DEGRADATION_CHANGED, onBrushDegradationChanged);
			addContextListener(NumberEvent.BRUSH_ALPHA_CHANGED, onBrushAlphaChanged);
			addContextListener(StringEvent.BRUSH_BLENDMODE_CHANGED, onBrushBlendmodeChanged);
			addContextListener(BmpDataEvent.NOTIFY_BRUSH_WITH_BMPDATA, onNewBmpData);
			addContextListener(IntEvent.BRUSH_ALPHA_IMG_CHANGED, onAlphaImgChanged);
			
			_view.Init(_canvasModel, _brushModel);
		}

		private function onAlphaImgChanged(e:IntEvent):void
		{
//			trace("BrushMediator::onAlphaImgChanged - index: " + e.value);
			_view.brush.alphaImage = _brushModel.alphaImagesWithLabel[e.value].bitmap;
		}

		private function onNewBmpData(e:BmpDataEvent):void
		{
//			trace("BrushMediator::onNewBmpData");
			_view.brush.canvas = e.bmpData;
		}

		private function onBrushBlendmodeChanged(e:StringEvent):void
		{
//			trace("BrushMediator::onBrushBlendmodeChanged - " + e.value);
			_view.brush.brushBlendmode = e.value;
		}

		private function onBrushAlphaChanged(e:NumberEvent):void
		{
//			trace("BrushMediator::onBrushAlphaChanged - " + e.value);
			_view.brush.brushAlpha = e.value;
		}

		private function onBrushDegradationChanged(e:NumberEvent):void
		{
//			trace("BrushMediator::onBrushDegradationChanged - " + e.value);
			_view.brush.strengthDegradation = e.value;
		}

		private function onBrushStrengthChanged(e:NumberEvent):void
		{
//			trace("BrushMediator::onBrushStrengthChanged - " + e.value);
			_view.brush.strength = e.value;
		}

		private function onBrushNumlinksChanged(e:IntEvent):void
		{
//			trace("BrushMediator::onBrushNumlinksChanged - " + e.value);
			_view.brush.numLinks = e.value;
		}

		private function onBrushElasticityChanged(e:NumberEvent):void
		{
//			trace("BrushMediator::onBrushElasticityChanged() - " + e.value);
			_view.brush.elasticity = e.value;
		}

		private function onBrushColorChanged(e:ColorEvent):void
		{
//			trace("BrushMediator::onBrushColorChanged() - " + e.color);
			_view.brush.brushColor = e.color;
		}
	}
}