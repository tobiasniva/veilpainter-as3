package ui
{
	import com.bit101.components.Style;

	public class StyleChanger
	{
		//TODO: Figure out a DPI-convention instead...?
		
		public static function Size_Double() 
		{
			with(Style)
			{
				fontSize                = 16;
				BUTTON_W                = 200;
				BUTTON_H                = 40;
				CHECKBOX_BG             = 20;
				CHECKBOX_RIM            = 4;
				CHECKBOX_FACE           = 12;
				CHECKBOX_LABEL_X        = 24;
				CHECKBOX_LABEL_H        = 20;
				COLOR_CHOOSER_W         = 130;
				COLOR_CHOOSER_H         = 30;
				COLOR_CHOOSER_INPUT_W   = 90;
				COLOR_CHOOSER_SWATCH_X  = 100;
				COLOR_CHOOSER_BOX       = 36;
				COMBOBOX_W              = 200;
				COMBOBOX_H              = 40;
				HUI_SLIDER_W            = 400;
				HUI_SLIDER_H            = 36;
				HUI_SLIDER_LABEL_PAD    = 10;
				HUI_SLIDER_LABEL_W_FIX  = 120;
				SLIDER_W_OR_H           = 200;
				SLIDER_THICKNESS        = 20;
				INPUTTEXT_W             = 200;
				INPUTTEXT_H             = 32;
				LABEL_H                 = 36;
				LIST_SIZE               = 200;
				LIST_ITEM_H             = 40;
				LISTITEM_W              = 200;
				LISTITEM_H              = 40;
				LISTITEM_LABEL_X        = 10;
				NUMERIC_STEPPER_W       = 160;
				NUMERIC_STEPPER_H       = 36;
				PANEL_SIZE              = 200;
				PANEL_GRID              = 20;
				TEXT_W                  = 400;
				TEXT_H                  = 200;
				TEXT_FIELD_MARGIN       = 4;
			}
		}
	}
}
