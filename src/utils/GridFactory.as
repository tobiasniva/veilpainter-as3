package utils
{
	import flash.display.Graphics;
	import flash.display.Shape;
	import flash.geom.Point;

	/**
	 *
	 * @author: Tobi Wan Kenobi
	 */
	public class GridFactory
	{
		public static function getGrid(stageW:int, stageH:int, origin:Point, gridSize:int, colGrid:uint, colAxis:uint):Shape
		{
			var shp:Shape = new Shape();
			var gr:Graphics = shp.graphics;

			//-- same calcs before we draw grid lines
			var offsetX:int = origin.x % gridSize;
			var offsetY:int = origin.y % gridSize;
			var numVert:int = Math.floor(stageW / gridSize);
			var numHor:int  = Math.floor(stageH / gridSize);

			//-- Set colorDefault for grid lines
			gr.lineStyle(0, colGrid);

			//-- vertical lines
			for(var i:int = 0; i < numVert; i++)
			{
				var x:int = offsetX + (i * gridSize);

				//-- We bail out if duck to edge...
				if(x != 0)
				{
					gr.moveTo(x, 0);
					gr.lineTo(x, stageH);
				}
			}

			//-- horizontal lines
			for(var j:int = 0; j < numHor; j++)
			{
				var y:int = offsetY + (j * gridSize);

				//-- We bail out if duck to edge...
				if(y != 0)
				{
					gr.moveTo(0, y);
					gr.lineTo(stageW, y);
				}
			}


			//-- Set colorDefault for axis lines
			gr.lineStyle(0, colAxis);

			//-- X-axis
			gr.moveTo(0, origin.y);
			gr.lineTo(stageW, origin.y);

			//-- Y-axis
			gr.moveTo(origin.x, 0);
			gr.lineTo(origin.x, stageH);

			return shp;
		}
	}
}
