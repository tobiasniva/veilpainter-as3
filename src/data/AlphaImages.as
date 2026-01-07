package data
{
    import behavior.ImageWithLabel;
    import flash.display.Bitmap;


    public class AlphaImages
    {
        [Embed(source="/../assets/alphas/alpha_1.png")]
        private static const Alpha1:Class;
        
        [Embed(source="/../assets/alphas/alpha_2.png")]
        private static const Alpha2:Class;

        [Embed(source="/../assets/alphas/alpha_3.png")]
        private static const Alpha3:Class;
        
        public static function getAll():Vector.<ImageWithLabel>
        {
            var vec:Vector.<ImageWithLabel> = new Vector.<ImageWithLabel>();
            vec.push(new ImageWithLabel("alpha_1.png", new Alpha1() as Bitmap));
            vec.push(new ImageWithLabel("alpha_2.png", new Alpha2() as Bitmap));
            vec.push(new ImageWithLabel("alpha_3.png", new Alpha3() as Bitmap));
            return vec;
        }
    }
}