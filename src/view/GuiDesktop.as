package view
{
	/**
	 *
	 * @author: Tobi Wan Kenobi
	 * The original desktop UI...
	 */
	public class GuiDesktop extends GuiBase
	{
		public function GuiDesktop(parent:VeilPainter, uiScale:int)
		{
			super(parent, uiScale);
			
			//-- Layout gui
			_sldElasticity.x = 10;
			_sldElasticity.y = 10;
			_sldElasticity.width = 300;
			
			_sldStrength.x = 10;
			_sldStrength.y = 35;
			_sldStrength.width = 300;

			_sldStrengthDegradation.x = 10;
			_sldStrengthDegradation.y = 60;
			_sldStrengthDegradation.width = 300;

			_lblAlphaImage.x = 316;
			_lblAlphaImage.y = 10;
			
			_cmbAlphaImage.x = 369;
			_cmbAlphaImage.y = 10;
			_cmbAlphaImage.width = 96;

			_sldAlpha.x = 469;
			_sldAlpha.y = 10;
			_sldAlpha.width = 130;

			_lblNumLinks.x = 748;
			_lblNumLinks.y = 11;
			
			_stpNumLinks.x = 692;
			_stpNumLinks.y = 12;
			_stpNumLinks.width = 52;

			_chkDebug.x = 733;
			_chkDebug.y = 43;

			_lblBlendModes.x = 316;
			_lblBlendModes.y = 39;
			
			_cmbBlendMode.x = 369;
			_cmbBlendMode.y = 38;
			_cmbBlendMode.width = 96;

			_colorPicker.x = 478;
			_colorPicker.y = 40;

			//-- STUFF @ right...
			_btnClear.x = _screenSize.x - 110;
			_btnClear.y = 10;

			_stpSizeMultiplier.x = _btnClear.x - 62;
			_stpSizeMultiplier.y = 12;
			_stpSizeMultiplier.width = 52;

			_colorPickerBG.x = _stpSizeMultiplier.x - 80;
			_colorPickerBG.y = 12;

			_btnSaveImage.x = _screenSize.x - 110;
			_btnSaveImage.y = _screenSize.y - 30;
		}
	}
}
