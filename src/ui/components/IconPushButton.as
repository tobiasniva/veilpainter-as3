package ui.components
{
    import flash.display.DisplayObject;
    import flash.display.DisplayObjectContainer;
    import flash.display.Bitmap;
    import flash.events.MouseEvent;
    import flash.geom.ColorTransform;

    import com.bit101.components.PushButton;
    import com.bit101.components.Style;
    import ui.StyleSizer;

    /**
     * IconPushButton
     * - Adds an icon DisplayObject and basic layout modes.
     * - Icon scale defaults to StyleSizer.SCALE_FACTOR to match global UI scaling flow.
     * - Optional icon tinting based on Style + button state (best for monochrome/white glyph PNGs).
     */
    public class IconPushButton extends PushButton
    {
        public static const ICON_ONLY:String   = "iconOnly";
        public static const ICON_LEFT:String   = "iconLeft";
        public static const ICON_RIGHT:String  = "iconRight";
        public static const ICON_TOP:String    = "iconTop";
        public static const ICON_BOTTOM:String = "iconBottom";

        protected var _icon:DisplayObject;
        protected var _iconPosition:String = ICON_ONLY;
        protected var _gap:Number = 4;

        // NaN means "use StyleSizer.SCALE_FACTOR"
        protected var _iconScale:Number = NaN;

        // Default to crisp pixels
        protected var _iconSmoothing:Boolean = false;

        // Theme/state tinting
        protected var _tintIcon:Boolean = true;
        protected var _isOver:Boolean = false;

        public function IconPushButton(parent:DisplayObjectContainer = null,
                                       xpos:Number = 0,
                                       ypos:Number = 0,
                                       label:String = "",
                                       defaultHandler:Function = null)
        {
            super(parent, xpos, ypos, label, defaultHandler);

            // Track rollover if you want hover-state tinting.
            addEventListener(MouseEvent.ROLL_OVER, onRollOver);
            addEventListener(MouseEvent.ROLL_OUT, onRollOut);
        }

        protected function onRollOver(e:MouseEvent):void { _isOver = true; invalidate(); }
        protected function onRollOut(e:MouseEvent):void  { _isOver = false; invalidate(); }

        public function set icon(value:DisplayObject):void
        {
            if(_icon && contains(_icon)) removeChild(_icon);

            _icon = value;

            if(_icon)
            {
                addChild(_icon);
                applyIconBitmapSettings();
            }

            invalidate();
        }
        public function get icon():DisplayObject { return _icon; }

        public function set iconPosition(value:String):void { _iconPosition = value; invalidate(); }
        public function get iconPosition():String { return _iconPosition; }

        public function set gap(value:Number):void { _gap = value; invalidate(); }
        public function get gap():Number { return _gap; }

        public function set iconScale(value:Number):void { _iconScale = value; invalidate(); }
        public function get iconScale():Number { return _iconScale; }

        public function set iconSmoothing(value:Boolean):void
        {
            _iconSmoothing = value;
            applyIconBitmapSettings();
            invalidate();
        }
        public function get iconSmoothing():Boolean { return _iconSmoothing; }

        /**
         * When true, applies a ColorTransform to the icon based on Style + button state.
         * Best for monochrome/white-on-transparent PNG icons.
         */
        public function set tintIcon(value:Boolean):void { _tintIcon = value; invalidate(); }
        public function get tintIcon():Boolean { return _tintIcon; }

        protected function applyIconBitmapSettings():void
        {
            if(!_icon) return;
            var bmp:Bitmap = _icon as Bitmap;
            if(bmp) bmp.smoothing = _iconSmoothing;
        }

        protected function getEffectiveIconScale():Number
        {
            if(!isNaN(_iconScale)) return _iconScale;
            return StyleSizer.SCALE_FACTOR;
        }

        protected function applyIconTint():void
        {
            if(!_icon) return;

            if(!_tintIcon)
            {
                // Reset to neutral
                _icon.transform.colorTransform = new ColorTransform();
                _icon.alpha = 1.0;
                return;
            }

            // use Style.LABEL_TEXT only - like other components...?
            var c:uint = Style.LABEL_TEXT;

            var r:int = (c >> 16) & 0xFF;
            var g:int = (c >>  8) & 0xFF;
            var b:int = (c      ) & 0xFF;

            _icon.transform.colorTransform = new ColorTransform(0, 0, 0, 1, r, g, b, 0);
            _icon.alpha = enabled ? 1.0 : 0.35;
        }

        override public function draw():void
        {
            super.draw();

            if(!_icon)
            {
                _label.visible = true;
                return;
            }

            // Apply scale each draw
            var s:Number = getEffectiveIconScale();
            _icon.scaleX = _icon.scaleY = s;

            // Apply theme/state tint each draw (so it tracks hover/selected/enabled)
            applyIconTint();

            // Decide label visibility based on mode and label contents.
            var hasLabel:Boolean = (_labelText != null && _labelText.length > 0);
            _label.visible = (hasLabel && _iconPosition != ICON_ONLY);

            if(_label.visible) _label.draw();

            var pad:Number = 2;
            var contentW:Number = _width  - pad * 2;
            var contentH:Number = _height - pad * 2;

            if(!_label.visible)
            {
                _icon.x = pad + (contentW - _icon.width) * 0.5;
                _icon.y = pad + (contentH - _icon.height) * 0.5;
                return;
            }

            var iconW:Number = _icon.width;
            var iconH:Number = _icon.height;
            var labW:Number  = _label.width;
            var labH:Number  = _label.height;

            var x0:Number;
            var y0:Number;

            switch(_iconPosition)
            {
                case ICON_LEFT:
                {
                    var totalW:Number = iconW + _gap + labW;
                    x0 = pad + (contentW - totalW) * 0.5;
                    _icon.x = x0;
                    _label.x = x0 + iconW + _gap;

                    _icon.y = pad + (contentH - iconH) * 0.5;
                    _label.y = pad + (contentH - labH) * 0.5;
                    break;
                }

                case ICON_RIGHT:
                {
                    totalW = labW + _gap + iconW;
                    x0 = pad + (contentW - totalW) * 0.5;
                    _label.x = x0;
                    _icon.x = x0 + labW + _gap;

                    _icon.y = pad + (contentH - iconH) * 0.5;
                    _label.y = pad + (contentH - labH) * 0.5;
                    break;
                }

                case ICON_TOP:
                {
                    var totalH:Number = iconH + _gap + labH;
                    y0 = pad + (contentH - totalH) * 0.5;
                    _icon.y = y0;
                    _label.y = y0 + iconH + _gap;

                    _icon.x = pad + (contentW - iconW) * 0.5;
                    _label.x = pad + (contentW - labW) * 0.5;
                    break;
                }

                case ICON_BOTTOM:
                {
                    totalH = labH + _gap + iconH;
                    y0 = pad + (contentH - totalH) * 0.5;
                    _label.y = y0;
                    _icon.y = y0 + labH + _gap;

                    _icon.x = pad + (contentW - iconW) * 0.5;
                    _label.x = pad + (contentW - labW) * 0.5;
                    break;
                }

                case ICON_ONLY:
                default:
                {
                    _label.visible = false;
                    _icon.x = pad + (contentW - iconW) * 0.5;
                    _icon.y = pad + (contentH - iconH) * 0.5;
                    break;
                }
            }
        }
    }
}
