package labs
{
	import com.bit101.components.ComboBox;
	import com.bit101.components.PushButton;
	import com.bit101.components.RadioButton;

	import flash.display.Sprite;
	import flash.events.Event;

	import ui.StyleChanger;

	/**
	 *
	 * @author: Tobi Wan Kenobi
	 */
	[SWF(backgroundColor="#eeeeee", frameRate="60", width="2048", height="1024")]
	public class MinimalCompsOverview extends Sprite
	{
		private var _scaler:Number = 1.0;

		private var _cmb:ComboBox;
		private var _btn:PushButton;
		private var _rd0:RadioButton;
		private var _rd1:RadioButton;
		private var _rd2:RadioButton;

		public function MinimalCompsOverview()
		{
			drawGUI();
		}

		private function drawGUI():void
		{
			this.removeChildren(0); //just clear all previous

			var pad:int = 10 * _scaler;

			_cmb = new ComboBox(this, pad, pad, "Combo", ["Scale x1", "Scale x2", "Scale x3", "Scale x4"]);
			_cmb.numVisibleItems = 4;
			_cmb.selectedIndex = _scaler - 1;
			_cmb.addEventListener(Event.SELECT, selectUiScale);

			_btn = new PushButton(this, pad, pad + (30 * _scaler), "Button");

			var rdY:int = pad + (60 * _scaler);
			_rd0 = new RadioButton(this, pad, rdY, "Radio 0", true, null, "radioGroup");
			_rd1 = new RadioButton(this, pad, rdY + (20 * _scaler), "Radio 1", false, null, "radioGroup");
			_rd2 = new RadioButton(this, pad, rdY + (40 * _scaler), "Radio 2", false, null, "radioGroup");

			
		}

		private function selectUiScale(e:Event):void
		{
			_scaler = _cmb.selectedIndex + 1;
			scaleStyle(_scaler);
			drawGUI();
		}

		private function scaleStyle(scale:Number = 1):void
		{
			switch(scale)
			{
				case 1:
					StyleChanger.Size_1x();
					break;

				case 2:
					StyleChanger.Size_2x();
					break;

				case 3:
					StyleChanger.Size_3x();
					break;

				case 4:
					StyleChanger.Size_4x();
					break;

				default:
					StyleChanger.Size_1x();
			}
		}
	}
}
