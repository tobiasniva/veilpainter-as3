package view.layout
{
	import com.bit101.components.ColorChooser;
	import com.bit101.components.Style;
	import view.Gui;

	public class PhoneLandscapeLayout implements IGuiLayout
	{
		public function apply(gui:Gui, lm:LayoutMetrics):void
		{
			var PADDING:int     = 50;
			var WIDTH_FULL:int  = lm.screenW - (PADDING * 2);
			var WIDTH_HALF:int  = int((WIDTH_FULL / 2) - (PADDING / 2));
			var WIDTH_THIRD:int = int((WIDTH_FULL / 3) - PADDING);
			var WIDTH_FORTH:int = int((WIDTH_FULL / 4) - PADDING);
			var WIDTH_FIFTH:int = int((WIDTH_FULL / 5) - PADDING);
			var WIDTH_SLD:int   = lm.screenW - WIDTH_HALF - PADDING;
			var X_MID:int       = lm.screenW - PADDING - WIDTH_HALF;
			var X_4TH:int    	= (PADDING * 2) + WIDTH_FORTH;
			var X_2_3RDS:int    = lm.screenW - PADDING - WIDTH_THIRD;
			var X_3_4THS:int    = lm.screenW - PADDING - WIDTH_FORTH;
			var X_4_5THS:int    = lm.screenW - PADDING - WIDTH_FIFTH;
			var Y_BOTTOM:int    = lm.screenH - Style.COMMON_20 - PADDING;

			// Layout
			gui.sldElasticity.x = PADDING;
			gui.sldElasticity.y = 60; 								//100
			gui.sldElasticity.width = WIDTH_SLD;

			gui.sldStrength.x = PADDING;
			gui.sldStrength.y = 180; 								//225
			gui.sldStrength.width = WIDTH_SLD;

			gui.sldStrengthDegradation.x = PADDING;
			gui.sldStrengthDegradation.y = 300; 					//350
			gui.sldStrengthDegradation.width = WIDTH_SLD;
			//--
			gui.lblBlendModes.visible = false;
			gui.cmbBlendMode.x = X_4_5THS - PADDING;
			gui.cmbBlendMode.y = 60;								//500
			gui.cmbBlendMode.width = WIDTH_FIFTH + PADDING;

			gui.lblAlphaImage.visible = false;
			gui.cmbAlphaImage.x = gui.cmbBlendMode.x - WIDTH_FIFTH - (PADDING * 2);
			gui.cmbAlphaImage.y = 60;								//500
			gui.cmbAlphaImage.width = WIDTH_FIFTH + PADDING;

			gui.sldOpacity.x = X_MID + PADDING;
			gui.sldOpacity.y = 180;									//725
			gui.sldOpacity.width = WIDTH_SLD - PADDING;
			//--
			gui.colorPickerBG.x = gui.cmbBlendMode.x;
			gui.colorPickerBG.y = 300;								//1000
			gui.colorPickerBG.popupAlign = ColorChooser.TOP_RIGHT;

			gui.colorPicker.x = gui.cmbAlphaImage.x;
			gui.colorPicker.y = 300;								//1000
			gui.colorPicker.popupAlign = ColorChooser.TOP_LEFT;
			//--
			gui.stpNumLinks.x = PADDING;
			gui.stpNumLinks.y = Y_BOTTOM;								//800
			gui.stpNumLinks.width = WIDTH_FIFTH;
			gui.lblNumLinks.visible = false;

			gui.stpSizeMultiplier.x = (PADDING * 2) + WIDTH_FIFTH;
			gui.stpSizeMultiplier.y = Y_BOTTOM;							//800
			gui.stpSizeMultiplier.width = WIDTH_FIFTH;
			gui.stpSizeMultiplier.enabled = false; //TODO: We disable this on mobile for now!

			gui.chkDebug.x = (PADDING * 3) + (WIDTH_FIFTH * 2);
			gui.chkDebug.y = Y_BOTTOM + 20;					//820
			//--
			gui.btnSaveImage.x = gui.cmbBlendMode.x;
			gui.btnSaveImage.y = Y_BOTTOM;
			gui.btnSaveImage.width = WIDTH_FIFTH + PADDING;

			gui.btnClear.x = gui.cmbAlphaImage.x;
			gui.btnClear.y = Y_BOTTOM;
			gui.btnClear.width = WIDTH_FIFTH + PADDING;
		}
	}
}
