package labs
{
	import behavior.Chain;

	import com.bit101.components.HUISlider;
	import com.bit101.components.Label;
	import com.bit101.components.NumericStepper;

	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Point;

	import utils.ShapeFactory;

	/**
	 *
	 * @author: Tobi Wan Kenobi
	 */
	[SWF(backgroundColor = "#000000", frameRate ="60", width = "800", height = "600")]
	public class ChainTest extends Sprite
	{
		private var _chain:Chain;
		private var sldElasticity:HUISlider;
		private var sldStrength:HUISlider;
		private var sldStrengthDegradation:HUISlider;
		private var stpNumLinks:NumericStepper;
		
		public function ChainTest()
		{
			//-- GUI/controls...
			sldElasticity = new HUISlider(this, 10, 10, "Elasticity", onElasticityChanged);
			sldElasticity.width = 300;
			sldElasticity.setSliderParams(0.0, 1.0, 0.85);
			sldElasticity.labelPrecision = 2;
			sldElasticity.tick = 0.01

			sldStrength = new HUISlider(this, 10, 35, "Strength", onStrengthChanged);
			sldStrength.width = 300;
			sldStrength.setSliderParams(0.0, 0.1, 0.028);
			sldStrength.labelPrecision = 3;
			sldStrength.tick = 0.001

			sldStrengthDegradation = new HUISlider(this, 300, 35, "Strength degr", onStrengthDegradationChanged);
			sldStrengthDegradation.width = 300;
			sldStrengthDegradation.setSliderParams(0.01, 10, 2.7);
			sldStrengthDegradation.labelPrecision = 2;
			sldStrengthDegradation.tick = 0.01;
			
			var lblNumLinks:Label = new Label(this, 10, 64, "Num links");
			
			stpNumLinks = new NumericStepper(this, 58, 65, onNumLinksChanged);
			stpNumLinks.width = 64;
			stpNumLinks.step = 4;
			stpNumLinks.minimum = 4;
			stpNumLinks.value = 16;
			stpNumLinks.maximum = 64;

			//-- Chain
			_chain = new Chain(stpNumLinks.value);
			_chain.elasticity = sldElasticity.value;
			_chain.strength = sldStrength.value;
			_chain.strengthDegradation = sldStrengthDegradation.value;
//			_chain.fade = true;
			_chain.shape = ShapeFactory.getCircle(2, 0xffff80);
			addChildAt(_chain, 0);
			
			stage.addEventListener(Event.ENTER_FRAME, update);
		}

		private function update(e:Event):void
		{
			var target:Point = new Point(stage.mouseX, stage.mouseY);
			_chain.update(target);
		}
		
		private function onNumLinksChanged(e:Event):void
		{
			_chain.numLinks = stpNumLinks.value;
		}

		private function onElasticityChanged(e:Event = null):void
		{
			_chain.elasticity = sldElasticity.value;
		}
		
		private function onStrengthChanged(e:Event = null):void
		{
			_chain.strength = sldStrength.value;
		}

		private function onStrengthDegradationChanged(e:Event = null):void
		{
			_chain.strengthDegradation = sldStrengthDegradation.value;
		}
	}
}
