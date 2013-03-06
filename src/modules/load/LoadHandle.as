package modules.load
{
	import com.junkbyte.console.Cc;
	
	import flash.events.Event;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.utils.ByteArray;
	
	import br.com.stimuli.loading.BulkLoader;
	import br.com.stimuli.loading.BulkProgressEvent;
	import br.com.stimuli.loading.loadingtypes.BinaryItem;
	
	import modules.GameDispatcher;

	public class LoadHandle
	{
		private var dispather:GameDispatcher = GameDispatcher.instance;

		public var loader:BulkLoader;
		
		private var root:String = "d:/";

		public function LoadHandle()
		{
			// creates a BulkLoader instance with a name of "main-site", that can be used to retrieve items without having a reference to this instance
			loader = new BulkLoader("main-site");
			// set level to verbose, for debugging only
			loader.logLevel = BulkLoader.LOG_INFO;

			dispather.addEventListener(LoadEvent.LOAD_START,onLoadStart);

			// dispatched when ALL the items have been loaded:
			loader.addEventListener(BulkLoader.COMPLETE, onAllItemsLoaded);

			// dispatched when any item has progress:
			loader.addEventListener(BulkLoader.PROGRESS, onAllItemsProgress);

		}
		
		private function onLoadStart(event:LoadEvent):void
		{
			loader.removeAll();
			
			var paths:Array = event.data.paths;
			root = event.data.root;
			
			for each(var url:String in paths)
			{
				loader.add(url, {type: "binary"});
				loader.get(url).addEventListener(BulkLoader.COMPLETE, onSingleComplete);
			}
			
			// now start the loading
			loader.start();
		}
		
		private function onSingleComplete(event:Event):void
		{
			var binaryItem:BinaryItem = event.target as BinaryItem;
			
			var url:String = binaryItem.url.url;
			
			loader.get(url).removeEventListener(BulkLoader.COMPLETE, onSingleComplete);
			
			var data:ByteArray = loader.getBinary(url);
			// you can get the content from the url:
			
			var path:String = url.replace("http://", root);
			
			var file:File = File.desktopDirectory.resolvePath(path);
			
			var stream:FileStream = new FileStream();
			stream.open(file, FileMode.WRITE);
			stream.writeBytes(data);
			stream.close();
		}

		public function onAllItemsLoaded(evt:Event):void
		{
			Cc.info("every thing is loaded!");
		}

		// this evt is a "super" progress event, it has all the information you need to 
		// display progress by many criterias (bytes, items loaded, weight)
		public function onAllItemsProgress(evt:BulkProgressEvent):void
		{
			Cc.info(evt.loadingStatus());
		}
	}
}
