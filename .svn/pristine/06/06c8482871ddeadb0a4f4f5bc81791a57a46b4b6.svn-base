package modules.load
{
	import com.junkbyte.console.Cc;

	import flash.events.Event;
	import flash.events.MouseEvent;

	import br.com.stimuli.loading.BulkLoader;
	import br.com.stimuli.loading.loadingtypes.ImageItem;

	import fla.view.LoadView;

	import modules.ViewManager;

	public class LoadViewManager extends ViewManager
	{
		private var loadView:LoadView;

		private var configLoader:BulkLoader;

		private var paths:Array = [];

		private var root:String = "d:/";

		public function LoadViewManager()
		{
			init();
			configLoader = new BulkLoader("configLoader");
			// set level to verbose, for debugging only
			configLoader.logLevel = BulkLoader.LOG_INFO;

			// dispatched when ALL the items have been loaded:
			configLoader.addEventListener(BulkLoader.COMPLETE, onAllItemsLoaded);

			loadConfig();
		}

		public function init():void
		{
			loadView = new LoadView();

			UIAllRefer.contentLayer.addChild(loadView);

			addListeners();
		}

		private function addListeners():void
		{
			loadView.addEventListener(MouseEvent.CLICK, onLoginBtnClick);
		}

		private function onLoginBtnClick(event:MouseEvent):void
		{
			switch (event.target)
			{
				case loadView.load_btn:
					dispatcher.dispatchEvent(new LoadEvent(LoadEvent.LOAD_START, {paths: paths, root: root}));
					break;
				case loadView.loadConfig_btn:
					loadConfig();
					break;
			}
		}

		private function loadConfig():void
		{
			configLoader.removeAll();

			// now add items to load
			// simplest case:
			configLoader.add("Config.swf");

			// now start the loading
			configLoader.start();
		}

		public function onAllItemsLoaded(evt:Event):void
		{
			var imageItem:ImageItem = configLoader.get("Config.swf") as ImageItem;
			var cls:Class = imageItem.getDefinitionByName("Config") as Class;
			var o:* = new cls();
			paths = o.getPaths();

			root = o.getRoot();

			Cc.info("paths:" + paths);
			Cc.info("root:" + root);
		}
	}
}
