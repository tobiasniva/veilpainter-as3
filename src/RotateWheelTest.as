package
{
	import com.bit101.components.Label;
	import com.bit101.components.PushButton;

	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.geom.Point;

	import utils.ShapeFactory;

	/**
	 *
	 * @author: Tobi Wan Kenobi
	 */
	[SWF(backgroundColor="#ffffff", frameRate="30", width="800", height = "600")]
	public class RotateWheelTest extends Sprite
	{
		private var _lblRotation:Label;
		
		private var _debugCanvas:Shape;
		private var _wheel:Shape;
		private var _isMouseDown:Boolean = false;
		
		private var _pickUpRad:Number;
		
		public function RotateWheelTest()
		{
			_wheel = ShapeFactory.getHairCross(64, 0x999999);
			_wheel.x = 400;
			_wheel.y = 300;
			addChild(_wheel);

			_debugCanvas = new Shape();
			addChild(_debugCanvas);

			stage.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
			stage.addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
			stage.addEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
			
			var btnResetRotation:PushButton = new PushButton(this, 10, 10, "Reset rot", onResetRotation);
			_lblRotation = new Label(this, 10, 30, "");
		}

		private function onResetRotation(e:MouseEvent):void
		{
			_wheel.rotation = 0;
			_lblRotation.text = String(_wheel.rotation);
		}

		private function onMouseMove(e:MouseEvent):void
		{
			if(_isMouseDown)
			{
				var pStart:Point = new Point(_wheel.x, _wheel.y);
				var pEnd:Point = new Point(mouseX, mouseY);

				//-- Debug pick up line...
				_debugCanvas.graphics.clear();
				_debugCanvas.graphics.lineStyle(1, 0x0000ff);
				_debugCanvas.graphics.moveTo(pStart.x, pStart.y);
				_debugCanvas.graphics.lineTo(pEnd.x, pEnd.y);

				var currentRad:Number = getAngleBetweenPoints(pStart, pEnd);
				var currentAngle:Number = radToDeg(currentRad - _pickUpRad);
				
				_wheel.rotation = currentAngle;

				_lblRotation.text = String(int(_wheel.rotation));
			}
		}

		private function onMouseUp(e:MouseEvent):void
		{
			_isMouseDown = false;
			_debugCanvas.graphics.clear();
		}

		private function onMouseDown(e:MouseEvent):void
		{
			_isMouseDown = true;

			var pStart:Point = new Point(_wheel.x, _wheel.y);
			var pEnd:Point = new Point(mouseX, mouseY);
			_pickUpRad = getAngleBetweenPoints(pStart, pEnd) - degToRad(_wheel.rotation);
		}

		private function radToDeg(radians:Number):Number
		{
			return radians * (180 / Math.PI);
		}

		private function degToRad(degrees:Number):Number
		{
			return degrees * (Math.PI / 180);
		}
		
		private function getAngleBetweenPoints(p1:Point, p2:Point):Number
		{
			var dx:Number = p2.x - p1.x;
			var dy:Number = p2.y - p1.y;
			var angle:Number = Math.atan2(dy, dx);

			return angle;
		}

		private function getDiffBetweenAngles(angle1:Number, angle2:Number):Number
		{
			var difference:Number = angle2 - angle1;
			while (difference < -180) difference += 360;
			while (difference > 180) difference -= 360;

			return difference;
		}
	}
}
