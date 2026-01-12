package
{
	import behavior.Brush;
	import data.AlphaImages;
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageDisplayState;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import utils.UiScaleUtil
	import view.Gui;
	import core.AppModel;
	import view.Canvas;
	import services.ViewportService;

	[SWF(backgroundColor="#000000", frameRate="60", width="1024", height="768")]
	public class VeilPainter extends Sprite
	{
		private var _canvas:Canvas;
		private var _brush:Brush;
		private var _gui:Gui;
		private var _viewportService:ViewportService;

		public function VeilPainter()
		{
			super();
			if (stage) onAddedToStage();
			else addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}

		private function onAddedToStage(e:Event = null):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);

			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			stage.displayState = StageDisplayState.FULL_SCREEN_INTERACTIVE;
			stage.addEventListener(Event.RESIZE, init);
			init();
		}

		private function init(e:Event = null):void
		{
			stage.removeEventListener(Event.RESIZE, init);

			// Model inits - TODO: Implement prefs...
			AppModel.instance.uiScale = UiScaleUtil.computeUiScale(); //TODO: Where init...?

			//-- Create canvas...
			_canvas = new Canvas();
			addChild(_canvas);

			//-- Create brush
			var initAlphaImage:Bitmap = AlphaImages.getAll()[0].bitmap;
			_brush = new Brush(initAlphaImage);
			addChild(_brush); // above canvas
			
			//-- GUI
			_gui = new Gui();
			addChild(_gui); // above brush

			//-- Viewport resize/orientation listener - RELIES ON GUI BEING INITIALIZED!
			_viewportService = new ViewportService(stage);
		}


		//-- TODO: Move to own class...
		/*
		public function saveImage():void
		{
			trace("perm status: " + File.permissionStatus);
			
			var byteArray:ByteArray = PNGEncoder.encode(_bmpDataUsedBySaveToBeRemoved);
			
			var d:Date = new Date();
			var dtf:DateTimeFormatter = new DateTimeFormatter("en-US");
			dtf.setDateTimePattern("yyyyMMdd_HHmmss");
			var imgName:String = "veil_" + dtf.format(d) + ".png";

			var parent:DisplayObjectContainer = this as DisplayObjectContainer;
			SaveImageWithDialog.savePNG(
				byteArray,
				imgName,
				function():void { trace("Saved: " + imgName); },
				function():void { trace("User canceled"); },
				function(err:String):void
				{
					trace("Save failed: " + err);
					//TODO: implemtent popup with hint that saving to downloads folder might work
				}
			);
		}
		*/
	}
}
