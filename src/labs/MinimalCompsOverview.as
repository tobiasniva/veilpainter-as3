package labs
{
	import com.bit101.components.CheckBox;
	import com.bit101.components.ColorChooser;
	import com.bit101.components.ComboBox;
	import com.bit101.components.HSlider;
	import com.bit101.components.HUISlider;
	import com.bit101.components.InputText;
	import com.bit101.components.List;
	import com.bit101.components.NumericStepper;
	import com.bit101.components.PushButton;
	import com.bit101.components.RadioButton;

	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageDisplayState;
	import flash.display.StageScaleMode;
	import flash.events.Event;

	import ui.StyleSizer;

	/**
	 *
	 * @author: Tobi Wan Kenobi
	 */
	[SWF(backgroundColor="#eeeeee", frameRate="60", width="1024", height="1024")]
	public class MinimalCompsOverview extends Sprite
	{
		private static const BGCOL:uint         = 0xdddddd;
		private static const GRIDCOLSUB:uint    = 0xd6d6d6;
		private static const GRIDCOL:uint       = 0xcccccc;
		private static const GRIDSIZESUB:int    = 10;
		private static const GRIDSIZE:int       = 30;
		
		private var _scaler:Number = 1.0;

		private var _cmb:ComboBox;
		private var _btn:PushButton;
		private var _rd0:RadioButton;
		private var _rd1:RadioButton;
		private var _rd2:RadioButton;
		private var _list:List;
		private var _sldH:HSlider;
		private var _sldHUI:HUISlider;
		private var _chk:CheckBox;
		private var _numStep:NumericStepper;
		private var _inputText:InputText;
		private var _colChooser:ColorChooser;
		
		private var _bmpData:BitmapData;
		private var _grid:Bitmap;

		public function MinimalCompsOverview()
		{
			stage.scaleMode 	= StageScaleMode.NO_SCALE;
			stage.align 		= StageAlign.TOP_LEFT;
			stage.displayState 	= StageDisplayState.FULL_SCREEN;
			stage.displayState 	= StageDisplayState.FULL_SCREEN_INTERACTIVE; //ColorChooser needs it!
			
			_bmpData = new BitmapData(stage.fullScreenWidth, stage.fullScreenHeight, false, BGCOL);
			_grid = new Bitmap(_bmpData);
			
			_scaler = 3;
			scaleStyle(_scaler);
			
			drawGUI();
		}

		private function drawGUI():void
		{
			this.removeChildren(0); //just clear all previous
			drawGrid();

			//1ST COL
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
			_list = new List(this, pad, pad + (130 * _scaler), ["Item 0", "Item 1", "Item 2", "Item 3"]);
			
			
			//2ND COL
			var x2:int = pad + (120 * _scaler);
			_sldH = new HSlider(this, x2, pad);
			_sldHUI = new HUISlider(this, x2, pad + (50 * _scaler), "Slider");
			_chk = new CheckBox(this, x2, pad + (100 * _scaler), "Checkbox");
			_chk.selected = true;
			_numStep = new NumericStepper(this, x2, pad + (130 * _scaler));
			_inputText = new InputText(this, x2, pad + (170 * _scaler), "Input");
			_colChooser = new ColorChooser(this, x2, pad + (210 * _scaler), 0xccaa66);
			_colChooser.usePopup = true;
			_colChooser.popupAlign = ColorChooser.TOP_LEFT;
			
		}

		private function selectUiScale(e:Event):void
		{
			_scaler = _cmb.selectedIndex + 1;
			scaleStyle(_scaler);
			drawGUI();
		}

		private function scaleStyle(scale:Number = 1):void
		{
			StyleSizer.ComponentScale(scale);
		}

		private function drawGrid():void
		{
			_bmpData.lock();
			for(var i:int = 0; i < _bmpData.width; i++) {
				for(var j:int = 0; j < _bmpData.height; j++) {
					if(i % GRIDSIZESUB == 0 || j % GRIDSIZESUB == 0) {
						if(i % GRIDSIZE == 0 || j % GRIDSIZE == 0)  {
							_bmpData.setPixel(i, j, GRIDCOL);
						} else {
							_bmpData.setPixel(i, j, GRIDCOLSUB);
						}
					}
				}
			}
			_bmpData.unlock();
			addChildAt(_grid, 0);
		}
	}
}
