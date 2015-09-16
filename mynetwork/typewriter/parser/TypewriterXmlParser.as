package pl.mynetwork.typewriter.parser
{
	import flash.events.EventDispatcher;
	import flash.net.URLLoader;
	import flash.events.Event;
	import flash.net.URLRequest;
	import flash.events.IOErrorEvent;

	public class TypewriterXmlParser extends EventDispatcher
	{



		//---------------------------------------------------
		private var loader									:URLLoader;
		private var rawXML									:XML;




		//---------------------------------------------------
		private var _type_text								:String;
		private var _title										:String;
		private var _smallTitle								:String;
		private var _instruction							:String;
		private var _helpText									:String;





		//---------------------------------------------------
		private var _setBorder								:Boolean;






		//---------------------------------------------------
		private var _sWidth									:Number = 0;
		private var _sHeight								:Number = 0;
		private var _sPosY									:Number = 0;
		private var i												:Number = 0;
		private var _dataDistr							:Number = -1;



		//---------------------------------------------------
		private var lineArray								:Array = [];





		//---------------------------------------------------
		public function TypewriterXmlParser()
		{
			loader = new URLLoader();
			loader.addEventListener(Event.COMPLETE, onParsedXML);
			loader.addEventListener(IOErrorEvent.IO_ERROR, onIOError);
		}




		//---------------------------------------------------
		private function onIOError(e:Event):void
		{
			trace("No valid link! @TypewriterXmlParser");
		}



		//---------------------------------------------------
		public function init(_path:String):void
		{
			loader.load(new URLRequest(_path));
		}





		//---------------------------------------------------
		private function onParsedXML(e:Event)
		{
			rawXML = new XML(loader.data);

			_type_text 								= rawXML.type_text.children();
			_sWidth										= rawXML.type_text.@setWidth;
			_sHeight									= rawXML.type_text.@setHeight;
			_sPosY										= rawXML.type_text.@_setPosY;
			_dataDistr								= rawXML.type_text.@dataDistr;
			_title 										= rawXML.type_text.@title;
			_smallTitle								= rawXML.type_text.@smallTitle;
			_instruction							= rawXML.type_text.@instruction;
			_helpText									= rawXML.type_text.@help;

			if(rawXML.type_text.@setBorder == "true")
			{
				_setBorder = true;
			}
			else if(rawXML.type_text.@setBorder == "false")
			{
				_setBorder = false;
			}



			for(i = 0; i < rawXML.type_text.children().length(); i ++)
			{
				var lineString:String = rawXML.type_text.children()[i];
				lineArray.push(lineString);

			}
			//trace(lineArray)


			dispatchEvent(new Event(Event.COMPLETE, true));
		}





		//---------------------------------------------------
		public function getHelp():String
		{
			return _helpText;
		}






		//---------------------------------------------------
		public function getInstruction():String
		{
			return _instruction;
		}






		//---------------------------------------------------
		public function getTitle():String
		{
			return _title;
		}








		//---------------------------------------------------
		public function getSmallTitle():String
		{
			return _smallTitle
		}






		//---------------------------------------------------
		public function get_lineArray():Array
		{
			return lineArray;
		}




		//---------------------------------------------------
		public function get_dataDistr():Number
		{
			return _dataDistr
		}





		//---------------------------------------------------
		public function get_type_text():String
		{
			return _type_text;
		}





		//---------------------------------------------------
		public function get_setBorder():Boolean
		{
			return _setBorder;
		}










		//---------------------------------------------------
		public function get_sWidth():Number
		{
			return _sWidth;
		}





		//---------------------------------------------------
		public function get_sHeight():Number
		{
			return _sHeight;
		}





		//---------------------------------------------------
		public function get_sPosY():Number
		{
			return _sPosY;
		}
	}
}
