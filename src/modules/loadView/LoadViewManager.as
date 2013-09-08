package modules.loadView
{
	import flash.events.MouseEvent;
	import flash.filesystem.File;
	import flash.utils.ByteArray;
	
	import mx.utils.StringUtil;
	
	import fla.view.LoadUI;
	
	import modules.ViewManager;
	import modules.load.Load;
	import modules.load.LoadEvent;
	
	import utils.FileTool;

	public class LoadViewManager extends ViewManager
	{
		private var mainUI:LoadUI;

		private var loadings:Array = [];

		private var paths:Array = [];

		public function LoadViewManager()
		{
			init();
		}

		public function init():void
		{
			mainUI = new LoadUI();

			UIAllRefer.contentLayer.addChild(mainUI);

			addListeners();
		}

		private function addListeners():void
		{
			mainUI.addEventListener(MouseEvent.CLICK, onLoginBtnClick);
		}

		private function onLoginBtnClick(event:MouseEvent):void
		{
			switch (event.target)
			{
				case mainUI.load_btn:
					paths = createPaths();
					loadings = paths.concat();

					var loadData:Object = {urls: paths, props: {type: "binary"}, singleComplete: singleComplete, singleCompleteParam: {}, allItemsLoaded: completeHandler};

					dispatcher.dispatchEvent(new LoadEvent(LoadEvent.LOAD_RESOURCE, loadData));
					break;
			}
		}
		
		private function createPaths():Array
		{
			var pathStr:String = mainUI.pathTxt.text;
			var pathList:Array = pathStr.split(";");
			var newPaths:Array = [];
			for (var i:int = 0; i < pathList.length; i++)
			{
				var path:String = pathList[i];
				var index:int = path.indexOf("?");
				if (index != -1)
				{
					path = path.substring(0, index);
				}
				path = StringUtil.trim(path);
				if (path.length > 0)
				{
					newPaths.push(path);
				}
			}
			return newPaths;
		}

		private function singleComplete(param:Object):void
		{
			var index:int = loadings.indexOf(param.url);
			if (index != -1)
			{
				loadings.splice(index, 1);
			}
			mainUI.stateTxt.text = (paths.length - loadings.length) + "/" + paths.length;

			var path:String = param.url.replace("http://", mainUI.rootTxt.text);

			var file:File = File.desktopDirectory.resolvePath(path);

			var data:ByteArray = Load.loader.getBinary(param.url);
			FileTool.saveFileData(file, data);
		}

		public function completeHandler():void
		{
			mainUI.stateTxt.text = "资源加载完成";
		}
	}
}
