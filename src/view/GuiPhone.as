package view
{
	import ui.StyleChanger;

	/**
	 *
	 * @author: Tobi Wan Kenobi
	 * The extended mobile UI, where more stuff are available directly on screen...like desktop...
	 */
	public class GuiPhone extends GuiBase
	{
		public function GuiPhone(parent:VeilPainter)
		{
			StyleChanger.Size_2x();
			
			super(parent);
			
			var PADDING:int = 20;
			var WIDTH:int = _screenSize.x - (PADDING * 2);
			
			//-- Layout gui
			_sldElasticity.x = PADDING;
			_sldElasticity.y = PADDING;
			_sldElasticity.width = WIDTH;

			_sldStrength.x = PADDING;
			_sldStrength.y = 75;
			_sldStrength.width = WIDTH;

			_sldStrengthDegradation.x = PADDING;
			_sldStrengthDegradation.y = 150;
			_sldStrengthDegradation.width = WIDTH;

			_lblAlphaImage.visible = false;
			_cmbAlphaImage.x = PADDING;
			_cmbAlphaImage.y = 300;
			_cmbAlphaImage.width = WIDTH;

			_lblBlendModes.visible = false;
			_cmbBlendMode.x = PADDING;
			_cmbBlendMode.y = 400;
			_cmbBlendMode.width = WIDTH;
			
			_sldAlpha.x = PADDING;
			_sldAlpha.y = 500;
			_sldAlpha.width = WIDTH;

			_colorPicker.x = PADDING;
			_colorPicker.y = 600;
			
			_chkDebug.x = PADDING;
			_chkDebug.y = 700;

			_stpNumLinks.x = PADDING;
			_stpNumLinks.y = 800;
			_stpNumLinks.width = WIDTH;
			_lblNumLinks.visible = false;

			_btnClear.x = PADDING;
			_btnClear.y = 900;

			_stpSizeMultiplier.x = PADDING;
			_stpSizeMultiplier.y = 1000;
			_stpSizeMultiplier.width = WIDTH;

			_colorPickerBG.x = PADDING;
			_colorPickerBG.y = 1100;

			_btnSaveImage.x = PADDING;
			_btnSaveImage.y = 1200;
			_btnSaveImage.enabled = false; //TODO: We disable this on mobile for now!
		}
	}
}
