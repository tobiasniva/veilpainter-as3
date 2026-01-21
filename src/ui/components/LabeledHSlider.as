package ui.components
{
    import com.bit101.components.Component;
    import com.bit101.components.HSlider;
    import com.bit101.components.Label;

    import flash.display.DisplayObjectContainer;
    import flash.events.Event;
    import flash.text.TextField;

    public class LabeledHSlider extends Component
    {
        private var _slider:HSlider;
        private var _nameLabel:Label;
        private var _valueLabel:Label;

        private var _nameText:String = "";
        private var _precision:int = 2;

        private var _paddingLeft:Number = 10;
        private var _paddingRight:Number = 10;

        // Small safety margin because TextField metrics can be tight.
        private const TEXT_FUDGE:Number = 6;

        public function LabeledHSlider(parent:DisplayObjectContainer = null, xpos:Number = 0, ypos:Number = 0,
                                       nameText:String = "", defaultValue:Number = 0, callback:Function = null)
        {
            super(parent, xpos, ypos);

            _nameText = nameText;

            _slider = new HSlider(this, 0, 0, callback);
            _slider.value = defaultValue;
            _slider.addEventListener(Event.CHANGE, onSliderChange, false, 0, true);

            _nameLabel = new Label(this, 0, 0, _nameText);
            _valueLabel = new Label(this, 0, 0, "");

            // Do not block drag
            _nameLabel.mouseEnabled = _nameLabel.mouseChildren = false;
            _valueLabel.mouseEnabled = _valueLabel.mouseChildren = false;

            updateValueTextAndPosition();
            invalidate();
        }

        public function get slider():HSlider { return _slider; }

        public function get minimum():Number { return _slider.minimum; }
        public function set minimum(v:Number):void { _slider.minimum = v; updateValueTextAndPosition(); }

        public function get maximum():Number { return _slider.maximum; }
        public function set maximum(v:Number):void { _slider.maximum = v; updateValueTextAndPosition(); }

        public function get value():Number { return _slider.value; }
        public function set value(v:Number):void
        {
            _slider.value = v;
            updateValueTextAndPosition();
            dispatchEvent(new Event(Event.CHANGE));
        }

        public function get labelPrecision():int { return _precision; }
        public function set labelPrecision(v:int):void { _precision = v; updateValueTextAndPosition(); }

        public function get nameText():String { return _nameText; }
        public function set nameText(v:String):void { _nameText = v; _nameLabel.text = v; invalidate(); }

        public function get paddingLeft():Number { return _paddingLeft; }
        public function set paddingLeft(v:Number):void { _paddingLeft = v; invalidate(); }

        public function get paddingRight():Number { return _paddingRight; }
        public function set paddingRight(v:Number):void { _paddingRight = v; invalidate(); }

        override public function setSize(w:Number, h:Number):void
        {
            super.setSize(w, h);
            invalidate();
        }

        override public function draw():void
        {
            super.draw();

            if (_width <= 0)  _width  = _slider.width;
            if (_height <= 0) _height = _slider.height;

            _slider.setSize(_width, _height);

            // Simple vertical centering
            var yCenter:Number = (_height - _nameLabel.height) * 0.5;

            _nameLabel.text = _nameText;
            _nameLabel.x = _paddingLeft;
            _nameLabel.y = yCenter;

            // Value label text may already be correct; just ensure position is correct for current width
            positionValueLabel(yCenter);
        }

        private function onSliderChange(e:Event):void
        {
            updateValueTextAndPosition();
            dispatchEvent(new Event(Event.CHANGE));
        }

        private function updateValueTextAndPosition():void
        {
            if (!_valueLabel) return;

            _valueLabel.text = formatWithPrecision(_slider.value, _precision);

            // Reposition immediately so it reacts even if draw() isn't called.
            // Use current component height for y (fallback to slider height if needed).
            var h:Number = (_height > 0) ? _height : _slider.height;
            var yCenter:Number = (h - _valueLabel.height) * 0.5;
            positionValueLabel(yCenter);

            // Still invalidate so future resizes redraw cleanly.
            invalidate();
        }

        private function positionValueLabel(yPos:Number):void
        {
            _valueLabel.y = yPos;

            var rightEdge:Number = _width - _paddingRight;

            // If width hasn't been set yet, fall back to current rendered width
            if (_width <= 0) rightEdge = _slider.width - _paddingRight;

            // Use internal TextField metrics if accessible
            var tf:TextField = getInternalTF(_valueLabel);
            if (tf)
            {
                // Right-align the actual glyph run (tf.x offset matters)
                _valueLabel.x = rightEdge - (tf.x + tf.textWidth + TEXT_FUDGE);
            }
            else
            {
                // Fallback
                _valueLabel.draw();
                _valueLabel.x = rightEdge - (_valueLabel.width);
            }
        }

        private function formatWithPrecision(v:Number, p:int):String
        {
            var pow:Number = Math.pow(10, p);
            var rounded:Number = Math.round(v * pow) / pow;
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
