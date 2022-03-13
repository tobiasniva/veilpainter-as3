package view
{
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
	public class GuiMediator extends Mediator
	{
		[Inject] public var _view:GuiBaseView;
		[Inject] public var _brushModel:BrushModel;
		[Inject] public var _canvasModel:CanvasModel;

		override public function onRegister():void
		{
			addViewListener(ColorEvent.CANVAS_COLOR_CHANGED, onCanvasColorChanged);
			addViewListener(ColorEvent.BRUSH_COLOR_CHANGED, onBrushColorChanged);
			addViewListener(NumberEvent.BRUSH_ELASTICITY_CHANGED, onBrushElasticityChanged);
			addViewListener(IntEvent.BRUSH_NUMLINKS_CHANGED, onBrushNumlinksChanged);
			addViewListener(NumberEvent.BRUSH_STRENGTH_CHANGED, onBrushStrengthChanged);
			addViewListener(NumberEvent.BRUSH_DEGRADATION_CHANGED, onBrushDegradationChanged);
			addViewListener(NumberEvent.BRUSH_ALPHA_CHANGED, onBrushAlphaChanged);
			addViewListener(StringEvent.BRUSH_BLENDMODE_CHANGED, onBrushBlendmodeChanged);
			addViewListener(IntEvent.BRUSH_ALPHA_IMG_CHANGED, onAlphaImgChanged);
			
			_view.Init(_brushModel, _canvasModel);
		}

		private function onAlphaImgChanged(e:IntEvent):void
		{
			_brushModel.alphaImageSelectedIndex = e.value;
			dispatch(new IntEvent(IntEvent.BRUSH_ALPHA_IMG_CHANGED, e.value));
		}

		private function onBrushBlendmodeChanged(e:StringEvent):void
		{
			_brushModel.blendmode = e.value;
			dispatch(new StringEvent(StringEvent.BRUSH_BLENDMODE_CHANGED, e.value));
		}

		private function onBrushAlphaChanged(e:NumberEvent):void
		{
			_brushModel.alpha = e.value;
			dispatch(new NumberEvent(NumberEvent.BRUSH_ALPHA_CHANGED, e.value));
		}

		private function onBrushDegradationChanged(e:NumberEvent):void
		{
			_brushModel.degradation = e.value;
			dispatch(new NumberEvent(NumberEvent.BRUSH_DEGRADATION_CHANGED, e.value));
		}

		private function onBrushStrengthChanged(e:NumberEvent):void
		{
			_brushModel.strength = e.value;
			dispatch(new NumberEvent(NumberEvent.BRUSH_STRENGTH_CHANGED, e.value));
		}

		private function onBrushNumlinksChanged(e:IntEvent):void
		{
			_brushModel.numLinks = e.value;
			dispatch(new IntEvent(IntEvent.BRUSH_NUMLINKS_CHANGED, e.value));
		}

		private function onBrushElasticityChanged(e:NumberEvent):void
		{
			_brushModel.elasticity = e.value;
			dispatch(new NumberEvent(NumberEvent.BRUSH_ELASTICITY_CHANGED, e.value));
		}

		private function onBrushColorChanged(e:ColorEvent):void
		{
			_brushModel.color = e.color;
			dispatch(new ColorEvent(ColorEvent.BRUSH_COLOR_CHANGED, e.color))
			
		}

		private function onCanvasColorChanged(e:ColorEvent):void
		{
			_canvasModel.color = e.color;
			dispatch(new ColorEvent(ColorEvent.CANVAS_COLOR_CHANGED, e.color));
		}
	}
}