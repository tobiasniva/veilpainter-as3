package
{
	import behavior.Spring;

	import com.bit101.components.HUISlider;

	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Point;

	import utils.ShapeFactory;

	/**
	 *
	 * @author: Tobi Wan Kenobi
	 */
		[SWF(backgroundColor = "#ffffff", frameRate ="60", width = "800", height = "600")]
	public class SpringTest extends Sprite
	{
		private var _spring:Spring;
		private var _spring2:Spring;
		
		public function SpringTest()
		{
			_spring = new Spring();
			_spring.shape = ShapeFactory.getCircle(6, 0x0000ff);
			addChildAt(_spring, 0);

			_spring2= new Spring();
			_spring2.shape = ShapeFactory.getCircle(8, 0xff0000);
			addChildAt(_spring2, 0);

			//-- GUI/controls...
			var sldElasticity:HUISlider = new HUISlider(this, 10, 10, "Elasticity", onElasticityChanged);
			sldElasticity.setSliderParams(0.0, 1.0, 0.8);
			sldElasticity.labelPrecision = 2;

			var sldStrength:HUISlider = new HUISlider(this, 10, 40, "Strength", onStrengthChanged);
			sldStrength.setSliderParams(0.0, 1.0, 0.1);
			sldStrength.labelPrecision = 2;
			
			//-- Tick
			stage.addEventListener(Event.ENTER_FRAME, update);
		}

		private function update(e:Event):void
		{
			var target:Point = new Point(mouseX, mouseY);
			
			_spring.update(target);
			_spring2.update(target);
		}

		private function onStrengthChanged(e:Event):void
		{
			var sld:HUISlider = e.currentTarget as HUISlider;
			_spring.strength = sld.value;
			_spring2.strength = sld.value * 0.9;
		}

		private function onElasticityChanged(e:Event):void
		{
			var sld:HUISlider = e.currentTarget as HUISlider;
			_spring.elasticity = sld.value;
			_spring2.elasticity = sld.value * 0.9;
		}
	}
}
