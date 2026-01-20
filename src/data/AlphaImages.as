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

        [Embed(source="/../assets/alphas/ribbon_center.png")]
        private static const Alpha_3:Class;

        [Embed(source="/../assets/alphas/ribbon_2_edge.png")]
        private static const Alpha_4:Class;

        [Embed(source="/../assets/alphas/ribbon_4.png")]
        private static const Alpha_5:Class;

        [Embed(source="/../assets/alphas/ribbon_8.png")]
        private static const Alpha_6:Class;

        [Embed(source="/../assets/alphas/full.png")]
        private static const Alpha_7:Class;

        
        public static function getAll():Vector.<ImageWithLabel>
        {
            var vec:Vector.<ImageWithLabel> = new Vector.<ImageWithLabel>();

            vec.push(new ImageWithLabel("Fade 100-0-100", new Alpha_1() as Bitmap));

            vec.push(new ImageWithLabel("Fade 0-100-0", new Alpha_2() as Bitmap));
            
            vec.push(new ImageWithLabel("Ribbon center", new Alpha_3() as Bitmap));
            
            vec.push(new ImageWithLabel("Ribbon 2 edge", new Alpha_4() as Bitmap));

            vec.push(new ImageWithLabel("Ribbon 4", new Alpha_5() as Bitmap));

            vec.push(new ImageWithLabel("Ribbon 8", new Alpha_6() as Bitmap));

            vec.push(new ImageWithLabel("Full", new Alpha_7() as Bitmap));
            
            return vec;
        }
    }
}