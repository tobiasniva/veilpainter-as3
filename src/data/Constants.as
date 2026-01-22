package data
{
	import flash.display.BlendMode;

	/**
	 *
	 * @author: Tobi Wan Kenobi
	 * Somewhat a model for now...holding various values, both initial and variable...
	 * - Consider making PlayerPrefs-stuff later...
	 */
	public class Constants
	{
		public static const UI_SCALE_DEFAULT:int     		= 3; 		// For phones and tablets for now
		public static const UI_MAGIC_SIZE_NUMBER:int		= 20; 		// Height px of button, used here and there
		public static const UI_SLIDER_LABEL_ALPHA:Number	= 0.90;		// Alpha for slider labels
		public static const UI_PANEL_COLOR:uint				= 0x333333;	// Bg color for panels
		public static const UI_PANEL_ALPHA:Number			= 0.45;		// Alpha for panels
		public static const UI_MAX_WIDTH:int				= 768; 		// Max width of UI panel

		public static const UI_ALIGN_H_DEFAULT:int 			= AlignHorizontal.CENTER;
		public static const UI_ALIGN_V_DEFAULT:int 			= AlignVertical.TOP;
		public static const UI_ACTIVE_VIEW_DEFAULT:int   	= SettingsViewActive.APP;

		public static const UI_HIDE_ON_DRAW_DEFAULT:Boolean = true;
		public static const UI_DEBUG_BOUNDS_DEFAULT:Boolean = false;
		
		public static const CANVAS_MULTIPLIER_DEFAULT:int   = 1; // regarding scale of bitmap vs screen size
		public static const CANVAS_COLOR_DEFAULT:uint       = 0x222222;
		
		public static const BRUSH_COLOR_DEFAULT:uint        = 0x99aacc;
		public static const BRUSH_OPACITY_DEFAULT:Number    = 0.5;

		public static const BRUSH_BLENDMODE_DEFAULT:String  = BlendMode.NORMAL;
		public static const BRUSH_BLENDMODE_INDEX:int       = 0;         //-- Normal - see BlendModes
		
		public static const CHAIN_LINK_COLOR:uint           = 0x808080;
		public static const CHAIN_LINK_SIZE:int             = 4;            //-- Size of dots...
		public static const CHAIN_LINK_SIZE_MIN:int         = 2;
		public static const CHAIN_LINK_SIZE_MAX:int         = 12;
		
		public static const NUM_LINKS_DEFAULT:int           = 4;
		public static const NUM_LINKS_MIN:int               = 2;
		public static const NUM_LINKS_STEP:int              = 2;
		public static const NUM_LINKS_MAX:int               = 16;
		
		public static const ELASTICITY_DEFAULT:Number       = 0.85;
		public static const ELASTICITY_MIN:Number           = 0.0;
		public static const ELASTICITY_MAX:Number           = 0.99;
		
		public static const STRENGTH_DEFAULT:Number         = 0.028;
		public static const STRENGTH_MIN:Number             = 0.0;
		public static const STRENGTH_MAX:Number             = 0.1;
		
		public static const DEGRADATION_DEFAULT:Number      = 2.7;
		public static const DEGRADATION_MIN:Number          = 0.05;
		public static const DEGRADATION_MAX:Number          = 10.0;
		
	}
}
