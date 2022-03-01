package view
{
	import behavior.Brush;

	import com.bit101.components.CheckBox;

	import com.bit101.components.ColorChooser;

	import com.bit101.components.ComboBox;

	import com.bit101.components.HUISlider;
	import com.bit101.components.NumericStepper;

	import flash.display.Bitmap;

	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Point;

	import utils.LoadAlphaImages;

	/**
	 *
	 * @author: Tobi Wan Kenobi
	 * Figure out what we actually want gui to support. Interface?
	 * Difference between tablet/phone gui? (for sure...)
	 */
	public class GuiBase extends Sprite
	{
		//-- refs in parent class...
		private var _parent:VeilPainter;
		private var _brush:Brush;

		protected var _screenSize:Point;
		protected var _loadAlphaImages:LoadAlphaImages;
		protected var _sldElasticity:HUISlider;
		protected var _sldStrength:HUISlider;
		protected var _sldStrengthDegradation:HUISlider;
		protected var _sldAlpha:HUISlider;
		protected var _stpNumLinks:NumericStepper;
		protected var _cmbAlphaImage:ComboBox;
		protected var _cmbBlendMode:ComboBox;
		protected var _colorPicker:ColorChooser;
		protected var _colorPickerBG:ColorChooser;
		protected var _stpSizeMultiplier:NumericStepper;
		protected var _chkDebug:CheckBox;

		
		public function GuiBase(parent:VeilPainter)
		{
			this.mouseEnabled = false; //TODO: Good to not pick up mouse...but safe for everything within this?

			//TODO: Remove these ugly refs...solve with some event system...?
			_parent = parent;
			_screenSize = parent.screenSize;
			_brush = parent.brush;
			_loadAlphaImages = parent.loadAlphaImages;
		}
		
		public function show()
		{
			this.visible = true;
		}

		public function hide()
		{
			this.visible = false;
		}

		protected function onSaveImageToDesktop(e:Event):void
		{
			_parent.saveImageToDesktop();
		}

		protected function onResetCanvas(e:Event):void
		{
			_parent.resetCanvas(_stpSizeMultiplier.value, _colorPickerBG.value);
		}

		protected function onNumLinksChanged(e:Event):void
		{
			_brush.numLinks = _stpNumLinks.value;
		}

		protected function onElasticityChanged(e:Event):void
		{
			_brush.elasticity = _sldElasticity.value;
		}

		protected function onStrengthChanged(e:Event):void
		{
			_brush.strength = _sldStrength.value;
		}

		protected function onStrengthDegradationChanged(e:Event):void
		{
			_brush.strengthDegradation = _sldStrengthDegradation.value;
		}

		protected function onColorChanged(e:Event):void
		{
			_brush.brushColor = _colorPicker.value;
		}

		protected function onAlphaChanged(e:Event):void
		{
			_brush.brushAlpha = _sldAlpha.value;
		}

		protected function onBlendModeChanged(e:Event):void
		{
			_brush.brushBlendmode = String(_cmbBlendMode.selectedItem);
		}

		protected function onAlphaImageChanged(e:Event):void
		{
			var index:int = _cmbAlphaImage.selectedIndex;
			var img:Bitmap = _loadAlphaImages.images[index].bitmap;
			_brush.alphaImage = img;
		}

		protected function onDebugChanged(e:Event):void
		{
			_brush.debug = _chkDebug.selected;
		}
	}
}
