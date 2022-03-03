package ui
{
	import com.bit101.components.Style;

	public class StyleChanger
	{
		//TODO: Figure out a DPI-convention instead...?

		public static function Size_4x()
		{
			with(Style)
			{
				fontSize                = 32;
				BUTTON_W                = 400;
				BUTTON_H                = 80;
				CHECKBOX_BG             = 40;
				CHECKBOX_RIM            = 8;
				CHECKBOX_FACE           = 24;
				CHECKBOX_LABEL_X        = 48;
				CHECKBOX_LABEL_H        = 40;
				COLOR_CHOOSER_W         = 260;
				COLOR_CHOOSER_H         = 60;
				COLOR_CHOOSER_INPUT_W   = 180;
				COLOR_CHOOSER_SWATCH_X  = 200;
				COLOR_CHOOSER_BOX       = 72;
				COMBOBOX_W              = 400;
				COMBOBOX_H              = 80;
				HUI_SLIDER_W            = 800;
				HUI_SLIDER_H            = 72;
				HUI_SLIDER_LABEL_PAD    = 20;
				HUI_SLIDER_LABEL_W_FIX  = 240;
				SLIDER_W_OR_H           = 400;
				SLIDER_THICKNESS        = 40;
				INPUTTEXT_W             = 400;
				INPUTTEXT_H             = 64;
				LABEL_H                 = 72;
				LIST_SIZE               = 400;
				LIST_ITEM_H             = 80;
				LISTITEM_W              = 400;
				LISTITEM_H              = 80;
				LISTITEM_LABEL_X        = 20;
				NUMERIC_STEPPER_W       = 320;
				NUMERIC_STEPPER_H       = 72;
				PANEL_SIZE              = 400;
				PANEL_GRID              = 40;
				TEXT_W                  = 800;
				TEXT_H                  = 400;
				TEXT_FIELD_MARGIN       = 8;
			}
		}

		public static function Size_3x()
		{
			with(Style)
			{
				fontSize                = 24;
				BUTTON_W                = 300;
				BUTTON_H                = 60;
				CHECKBOX_BG             = 30;
				CHECKBOX_RIM            = 6;
				CHECKBOX_FACE           = 18;
				CHECKBOX_LABEL_X        = 36;
				CHECKBOX_LABEL_H        = 30;
				COLOR_CHOOSER_W         = 195;
				COLOR_CHOOSER_H         = 45;
				COLOR_CHOOSER_INPUT_W   = 135;
				COLOR_CHOOSER_SWATCH_X  = 150;
				COLOR_CHOOSER_BOX       = 54;
				COMBOBOX_W              = 300;
				COMBOBOX_H              = 60;
				HUI_SLIDER_W            = 600;
				HUI_SLIDER_H            = 54;
				HUI_SLIDER_LABEL_PAD    = 15;
				HUI_SLIDER_LABEL_W_FIX  = 180;
				SLIDER_W_OR_H           = 300;
				SLIDER_THICKNESS        = 30;
				INPUTTEXT_W             = 300;
				INPUTTEXT_H             = 48;
				LABEL_H                 = 54;
				LIST_SIZE               = 300;
				LIST_ITEM_H             = 60;
				LISTITEM_W              = 300;
				LISTITEM_H              = 60;
				LISTITEM_LABEL_X        = 15;
				NUMERIC_STEPPER_W       = 240;
				NUMERIC_STEPPER_H       = 54;
				PANEL_SIZE              = 300;
				PANEL_GRID              = 30;
				TEXT_W                  = 600;
				TEXT_H                  = 300;
				TEXT_FIELD_MARGIN       = 6;
			}
		}
		
		public static function Size_2x() 
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

		public static function Size_1x()
		{
			with(Style)
			{
				fontSize                = 8;
				BUTTON_W                = 100;
				BUTTON_H                = 20;
				CHECKBOX_BG             = 10; 
				CHECKBOX_RIM            = 2;  
				CHECKBOX_FACE           = 6;  
				CHECKBOX_LABEL_X        = 12; 
				CHECKBOX_LABEL_H        = 10; 
				COLOR_CHOOSER_W         = 65; 
				COLOR_CHOOSER_H         = 15; 
				COLOR_CHOOSER_INPUT_W   = 45; 
				COLOR_CHOOSER_SWATCH_X  = 50; 
				COLOR_CHOOSER_BOX       = 16; 
				COMBOBOX_W              = 100;
				COMBOBOX_H              = 20; 
				HUI_SLIDER_W            = 200;
				HUI_SLIDER_H            = 18; 
				HUI_SLIDER_LABEL_PAD    = 5;  
				HUI_SLIDER_LABEL_W_FIX  = 60;
				SLIDER_W_OR_H           = 100;
				SLIDER_THICKNESS        = 10; 
				INPUTTEXT_W             = 100;
				INPUTTEXT_H             = 16;
				LABEL_H                 = 18; 
				LIST_SIZE               = 100;
				LIST_ITEM_H             = 20; 
				LISTITEM_W              = 100;
				LISTITEM_H              = 20; 
				LISTITEM_LABEL_X        = 5;  
				NUMERIC_STEPPER_W       = 80; 
				NUMERIC_STEPPER_H       = 16; 
				PANEL_SIZE              = 100;
				PANEL_GRID              = 10; 
				TEXT_W                  = 200;
				TEXT_H                  = 100;
				TEXT_FIELD_MARGIN       = 2;  
			}
		}
	}
}
