package
{
	import flash.display.Sprite;
	import flash.events.Event;
	
	import modules.load.Load;
	import modules.loadView.LoadView;
	
	[SWF(width="400",height="300")]
	public class LoadResource extends Sprite
	{
		public function LoadResource()
		{
			addEventListener(Event.ADDED_TO_STAGE, onAddToStage);
		}
		
		private function onAddToStage(event:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAddToStage);
			
			MyCC.initFlashConsole(this);
			
			UIAllRefer.stage = this.stage;
			
			this.stage.addChild(UIAllRefer.backLayer);
			this.stage.addChild(UIAllRefer.contentLayer);
			this.stage.addChild(UIAllRefer.popLayer);
			this.stage.addChild(UIAllRefer.infoLayer);
			this.stage.addChild(UIAllRefer.tipLayer);
			
			initMoudles();
		}
		
		/**
		 * 初始化模块
		 **/
		private function initMoudles():void
		{
			Load.init();
			
			LoadView.init();
		}
	}
}