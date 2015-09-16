package pl.mynetwork.typewriter.models
{
	import pl.mynetwork.typewriter.models._root.Model;
	import pl.mynetwork.typewriter.Cmd;
	import flash.events.Event;
	import pl.mynetwork.typewriter.parser.TypewriterXmlParser;
	import pl.mynetwork.typewriter.event.DataComplete;
	import pl.mynetwork.typewriter.utils.TimeManagement;
	import flash.display.MovieClip;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	import flash.display.Stage;
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	
	
	
	
	public class ScreenModel extends Model
	{
		
		
		
		
		//---------------------------------------------------
		private static var _screenContainer			:MovieClip;
		
		
		
		
		//---------------------------------------------------
		private var _timer							:Timer;
		
		
		
		
		
		
		//---------------------------------------------------
		private var parsedData						:String = "";
		
		
		
		
		
		
		//---------------------------------------------------
		private var posY							:Number = 0;
		
		private var _oneLineDataLength				:Number = 0; 
		private var _numberOfObjects				:Number = 0;
		private var i								:Number = 0;
		private var _typeSuccessRate				:Number = 0;
		private var _dataLenght						:Number = 0;
		private var _errorsInTyping					:Number = 0;
		private var _typeDynamicPercentage			:Number = 0;
		private var _progress						:Number = 0;
		private var _typeSpeedTrsh					:Number = 0;
		private var _typedAllLetters				:Number = 0;
		private var _screenContainerHeight			:Number = 0;
		
		
		
		
		
		
		//---------------------------------------------------
		private var objectArr						:Array = [];
		private var _wordArr						:Array = [];
		private var _iterateFullNumberArr			:Array = [];
		
		
		
		
		
		//---------------------------------------------------
		private var _instructionData				:String;
		
		
		
		
		
		
		//---------------------------------------------------
		public static var _objIndex					:Number = 0;
		public static var UPDATE_TEXT				:Boolean = true;
		
		
		
		
		
		
		
		
		
		
		
		//---------------------------------------------------
		public function ScreenModel() 
		{
			
			if(!stage)addEventListener(Event.ADDED_TO_STAGE, _init);
			else _init();
			
		}

		
		
		
		
		//---------------------------------------------------
		private function _init(event:Event = null):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, _init);
			
			super._parser = new TypewriterXmlParser();
			super._parser.init(Cmd.XML_PATH);
			super._parser.addEventListener(Event.COMPLETE, onLoadParsedXML);
		}

		
		
		
		//---------------------------------------------------
		public function onSetNextObject(_stage:Stage):void
		{
			if(_objIndex < objectArr.length-1)
			{
				_objIndex ++;
				_stage.focus = objectArr[_objIndex].iTxt;
			}
		}
		
		
		
		
		
		//---------------------------------------------------
		public function onSetPrevObject(_stage:Stage):void
		{
			if(_objIndex > 0)
			{
				_objIndex --;
				_stage.focus = objectArr[_objIndex].iTxt;
				objectArr[_objIndex].eraseLetter(_objIndex);
			}
		}
		
		
		
		
		//---------------------------------------------------
		private function onLoadParsedXML(e:Event):void
		{
			if(super._parser.get_dataDistr() == 1)
			{
				parsedData 							= super._parser.get_type_text();
			}
			else
			{
				parsedData 							= this.arrayToString(super._parser.get_lineArray());
				trace(parsedData.length);
			}
			
			_timer 									= new Timer(1000,9999);
			_timer.addEventListener(TimerEvent.TIMER, onShowTime);
			_timer.start();
			
			distributeData(parsedData);
			_instructionData = super._parser.getInstruction();
			Cmd.getAppHeaderController().updateData(super._parser.getTitle(), super._parser.getSmallTitle());
		}
		
		
		
		
		
		
		//---------------------------------------------------
		private function arrayToString(_arr:Array):String
		{
			var combinedString:String = "";
			for(i = 0; i < _arr.length; i ++)
			{
				combinedString = combinedString + _arr[i].toString();
			}
			return combinedString;
		}
		
		
		
		
		
		//---------------------------------------------------
		private function distributeData(_data:String):void
		{
			var _iterate:Number 							= 0;

			
			_dataLenght 									= _data.length;
			_oneLineDataLength 								= Cmd.getUtils().calculateLenght(super._parser.get_sWidth(),9.3);
			_numberOfObjects 								= Math.round(_dataLenght / _oneLineDataLength);
			
			for(i = 0; i < _numberOfObjects; i ++)
			{
				_iterateFullNumberArr.push(_oneLineDataLength);
			}
			
			if(_dataLenght % _oneLineDataLength > 0)
			{
				_numberOfObjects 							= _numberOfObjects + 1;
				_iterateFullNumberArr.push(_dataLenght % _oneLineDataLength);
			}
			
			for(i = 0; i < _numberOfObjects; i ++)
			{
				var _inputString:String = "";
				for(var j:Number = 0; j < Math.round(_iterateFullNumberArr[i]); j ++)
				{
					_inputString = _inputString + _data.charAt(_iterate);
					_iterate ++;
				}
				_wordArr.push(_inputString);
			}
			
			
			_screenContainer				       			= new screenContainer();
			this.addChild(_screenContainer);

			_screenContainer.y								= super._parser.get_sPosY();
			_screenContainer.screenContainerBody.width 		= super._parser.get_sWidth();
			_screenContainer.screenContainerBody.height 	= super._parser.get_sHeight();
			
			_screenContainer.maskContainerForText.width 	= super._parser.get_sWidth();
			_screenContainer.maskContainerForText.height 	= super._parser.get_sHeight();
			
			_screenContainerHeight 							= super._parser.get_sHeight();
			trace(_screenContainerHeight)
			
			
			if(super._parser.get_dataDistr() == 1)
			{
				distr_singleLine();
			}
			else
			{
				distr_multileLine();
			}
			
		}
		
		
		
		
		
		//---------------------------------------------------
		private function distr_singleLine()
		{
			for(i = 0; i < _numberOfObjects; i ++)
			{
				var _objectInLine:MovieClip 					= new mainInputText();
				objectArr.push(_objectInLine);
				
				_objectInLine.y = posY;
				
				_screenContainer.containerForText.addChild(_objectInLine);
				_objectInLine._border(super._parser.get_setBorder());
				_objectInLine.set_id(i);
				_objectInLine._setY(posY);
				_objectInLine._setContainerHeight(_screenContainer.screenContainerBody.height);
				_objectInLine.addListenerToTextfields();
				_objectInLine._setMaxChar(_iterateFullNumberArr[i]);
				_objectInLine.setInlineText(_wordArr[i]);
				_objectInLine._setWidth(super._parser.get_sWidth());
				posY = posY + _objectInLine.height;
			}
			stage.focus = objectArr[0].iTxt;
			Cmd.getAppController()._configureKeyboard(_screenContainerHeight,super._parser.get_sPosY());
		}
		
		
		
		
		
		
		
		//---------------------------------------------------
		private function distr_multileLine()
		{
			for(i = 0; i < super._parser.get_lineArray().length; i ++)
			{
				var _objectInLine:MovieClip 					= new mainInputText();
				objectArr.push(_objectInLine);
				
				_objectInLine.y = posY;
				
				_screenContainer.containerForText.addChild(_objectInLine);
				_objectInLine._border(super._parser.get_setBorder());
				_objectInLine.set_id(i);
				_objectInLine._setY(posY);
				_objectInLine._setContainerHeight(_screenContainer.screenContainerBody.height);
				_objectInLine.addListenerToTextfields();
				_objectInLine._setMaxChar(super._parser.get_lineArray()[i].length);
				_objectInLine.setInlineText(super._parser.get_lineArray()[i]);
				_objectInLine._setWidth(super._parser.get_sWidth());
				posY = posY + _objectInLine.height;
			}
			stage.focus = objectArr[0].iTxt;
			Cmd.getAppController()._configureKeyboard(_screenContainerHeight,super._parser.get_sPosY());
		}
		
		
		
		
		//---------------------------------------------------
		private function onShowTime(e:TimerEvent):void
		{
			this.encodeTime(_timer.currentCount);
			Cmd.getDisplayDataControler().get_displayDataView().updateTime(encodeTime(_timer.currentCount));
		}
		
		
		
		
		
		//---------------------------------------------------
		public function get_instructionData():String
		{
			return _instructionData;
		}
		
		
		
		
		//---------------------------------------------------
		public function get_screenContainerHeight():Number
		{
			return _screenContainerHeight;
		}
		
		
		
		
		//---------------------------------------------------
		public function get_timerCurrentCount():Number
		{
			return _timer.currentCount;
		}
		
		
		
		
		
		//---------------------------------------------------
		public function _stopTimer():void
		{
			_timer.stop();
		}
		
		
		
		
		//---------------------------------------------------
		public function moveScreenContainer(_y:Number):void
		{
			_screenContainer.containerForText.y += _y;
		}
		
		
		
		
		
		//---------------------------------------------------
		public function getObjectArray():Array
		{
			return objectArr;
		}
		
		
		
		
		
		//---------------------------------------------------
		public function getParsedData():String
		{
			return parsedData;
		}
		
		
		
		
		//---------------------------------------------------
		public function get_typedAllLetters():Number
		{
			return _typedAllLetters;
		}
		
		
		
		
		//---------------------------------------------------
		public function set_typedAllLetters(_n:Number)
		{
			_typedAllLetters = _n;
		}
		
		
		
		
		//---------------------------------------------------
		public function get_typeSpeedTrsh():Number
		{
			return _typeSpeedTrsh;
		}
		
		
		
		
		//---------------------------------------------------
		public function set_typeSpeedTrsh(_n)
		{
			_typeSpeedTrsh = _n;
		}
		
		
		
		//---------------------------------------------------
		public function get_errorsInTyping():Number
		{
			return _errorsInTyping
		}
		
		
		
		
		//---------------------------------------------------
		public function set_errorsInTyping(_n:Number):void
		{
			_errorsInTyping = _n;
		}
		
		
		
		
		//---------------------------------------------------
		public function get_dataLenght():Number
		{
			return _dataLenght;
		}
		
		
		
		
		//---------------------------------------------------
		public function encodeTime(_time:Number):String
		{
			//trace(Cmd.getTimeManagement().secondsToTimecode(_time));
			return Cmd.getTimeManagement().secondsToTimecode(_time);
		}
		
		
		
		
		
		//---------------------------------------------------
		public function calculateErrorMargin(_allLetters:Number, _typedWrong:Number):Number
		{
			//trace("100/" + (100-Math.round(_typeSuccessRate)));
			return _typeSuccessRate = Cmd.getUtils().returnValuePercentage(_typedWrong,0,_allLetters);
			
		}
		
		
		
		
		//---------------------------------------------------
		public function calculateDynamicErrorRange(_typedLetters:Number, _typedWrong:Number):Number
		{
			//trace(_typedLetters,_typedWrong);
			return _typeDynamicPercentage = Math.round(Cmd.getUtils().returnValuePercentage(_typedWrong,0,_typedLetters+1));
			
		}
		
		
		
		
		
		//---------------------------------------------------
		public function calculateProgress(_typedLetters:Number,_allLetters:Number):Number
		{
			//trace(_typedLetters,_allLetters);
			return _progress = Math.round(Cmd.getUtils().returnValuePercentage(_typedLetters,0,_allLetters));
			
		}
		
		
		
		
		//---------------------------------------------------
		public function calculateTypingSpeedPerMinute(_typedLetters:Number, _actualTime:Number):Number
		{
			//trace("_typedLetters: " + _typedLetters/5,Cmd.getUtils().returnValuePercentage(_actualTime,0,60)/10);
			return (Math.round((_typedLetters) / (Cmd.getUtils().returnValuePercentage(_actualTime,0,60)/10))*60)/5;
		}
		
	}	
}
