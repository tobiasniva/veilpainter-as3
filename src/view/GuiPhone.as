package view
{
	import com.bit101.components.ColorChooser;
	import com.bit101.components.Style;

	import ui.StyleSizer;

	/**
	 *
	 * @author: Tobi Wan Kenobi
	 * The extended mobile UI, where more stuff are available directly on screen...like desktop...
	 */
	public class GuiPhone extends GuiBase
	{
		public function GuiPhone(parent:VeilPainter)
		{
			super(parent);
			
			var PADDING:int     = 50;
			var WIDTH_FULL:int  = _screenSize.x - (PADDING * 2);
			var WIDTH_SLD:int   = _screenSize.x;
			var WIDTH_HALF:int  = (WIDTH_FULL / 2) - (PADDING / 2);
			var WIDTH_THIRD:int = (WIDTH_FULL / 3) - PADDING;
			var X_MID:int       = _screenSize.x - PADDING - WIDTH_HALF;
			var Y_BOTTOM:int    = _screenSize.y - Style.COMMON_20 - PADDING;
			
			//-- Layout gui
			_sldElasticity.x = PADDING;
			_sldElasticity.y = 100;
			_sldElasticity.width = WIDTH_SLD;

			_sldStrength.x = PADDING;
			_sldStrength.y = 225;
			_sldStrength.width = WIDTH_SLD;

			_sldStrengthDegradation.x = PADDING;
			_sldStrengthDegradation.y = 350;
			_sldStrengthDegradation.width = WIDTH_SLD;

			_lblAlphaImage.visible = false;
			_cmbAlphaImage.x = PADDING;
			_cmbAlphaImage.y = 500;
			_cmbAlphaImage.width = WIDTH_HALF;

			_lblBlendModes.visible = false;
			_cmbBlendMode.width = WIDTH_HALF;
			_cmbBlendMode.x = X_MID;
			_cmbBlendMode.y = 500;
			
			_sldAlpha.x = PADDING;
			_sldAlpha.y = 625;
			_sldAlpha.width = WIDTH_SLD;
			
			_stpNumLinks.x = PADDING;
			_stpNumLinks.y = 800;
			_stpNumLinks.width = WIDTH_THIRD;
			_lblNumLinks.visible = false;

			_stpSizeMultiplier.x = (PADDING * 2) + WIDTH_THIRD;
			_stpSizeMultiplier.y = 800;
			_stpSizeMultiplier.width = WIDTH_THIRD;
			_stpSizeMultiplier.enabled = false; //TODO: We disable this on mobile for now!
			
			_chkDebug.x = (PADDING * 3) + (WIDTH_THIRD * 2);
			_chkDebug.y = 820;

			_colorPicker.x = PADDING;
			_colorPicker.y = 1000;
			_colorPicker.popupAlign = ColorChooser.TOP_LEFT;

			_colorPickerBG.x = X_MID;
			_colorPickerBG.y = 1000;
			_colorPickerBG.popupAlign = ColorChooser.TOP_RIGHT;

			_btnClear.x = PADDING;
			_btnClear.y = Y_BOTTOM;
			_btnClear.width = WIDTH_HALF;

			_btnSaveImage.x = X_MID;
			_btnSaveImage.y = Y_BOTTOM;
			_btnSaveImage.width = WIDTH_HALF;
//			_btnSaveImage.enabled = false;
		}
	}
}
