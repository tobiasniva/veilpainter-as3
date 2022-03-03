package ui
{
	import com.bit101.components.Style;

	public class StyleSizer
	{

		public static function Size(factor:Number = 1.0)
		{
			with(Style)
			{
				fontSize                = factor *      8;
				
				BUTTON_W                = factor *      100;
				BUTTON_H                = factor *      20;
				
				CHECKBOX_BG             = factor *      10;
				CHECKBOX_RIM            = factor *      2;
				CHECKBOX_FACE           = factor *      6;
				CHECKBOX_LABEL_X        = factor *      13;
				CHECKBOX_LABEL_H        = factor *      11;
				
				SHADOW_2        = factor *      2;
				SHADOW_1        = factor *      1;
				
				COLOR_CHOOSER_W         = factor *      65;
				COLOR_CHOOSER_H         = factor *      15;
				COLOR_CHOOSER_INPUT_W   = factor *      45;
				COLOR_CHOOSER_SWATCH_X  = factor *      50;
				COLOR_CHOOSER_BOX       = factor *      16;
				
				COMBOBOX_W              = factor *      100;
				COMBOBOX_H              = factor *      20;
				
				HUI_SLIDER_W            = factor *      200;
				HUI_SLIDER_H            = factor *      20;
				HUI_SLIDER_LABEL_PAD    = factor *      5;
				HUI_SLIDER_LABEL_W_FIX  = factor *      60;
				HUI_SLIDER_LABEL_Y_FIX  = factor *      2;
				
				SLIDER_W_OR_H           = factor *      100;
				SLIDER_THICKNESS        = factor *      20;
				
				INPUTTEXT_W             = factor *      100;
				INPUTTEXT_H             = factor *      20;
				
				LABEL_H                 = factor *      17;     //18
				
				LIST_SIZE               = factor *      100;
				LIST_ITEM_H             = factor *      20;
				LISTITEM_W              = factor *      100;
				LISTITEM_H              = factor *      20;
				LISTITEM_LABEL_X        = factor *      5;
				
				NUMERIC_STEPPER_W       = factor *      80;
				NUMERIC_STEPPER_H       = factor *      20;
				
				PANEL_SIZE              = factor *      100;
				PANEL_GRID              = factor *      10;
				
				TEXT_W                  = factor *      200;
				TEXT_H                  = factor *      100;
				TEXT_FIELD_MARGIN       = factor *      2;
			}
		}
	}
}
