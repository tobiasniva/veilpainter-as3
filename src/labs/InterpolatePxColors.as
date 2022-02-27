package labs
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.geom.Point;

	/**
	 *
	 * @author: Tobi Wan Kenobi
	 */
	[SWF(backgroundColor = "#000000", frameRate = "60", width = "800", height = "600")]
	public class InterpolatePxColors extends Sprite
	{

		public function InterpolatePxColors()
		{
			pxColDependingOnPos();
			
			pxColFromPointWeights();
		}

		private function pxColFromPointWeights():void
		{
			var bmpData:BitmapData = new BitmapData(200, 200, false, 0xffffff);
			var bmp:Bitmap = new Bitmap(bmpData);
			bmp.x = 500;
			bmp.y = 100;
			addChild(bmp);

			//-- Points
			var p0:Point = new Point(0, 0);
			var p1:Point = new Point(200, 0);
			var p2:Point = new Point(0, 200);
			var p3:Point = new Point(200, 200);
			var points:Vector.<Point> = new <Point>[p0, p1, p2, p3];
			
			//-- Colors
			var c0:uint = 0xff0000;
			var c1:uint = 0x00ff00;
			var c2:uint = 0x0000ff;
			var c3:uint = 0xffff00;
			var colors:Vector.<uint> = new <uint>[c0, c1, c2, c3];
			
			var maxDist:Number = Math.sqrt(bmpData.width * bmpData.width + bmpData.height * bmpData.height);

			//-- Set pixel colors dep on position...
			for(var i:int = 0; i < bmpData.width; i++)
			{
				for(var j:int = 0; j < bmpData.height; j++)
				{
					var pos:Point = new Point(i, j);
					
					//-- Distances
					var d0:Number = maxDist - Point.distance(pos, p0);
					var d1:Number = maxDist - Point.distance(pos, p1);
					var d2:Number = maxDist - Point.distance(pos, p2);
					var d3:Number = maxDist - Point.distance(pos, p3);
					
					//-- Weights (sums up to total of 1)
					var tot:Number = d0 + d1 + d2 + d3;
					var w0:Number = d0 / tot;
					var w1:Number = d1 / tot;
					var w2:Number = d2 / tot;
					var w3:Number = d3 / tot;
					var weights:Vector.<Number> = new <Number>[w0, w1, w2, w3];
					
					var colBlended:uint = 0;
					var multiplier:Number = 1; //-- To crank up the colors a bit

					//-- Set colors weighted all...
					for(var c:int = 0; c < colors.length; c++)
					{
						var col:uint = colors[c];
						
						var r:Number = (col >> 16) & 0xFF;
						var g:Number = (col >> 8) & 0xFF;
						var b:Number = col & 0xFF;

						var rCurrent:Number = (colBlended >> 16) & 0xFF;
						var gCurrent:Number = (colBlended >> 8) & 0xFF;
						var bCurrent:Number = colBlended & 0xFF;

						var rBlend:Number = rCurrent + (r * (weights[c] * multiplier));
						var gBlend:Number = gCurrent + (g * (weights[c] * multiplier));
						var bBlend:Number = bCurrent + (b * (weights[c] * multiplier));
						
						if(rBlend > 255) rBlend = 255;
						if(gBlend > 255) gBlend = 255;
						if(bBlend > 255) bBlend = 255;

						colBlended =  ((rBlend << 16) | (gBlend << 8) | bBlend);
					}

					bmpData.setPixel(i, j, colBlended);

					//-- Experimental...
//					var weightLargestTwo:Point = getTwoLargestNumbers(weights);
//					var colIndexPrimary:int = weights.indexOf(weightLargestTwo.x);
//					var colIndexSecondary:int = weights.indexOf(weightLargestTwo.y);
					
					//-- Set colors weighted against two largest
//					var colPrim:uint = colors[colIndexPrimary];
//					var colSec:uint = colors[colIndexSecondary];
//
//					var rPrim:Number = (colPrim >> 16) & 0xFF;
//					var gPrim:Number = (colPrim >> 8) & 0xFF;
//					var bPrim:Number = colPrim & 0xFF;
//
//					var rSec:Number = (colSec >> 16) & 0xFF;
//					var gSec:Number = (colSec >> 8) & 0xFF;
//					var bSec:Number = colSec & 0xFF;
//
//					var rCurrent:Number = (colBlended >> 16) & 0xFF;
//					var gCurrent:Number = (colBlended >> 8) & 0xFF;
//					var bCurrent:Number = colBlended & 0xFF;
//
//					var rBlend:Number = rCurrent + (rPrim * (weights[colIndexPrimary] * multiplier)) + (rSec * (weights[colIndexSecondary] * multiplier));
//					var gBlend:Number = gCurrent + (gPrim * (weights[colIndexPrimary] * multiplier)) + (gSec * (weights[colIndexSecondary] * multiplier));
//					var bBlend:Number = bCurrent + (bPrim * (weights[colIndexPrimary] * multiplier)) + (bSec * (weights[colIndexSecondary] * multiplier));
//
//					if(rBlend > 255) rBlend = 255;
//					if(gBlend > 255) gBlend = 255;
//					if(bBlend > 255) bBlend = 255;
//
//					colBlended =  ((rBlend << 16) | (gBlend << 8) | bBlend);
//					
//					bmpData.setPixel(i, j, colBlended);
				}
			}
		}

		private function getTwoLargestNumbers(numbers:Vector.<Number>):Point
		{
			var newVec:Vector.<Number> = numbers.concat();
			newVec.sort(Array.DESCENDING);
			
			var nums:Point = new Point();
			nums.x = newVec[0];
			nums.y = newVec[1];
			
			return nums;
		}
		
		private function pxColDependingOnPos():void
		{
			var bmpData:BitmapData = new BitmapData(200, 200, false, 0xff0000);
			var bmp:Bitmap = new Bitmap(bmpData);
			bmp.x = 100;
			bmp.y = 100;
			addChild(bmp);
			
			for(var i:int = 0; i < bmpData.width; i++)
			{
				for(var j:int = 0; j < bmpData.height; j++)
				{
					var red:Number 		= (i / bmpData.width) * 255;
					var green:Number 	= (j / bmpData.height) * 255;
					var blue:Number 	= 0;
					
					var col:uint =  ((red << 16) | (green << 8) | blue);

					bmpData.setPixel(i, j, col);
				}
			}
		}
	}
}
