package pl.mynetwork.typewriter.utils 
{
	import flash.text.TextField;
	
	public class Utils 
	{

		
		//---------------------------------------------------
		private var i							:Number = 0;
		
		
		
		
		
		//---------------------------------------------------
		public function Utils() 
		{
			
		}
		
		
		
		
		
		//---------------------------------------------------
		public function calculateLenght(_width:Number, _singleLetter:Number):Number
		{
			var calculatedWidth:Number = 0;
			calculatedWidth = _width/_singleLetter;
			return Math.round(calculatedWidth);
		}
		
		
		
		
		
		
		//---------------------------------------------------
		public function renderHtmlText(_text:String, _state:String):String
		{
			var outputString:String;
			//trace(_text)
			if(_state == "_good")
			{
				outputString = '<font color="#0000ff">' + _text + '</font>'
				 
			}
			if(_state == "_bad")
			{
				outputString = '<font color="#ff0000">' + _text + '</font>'
				 
			}
			return outputString;
		}
		
		
		
		
		
		
		//---------------------------------------------------
		public function rewriteOverlayText (_textField_source:TextField,
											_textField_replace:TextField, 
											_textfield_appr:TextField, 
											_overlayTxt:String):String
		{
			var _repStr:String = "";
			for(i = 0; i < _textfield_appr.text.length-1; i ++)
			{
				if(_textfield_appr.text.charAt(i) == _textField_source.text.charAt(i))
				{
					_repStr = _repStr + this.renderHtmlText(_textfield_appr.text.charAt(i),"_good");
				}
				else
				{
					_repStr = _repStr + this.renderHtmlText(_textfield_appr.text.charAt(i),"_bad");
				}
			}
			return _repStr;
		}

		
		
		
		
		//---------------------------------------------------
		public function returnValuePercentage( _value:Number, min:Number, max:Number ):Number
		{
			return ((( _value - min ) / ( max - min )) * 100 );
		}
	}
}
