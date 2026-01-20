package data
{
    import behavior.ImageWithLabel;
    import flash.display.Bitmap;


    public class AlphaImages
    {
        [Embed(source="/../assets/alphas/fade_in_out_in.png")]
        private static const Alpha_1:Class;
        
        [Embed(source="/../assets/alphas/fade_out_in_out.png")]
        private static const Alpha_2:Class;

        [Embed(source="/../assets/alphas/stripe_4.png")]
        private static const Alpha_3:Class;


        [Embed(source="/../assets/alphas/stripe_8.png")]
        private static const Alpha_4:Class;

        
        public static function getAll():Vector.<ImageWithLabel>
        {
            var vec:Vector.<ImageWithLabel> = new Vector.<ImageWithLabel>();
            vec.push(new ImageWithLabel("Fade 100-0-100", new Alpha_1() as Bitmap));
            vec.push(new ImageWithLabel("Fade 0-100-0", new Alpha_2() as Bitmap));
            vec.push(new ImageWithLabel("Striped 4", new Alpha_3() as Bitmap));
            vec.push(new ImageWithLabel("Striped 8", new Alpha_4() as Bitmap));
            return vec;
        }
    }
}