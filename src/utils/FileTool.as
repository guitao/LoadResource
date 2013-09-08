package utils
{
	import flash.events.Event;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.utils.ByteArray;

	/**
	 * 
	 * @author warden_feng 2013-8-28
	 */
	public class FileTool
	{
		public static function readFileData(file:File):ByteArray
		{
			var bytes:ByteArray = new ByteArray();
			var fileStream:FileStream = new FileStream();
			fileStream.open(file, FileMode.READ);
			fileStream.readBytes(bytes, 0, fileStream.bytesAvailable);
			fileStream.close();
			bytes.position = 0;
			return bytes;
		}
		
		public static function saveFileData(file:File, data:ByteArray):void
		{
			var fs:FileStream = new FileStream();
			fs.openAsync(file, FileMode.WRITE);
			
			fs.writeBytes(data, 0, data.length);
			
			fs.close();
		}
		
		public static function readFileString(file:File):String
		{
			var fileStream:FileStream = new FileStream();
			fileStream.open(file, FileMode.READ);
			var content:String = fileStream.readUTFBytes(fileStream.bytesAvailable);
			fileStream.close();
			return content;
		}
		
	}
}