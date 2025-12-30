package view.layout
{
	import com.bit101.components.ColorChooser;
	import com.bit101.components.Style;
	import view.Gui;

	public class PhonePortraitLayout implements IGuiLayout
	{
		public function apply(gui:Gui, lm:LayoutMetrics):void
		{
			// Keep these values in *logical units*.
			var PADDING:int     = 12;
			var WIDTH_FULL:int  = lm.logicalW - (PADDING * 2);
			var WIDTH_SLD:int   = lm.logicalW;
			var WIDTH_HALF:int  = int((WIDTH_FULL / 2) - (PADDING / 2));
			var WIDTH_THIRD:int = int((WIDTH_FULL / 3) - PADDING);
			var X_MID:int       = lm.logicalW - PADDING - WIDTH_HALF;
			var Y_BOTTOM:int    = lm.logicalH - Style.COMMON_20 - PADDING;

			// Layout gui (directly re-using your old coordinates)
			gui.sldElasticity.x = PADDING;
			gui.sldElasticity.y = 30; 								//100
			gui.sldElasticity.width = WIDTH_SLD;

			gui.sldStrength.x = PADDING;
			gui.sldStrength.y = 70; 								//225
			gui.sldStrength.width = WIDTH_SLD;

			gui.sldStrengthDegradation.x = PADDING;
			gui.sldStrengthDegradation.y = 105; 					//350
			gui.sldStrengthDegradation.width = WIDTH_SLD;

			gui.lblAlphaImage.x = PADDING;
			gui.lblAlphaImage.y = 143;								//475

			gui.cmbAlphaImage.x = PADDING;
			gui.cmbAlphaImage.y = 150;								//500
			gui.cmbAlphaImage.width = WIDTH_FULL;

			gui.lblBlendModes.x = PADDING;
			gui.lblBlendModes.y = 173;								//575

			gui.cmbBlendMode.x = PADDING;
			gui.cmbBlendMode.y = 180;								//600
			gui.cmbBlendMode.width = WIDTH_FULL;

			gui.sldAlpha.x = PADDING;
			gui.sldAlpha.y = 218;									//725
			gui.sldAlpha.width = WIDTH_SLD;

			gui.stpNumLinks.x = PADDING;
			gui.stpNumLinks.y = 270;								//900
			gui.stpNumLinks.width = WIDTH_THIRD;
			gui.lblNumLinks.visible = false;

			gui.stpSizeMultiplier.x = (PADDING * 2) + WIDTH_THIRD;
			gui.stpSizeMultiplier.y = 270;							//900
			gui.stpSizeMultiplier.width = WIDTH_THIRD;
			gui.stpSizeMultiplier.enabled = false;

			gui.chkDebug.x = (PADDING * 3) + (WIDTH_THIRD * 2);
			gui.chkDebug.y = 276;									//920

			gui.colorPicker.x = PADDING;
			gui.colorPicker.y = 330;								//1100
			gui.colorPicker.popupAlign = ColorChooser.TOP_LEFT;

			gui.colorPickerBG.x = X_MID;
			gui.colorPickerBG.y = 330;								//1100
			gui.colorPickerBG.popupAlign = ColorChooser.TOP_RIGHT;

			gui.btnClear.x = PADDING;
			gui.btnClear.y = Y_BOTTOM;
			gui.btnClear.width = WIDTH_HALF;

			gui.btnSaveImage.x = X_MID;
			gui.btnSaveImage.y = Y_BOTTOM;
			gui.btnSaveImage.width = WIDTH_HALF;
		}
	}
}
