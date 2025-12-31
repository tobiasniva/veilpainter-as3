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
			// var WIDTH_SLD:int   = lm.screenW;
			var WIDTH_HALF:int  = int((WIDTH_FULL / 2) - (PADDING / 2));
			var WIDTH_THIRD:int = int((WIDTH_FULL / 3) - PADDING);
			var WIDTH_FORTH:int = int((WIDTH_FULL / 4) - PADDING);
			var WIDTH_FIFTH:int = int((WIDTH_FULL / 5) - PADDING);
			var WIDTH_SLD:int   = lm.screenW - WIDTH_HALF;
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
			gui.cmbBlendMode.x = X_4_5THS;
			gui.cmbBlendMode.y = 60;								//500
			gui.cmbBlendMode.width = WIDTH_FIFTH;

			gui.lblAlphaImage.visible = false;
			gui.cmbAlphaImage.x = gui.cmbBlendMode.x - WIDTH_FIFTH - PADDING;
			gui.cmbAlphaImage.y = 60;								//500
			gui.cmbAlphaImage.width = WIDTH_FIFTH;

			gui.sldAlpha.x = X_MID + (PADDING * 2);
			gui.sldAlpha.y = 180;									//725
			gui.sldAlpha.width = WIDTH_SLD - (PADDING * 2);
			//--

			gui.stpNumLinks.x = PADDING;
			gui.stpNumLinks.y = 800;								//800
			gui.stpNumLinks.width = WIDTH_THIRD;
			gui.lblNumLinks.visible = false;

			gui.stpSizeMultiplier.x = (PADDING * 2) + WIDTH_THIRD;
			gui.stpSizeMultiplier.y = 800;							//800
			gui.stpSizeMultiplier.width = WIDTH_THIRD;
			gui.stpSizeMultiplier.enabled = false; //TODO: We disable this on mobile for now!

			gui.chkDebug.x = (PADDING * 3) + (WIDTH_THIRD * 2);
			gui.chkDebug.y = 820;									//820

			gui.colorPicker.x = PADDING;
			gui.colorPicker.y = 1000;								//1000
			gui.colorPicker.popupAlign = ColorChooser.TOP_LEFT;

			gui.colorPickerBG.x = X_MID;
			gui.colorPickerBG.y = 1000;								//1000
			gui.colorPickerBG.popupAlign = ColorChooser.TOP_RIGHT;

			gui.btnSaveImage.x = X_3_4THS;
			gui.btnSaveImage.y = Y_BOTTOM;
			gui.btnSaveImage.width = WIDTH_FORTH;

			gui.btnClear.x = gui.btnSaveImage.x - WIDTH_FORTH - PADDING;
			gui.btnClear.y = Y_BOTTOM;
			gui.btnClear.width = WIDTH_FORTH;
		}
	}
}
