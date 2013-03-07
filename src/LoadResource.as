package
{
	import com.junkbyte.console.Cc;
	import com.junkbyte.console.addons.autoFocus.CommandLineAutoFocusAddon;
	import com.junkbyte.console.addons.displaymap.DisplayMapAddon;
	
	import flash.display.Sprite;
	import flash.events.Event;
	
	import modules.load.Load;
	
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
			
			initFlashConsole();
			
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
		}
		
		/**
		 * 初始化控制台
		 **/
		public function initFlashConsole():void
		{
			//
			// SETUP - only required once
			//
			// you must modify the styles before starting console.
			Cc.config.style.big(); // BIGGER text. this modifies the config variables such as traceFontSize, menuFontSize
			Cc.config.style.whiteBase(); // Black on white. this modifies the config variables such as priority0, priority1, etc
			Cc.config.style.backgroundAlpha = 0.6; // makes it non-transparent background.
			
			Cc.startOnStage(this, "`"); // "`" - change for password. This will start hidden
			Cc.commandLine = true; // enable command line
			Cc.config.commandLineAllowed = true;
			
			Cc.width = stage.stageWidth;
			Cc.height = stage.stageHeight;
			
			DisplayMapAddon.registerCommand();
			DisplayMapAddon.addToMenu("DM"); // DisplayMapper. click on DM button at top menu to start.
			
			CommandLineAutoFocusAddon.registerToConsole(); // this addon auto focus to commandline when console becomes visible
		}
	}
}