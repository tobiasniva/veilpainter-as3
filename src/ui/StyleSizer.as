package ui
{
	import com.bit101.components.Style;

	public class StyleSizer
	{

		public static function Size(factor:Number = 1.0):void
		{
			with(Style)
			{
				fontSize                = factor *      8;
				
				COMMON_200              = factor *      200;
				COMMON_100              = factor *      100;
				COMMON_20               = factor *      20;
				
				CHECKBOX_BG             = factor *      10;
				CHECKBOX_RIM            = factor *      2;
				CHECKBOX_FACE           = factor *      6;
				CHECKBOX_LABEL_X        = factor *      13;
				CHECKBOX_LABEL_H        = factor *      11;
				
				SHADOW_4                = factor *      4;
				SHADOW_2                = factor *      2;
				SHADOW_1                = factor *      1;
				
				COLOR_CHOOSER_W         = factor *      65;
				COLOR_CHOOSER_INPUT_W   = factor *      45;
				COLOR_CHOOSER_SWATCH_X  = factor *      50;
				COLOR_CHOOSER_PAD_SIZE  = factor *      150;
				
				HUI_SLIDER_LABEL_PAD    = factor *      5;
				HUI_SLIDER_LABEL_W_FIX  = factor *      60;
				HUI_SLIDER_LABEL_Y_FIX  = factor *      2;
				SLIDER_THICKNESS        = factor *      20;
				
				LABEL_H                 = factor *      17;     //18
				LISTITEM_LABEL_X        = factor *      5;
				NUMERIC_STEPPER_W       = factor *      80;
				PANEL_GRID              = factor *      10;
				TEXT_FIELD_MARGIN       = factor *      2;
			}
		}
	}
}
