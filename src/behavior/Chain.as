package behavior
{
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.geom.Point;

	/**
	 *
	 * @author: Tobi Wan Kenobi
	 */
	public class Chain extends Sprite
	{
		private var _links:Vector.<Spring>;
		private var _shape:Shape;
		private var _numLinks:int;
		private var _elasticity:Number;
		private var _strength:Number;
		private var _strengthDegradation:Number;
		private var _fade:Boolean;
		private var _previousLinkPositions:Vector.<Point>;
		private var _currentLinkPositions:Vector.<Point>;
		
		private var _isInitialized:Boolean;

		public function Chain(numLinks:int = 10, elasticity:Number = 0.85, strength:Number = 0.028, strengthDegr:Number = 0.27, fade:Boolean = false)
		{
			this.mouseChildren = this.mouseEnabled = false;
			
			_isInitialized = false;
			
			_numLinks = numLinks;
			_elasticity = elasticity;
			_strength = strength;
			_strengthDegradation = strengthDegr;
			_fade = fade;
		}

		public function init():void
		{
			clear();
			
			_links = new <Spring>[];
			_previousLinkPositions = new Vector.<Point>(_numLinks, true);
			_currentLinkPositions = new Vector.<Point>(_numLinks, true);
			
			//-- Init links
			for(var i:int = 0; i < _numLinks; i++)
			{
				var link:Spring = new Spring();
				var shp:Shape = new Shape();
				
				if(_fade)
					shp.alpha = 1 - ((1 / _numLinks) * i);
				
				shp.graphics.copyFrom(_shape.graphics);
				link.shape = shp;
				
				addChildAt(link, 0);
				_links.push(link);
			}
			
			_isInitialized = true;
			
			updateLinks();
		}

		public function update(target:Point):void
		{
			if(_isInitialized)
			{
				for(var i:int = 0; i < _numLinks; i++)
				{
					_links[i].update(target);
					
					_previousLinkPositions[i] = _currentLinkPositions[i];
					_currentLinkPositions[i] = new Point(_links[i].x, _links[i].y);
				}
			}
		}

		private function updateLinks():void
		{
			if(_isInitialized)
			{
				var degrPerLink:Number = _strengthDegradation / _numLinks;
				
				for(var i:int = 0; i < _numLinks; i++)
				{
					var s:Spring = _links[i];
					s.elasticity = _elasticity;
					
					var degrValue:Number = _strength / ((i+1) * degrPerLink);
					s.strength = degrValue;
				}
			}
		}

		private function clear():void
		{
			for each(var s:Spring in _links)
			{
				removeChild(s);
			}
		}

		/*
			GETTERS / SETTERS
		 */

		public function get numLinks():int
		{
			return _numLinks
		}
		
		public function set numLinks(value:int):void
		{
			_numLinks = value;
			init();
		}

		public function set shape(shp:Shape):void
		{
			_shape = shp;
			init();
		}

		public function set elasticity(value:Number):void
		{
			_elasticity = value;
			updateLinks();
		}

		public function set strength(value:Number):void
		{
			_strength = value;
			updateLinks();
		}

		public function set strengthDegradation(value:Number):void
		{
			_strengthDegradation = value;
			updateLinks();
		}

		public function set fade(value:Boolean):void
		{
			_fade = value;
			updateLinks();
		}

		public function get previousLinkPositions():Vector.<Point>
		{
			return _previousLinkPositions;
		}

		public function get currentLinkPositions():Vector.<Point>
		{
			return _currentLinkPositions;
		}
	}
}
