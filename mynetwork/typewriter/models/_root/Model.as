package pl.mynetwork.typewriter.models._root
{
	
	import pl.mynetwork.typewriter.parser.TypewriterXmlParser;
	import flash.display.MovieClip;
	
	
	//---------------------------------------------------
	public class Model extends MovieClip
	{
		
		
		
		//---------------------------------------------------
		protected var _parser:TypewriterXmlParser;
		
		
		

		
		//---------------------------------------------------
		public function Model() 
		{
			_parser = new TypewriterXmlParser();
		}
	}
}
