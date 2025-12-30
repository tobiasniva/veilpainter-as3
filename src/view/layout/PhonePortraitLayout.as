package view.layout
{
	import com.bit101.components.ColorChooser;
	import com.bit101.components.Style;
	import view.Gui;
	import ui.StyleSizer;

	public class PhonePortraitLayout implements IGuiLayout
	{
		public function apply(gui:Gui, lm:LayoutMetrics):void
		{
			// StyleSizer.ComponentScale(lm.uiScale); //TODO: Consider moving elsewhere?

			var PADDING:int     = 50;
			var WIDTH_FULL:int  = lm.screenW - (PADDING * 2);
			var WIDTH_SLD:int   = lm.screenW;
			var WIDTH_HALF:int  = int((WIDTH_FULL / 2) - (PADDING / 2));
			var WIDTH_THIRD:int = int((WIDTH_FULL / 3) - PADDING);
			var X_MID:int       = lm.screenW - PADDING - WIDTH_HALF;
			var Y_BOTTOM:int    = lm.screenH - Style.COMMON_20 - PADDING;

			// Layout gui (directly re-using your old coordinates)
			gui.sldElasticity.x = PADDING;
			gui.sldElasticity.y = 100; 								//100
			gui.sldElasticity.width = WIDTH_SLD;

			gui.sldStrength.x = PADDING;
			gui.sldStrength.y = 225; 								//225
			gui.sldStrength.width = WIDTH_SLD;

			gui.sldStrengthDegradation.x = PADDING;
			gui.sldStrengthDegradation.y = 350; 					//350
			gui.sldStrengthDegradation.width = WIDTH_SLD;

			gui.lblAlphaImage.visible = false;
			gui.cmbAlphaImage.x = PADDING;
			gui.cmbAlphaImage.y = 500;								//500
			gui.cmbAlphaImage.width = WIDTH_HALF;

			gui.lblBlendModes.visible = false;
			gui.cmbBlendMode.x = X_MID;
			gui.cmbBlendMode.y = 500;								//500
			gui.cmbBlendMode.width = WIDTH_HALF;

			gui.sldAlpha.x = PADDING;
			gui.sldAlpha.y = 625;									//725
			gui.sldAlpha.width = WIDTH_SLD;

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

			gui.btnClear.x = PADDING;
			gui.btnClear.y = Y_BOTTOM;
			gui.btnClear.width = WIDTH_HALF;

			gui.btnSaveImage.x = X_MID;
			gui.btnSaveImage.y = Y_BOTTOM;
			gui.btnSaveImage.width = WIDTH_HALF;
		}
	}
}
