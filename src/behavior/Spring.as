package behavior
{
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.geom.Point;

	/**
	 *
	 * @author: Tobi Wan Kenobi
	 */
	public class Spring extends Sprite
	{
		private var _vx:Number = 0;
		private var _vy:Number = 0;
		private var _px:Number = 0;
		private var _py:Number = 0;

		private var _shape:Shape;
		
		private var _elasticity:Number;
		private var _strength:Number;

		public function Spring(elasticity:Number = 0.8, strength:Number = 0.1)
		{
			this.mouseEnabled = this.mouseChildren = false;
			
			_elasticity = elasticity;
			_strength = strength;
		}

		public function update(target:Point):void
		{
			_vx = target.x - this.x;
			_vy = target.y - this.y;
			_px = _px * _elasticity + _vx * _strength;
			_py = _py * _elasticity + _vy * _strength;
			this.x += _px;
			this.y += _py;
		}

		public function set elasticity(value:Number):void
		{
			_elasticity = value;
		}

		public function set strength(value:Number):void
		{
			_strength = value;
		}

		public function set shape(shp:Shape):void
		{
			_shape = shp;
			
			while(this.numChildren > 0)
				removeChildAt(0);
			
			addChild(_shape);
		}
	}
}