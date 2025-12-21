package view
{
	import ui.StyleSizer;

	/**
	 *
	 * @author: Tobi Wan Kenobi
	 * The extended mobile UI, where more stuff are available directly on screen...like desktop...
	 */
	public class GuiTablet extends GuiBase
	{
		public function GuiTablet(parent:VeilPainter, uiScale:int)
		{
			super(parent, uiScale);
			
			var sldx:int = 20;
			var sldw:int = 520;
			
			//-- Layout gui
			_sldElasticity.x = sldx;
			_sldElasticity.y = 10;
			_sldElasticity.width = sldw;

			_sldStrength.x = sldx;
			_sldStrength.y = 55;
			_sldStrength.width = sldw;

			_sldStrengthDegradation.x = sldx;
			_sldStrengthDegradation.y = 100;
			_sldStrengthDegradation.width = sldw;

			var lblx:int = 540;
			var cmbx:int = 645;
			var cmbw:int = 160;
			_lblAlphaImage.x = lblx;
			_lblAlphaImage.y = 10;

			_cmbAlphaImage.x = cmbx;
			_cmbAlphaImage.y = 10;
			_cmbAlphaImage.width = cmbw;
			
			_lblBlendModes.x = lblx;
			_lblBlendModes.y = 70;

			_cmbBlendMode.x = cmbx;
			_cmbBlendMode.y = 69;
			_cmbBlendMode.width = cmbw;
			
			_sldAlpha.x = 816;
			_sldAlpha.y = 11;
			_sldAlpha.width = 258;

			_colorPicker.x = 830;
			_colorPicker.y = 74;
			
			_chkDebug.x = 1308;
			_chkDebug.y = 75;

			_stpNumLinks.x = 1225;
			_stpNumLinks.y = 12;
			_stpNumLinks.width = 110;
			_lblNumLinks.x = 1345;
			_lblNumLinks.y = 11;

			//-- STUFF @ right...
			_btnClear.x = _screenSize.x - 220;
			_btnClear.y = 10;

			_stpSizeMultiplier.x = _btnClear.x - 140;
			_stpSizeMultiplier.y = 12;
			_stpSizeMultiplier.width = 110;

			_colorPickerBG.x = _stpSizeMultiplier.x - 165;
			_colorPickerBG.y = 12;

			_btnSaveImage.x = _screenSize.x - 220;
			_btnSaveImage.y = _screenSize.y - 70;
			_btnSaveImage.enabled = false; //TODO: We disable this on mobile for now!
		}
	}
}
