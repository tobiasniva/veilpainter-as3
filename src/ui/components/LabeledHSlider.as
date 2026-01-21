package ui.components
{
    import com.bit101.components.Component;
    import com.bit101.components.HSlider;
    import com.bit101.components.Label;

    import flash.display.DisplayObjectContainer;
    import flash.events.Event;
    import flash.text.TextField;

    /**
     * LabeledHSlider
     * Wrapper around MinimalComps HSlider with two overlay labels:
     *  - name label: left aligned, inside track area
     *  - value label: right aligned, inside track area
     *
     * Designed to scale/position predictably as a single grid-aligned unit.
     */
    public class LabeledHSlider extends Component
    {
        public static const LAYOUT_CENTER:String = "center";   // vertically centered
        public static const LAYOUT_TOP:String    = "top";      // slightly above center (track-friendly)

        private var _slider:HSlider;
        private var _nameLabel:Label;
        private var _valueLabel:Label;

        private var _nameText:String = "";
        private var _showName:Boolean = true;
        private var _showValue:Boolean = true;

        private var _precision:int = 2;
        private var _valueFormatter:Function = null; // function(value:Number):String

        private var _paddingLeft:Number = 10;
        private var _paddingRight:Number = 10;

        private var _layoutMode:String = LAYOUT_CENTER;
        private var _overlayAlpha:Number = 0.85;

        public function LabeledHSlider(parent:DisplayObjectContainer = null, xpos:Number = 0, ypos:Number = 0,
                                       nameText:String = "", defaultValue:Number = 0, callback:Function = null)
        {
            super(parent, xpos, ypos);

            _nameText = nameText;

            // Slider (core control)
            _slider = new HSlider(this, 0, 0, callback);
            _slider.value = defaultValue;
            _slider.addEventListener(Event.CHANGE, onSliderChange, false, 0, true);

            // Overlay labels
            _nameLabel = new Label(this, 0, 0, _nameText);
            _valueLabel = new Label(this, 0, 0, "");

            // Ensure overlays never block drag interaction
            _nameLabel.mouseEnabled = false;
            _nameLabel.mouseChildren = false;
            _valueLabel.mouseEnabled = false;
            _valueLabel.mouseChildren = false;

            // Subtle overlay look (tweak to taste)
            _nameLabel.alpha = _overlayAlpha;
            _valueLabel.alpha = _overlayAlpha;

            updateValueText();
            invalidate();
        }

        // ---- Public access to underlying slider (if needed) ----
        public function get slider():HSlider { return _slider; }

        // ---- Common forwarded properties ----
        public function get minimum():Number { return _slider.minimum; }
        public function set minimum(v:Number):void { _slider.minimum = v; updateValueText(); }

        public function get maximum():Number { return _slider.maximum; }
        public function set maximum(v:Number):void { _slider.maximum = v; updateValueText(); }

        public function get value():Number { return _slider.value; }
        public function set value(v:Number):void { _slider.value = v; updateValueText(); dispatchEvent(new Event(Event.CHANGE)); }

        public function get tick():Number { return _slider.tick; }
        public function set tick(v:Number):void { _slider.tick = v; }

        public function get labelPrecision():int { return _precision; }
        public function set labelPrecision(v:int):void { _precision = v; updateValueText(); }

        /**
         * Optional formatter: function(value:Number):String
         * Overrides labelPrecision formatting.
         */
        public function get valueFormatter():Function { return _valueFormatter; }
        public function set valueFormatter(fn:Function):void { _valueFormatter = fn; updateValueText(); }

        // ---- Overlay label controls ----
        public function get nameText():String { return _nameText; }
        public function set nameText(v:String):void { _nameText = v; _nameLabel.text = v; invalidate(); }

        public function get showName():Boolean { return _showName; }
        public function set showName(v:Boolean):void { _showName = v; _nameLabel.visible = v; invalidate(); }

        public function get showValue():Boolean { return _showValue; }
        public function set showValue(v:Boolean):void { _showValue = v; _valueLabel.visible = v; invalidate(); }

        public function get overlayAlpha():Number { return _overlayAlpha; }
        public function set overlayAlpha(v:Number):void
        {
            _overlayAlpha = v;
            _nameLabel.alpha = v;
            _valueLabel.alpha = v;
        }

        public function get paddingLeft():Number { return _paddingLeft; }
        public function set paddingLeft(v:Number):void { _paddingLeft = v; invalidate(); }

        public function get paddingRight():Number { return _paddingRight; }
        public function set paddingRight(v:Number):void { _paddingRight = v; invalidate(); }

        public function get layoutMode():String { return _layoutMode; }
        public function set layoutMode(v:String):void { _layoutMode = v; invalidate(); }

        // ---- Layout / draw ----
        override public function setSize(w:Number, h:Number):void
        {
            super.setSize(w, h);
            invalidate();
        }

        //TODO: Did not really change anything...
        // override public function set width(w:Number):void
        // {
        //     setSize(w, _height > 0 ? _height : super.height);
        // }

        // override public function set height(h:Number):void
        // {
        //     setSize(_width > 0 ? _width : super.width, h);
        // }

        override public function draw():void
        {
            super.draw();

            // If wrapper has no explicit size yet, adopt HSlider's natural size.
            if (_width <= 0)  _width  = _slider.width;
            if (_height <= 0) _height = _slider.height;

            // Make the slider occupy the full component bounds.
            // If you want extra top/bottom breathing room, adjust here.
            _slider.setSize(_width, _height);

            // Ensure texts are up to date (in case fonts changed elsewhere)
            updateValueText();

            // Vertical positioning:
            // "center": center labels vertically in the control
            // "top": bias slightly upward so they sit above the knob/track visually
            var yCenter:Number = (_height - _nameLabel.height) * 0.5;
            if (_layoutMode == LAYOUT_TOP)
            {
                // Small upward bias; tune to taste
                yCenter -= 2;
            }

            // Left overlay label
            _nameLabel.text = _nameText;
            _nameLabel.visible = _showName;
            _nameLabel.x = _paddingLeft;
            _nameLabel.y = yCenter;

            // Right overlay value label (inside, right-aligned)
            _valueLabel.visible = _showValue;


            _valueLabel.draw();
            var tf:TextField = getInternalTF(_valueLabel);
            var rightEdge:Number = _width - _paddingRight;
            // Conservative fudge; tweak if needed (font-dependent)
            const FUDGE:Number = 6;
            if (tf)
            {
                // Align the *rendered text* right edge to rightEdge.
                // Include the TF's internal x-offset.
                _valueLabel.x = rightEdge - (tf.x + tf.textWidth + FUDGE);
            }
            else
            {
                // Fallback: use label width (least accurate)
                _valueLabel.x = rightEdge - (_valueLabel.width);
            }

            _valueLabel.y = yCenter;
        }

        // ---- Internals ----
        private function onSliderChange(e:Event):void
        {
            updateValueText();
            dispatchEvent(new Event(Event.CHANGE));
        }

        private function updateValueText():void
        {
            if (!_valueLabel) return;

            var v:Number = _slider.value;

            if (_valueFormatter != null)
            {
                _valueLabel.text = String(_valueFormatter(v));
            }
            else
            {
                _valueLabel.text = formatWithPrecision(v, _precision);
            }
        }

        private function formatWithPrecision(v:Number, p:int):String
        {
            // Avoid toFixed edge cases if you sometimes want integer presentation.
            // If you always want fixed decimals, replace with v.toFixed(p).
            var pow:Number = Math.pow(10, p);
            var rounded:Number = Math.round(v * pow) / pow;

            // Use toFixed so alignment is stable (e.g., 0.50 not 0.5)
            return rounded.toFixed(p);
        }

        private function getInternalTF(lbl:Label):TextField
        {
            var tf:TextField = null;
            try { tf = lbl["_tf"] as TextField; } catch (e:Error) {}
            if (!tf) { try { tf = lbl["tf"] as TextField; } catch (e2:Error) {} }
            if (!tf) { try { tf = lbl["_textField"] as TextField; } catch (e3:Error) {} }
            return tf;
        }
    }
}
