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
		public static const MIN_TABLET_SCREEN_W:int     	= 900;

		public static const UI_SCALE_PHONE:int     			= 3;
		public static const UI_SCALE_TABLET:int     		= 3;
		public static const UI_SCALE_DESKTOP:int     		= 1;
		
		public static const SIZE_MULTIPLIER_DEFAULT:int     = 1; // regarding scale of bitmap vs screen size
		
		public static const BG_COLOR_DEFAULT:uint           = 0x222222;
		
		public static const BRUSH_COLOR_DEFAULT:uint        = 0x99aacc;
		public static const BRUSH_ALPHA_DEFAULT:Number      = 0.5;
		
		public static const BRUSH_BLENDMODE_DEFAULT:String  = BlendMode.NORMAL;
		public static const BRUSH_BLENDMODE_INDEX:int       = 0;         //-- Normal - see BlendModes
		
		public static const CHAIN_LINK_COLOR:uint           = 0x808080;
		public static const CHAIN_LINK_SIZE:int             = 4;            //-- Size of dots...
		
		public static const NUM_LINKS_DEFAULT:int           = 4;
		public static const NUM_LINKS_MIN:int               = 2;
		public static const NUM_LINKS_STEP:int              = 2;
		public static const NUM_LINKS_MAX:int               = 16;
		
		public static const ELASTICITY_DEFAULT:Number       = 0.85;
		public static const ELASTICITY_MIN:Number           = 0.0;
		public static const ELASTICITY_MAX:Number           = 1.0;
		
		public static const STRENGTH_DEFAULT:Number         = 0.028;
		public static const STRENGTH_MIN:Number             = 0.0;
		public static const STRENGTH_MAX:Number             = 0.1;
		
		public static const DEGRADATION_DEFAULT:Number      = 2.7;
		public static const DEGRADATION_MIN:Number          = 0.05;
		public static const DEGRADATION_MAX:Number          = 10.0;
		
	}
}
