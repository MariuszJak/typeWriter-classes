package pl.mynetwork.typewriter.models
{
	
	
	
	
	//-----------------------------------------------
	import pl.mynetwork.typewriter.models._root.Model;
	import flash.display.Stage;
	import flash.display.MovieClip;
	import caurina.transitions.Tweener;
	
	
	
	
	
	
	//-----------------------------------------------
	public class KeyboardModel extends Model
	{
		
		
		
		//-----------------------------------------------
		private var _thisY					:Number = 0;
		private var _thisDistanceFromTop	:Number = 0;
		private var i						:Number = 0;
		
		
		
		
		
		//-----------------------------------------------
		private var _letterUIArray			:Array = ["q","w","e","r","t","y","u","i","o","p","a","s","d","f","g","h","j","k","l","z","x","c","v","b","n","m"]
		private var _letterBigUIArray		:Array = ["Q","W","E","R","T","Y","U","I","O","P","A","S","D","F","G","H","J","K","L","Z","X","C","V","B","N","M"]
		private var _numbersUIArray			:Array = ["1","2","3","4","5","6","7","8","9","0"];
		private var _letterAllArray			:Array = [];
		private var _letterShiftArr			:Array = [];
		private var _numbersArr				:Array = [];
		private var _fArray					:Array = [];
		
		
		
		
		
		
		//-----------------------------------------------
		private var p_stage					:Stage;
		
		
		
		
		
		//-----------------------------------------------
		public function KeyboardModel() 
		{
			
		}
		
		
		
		
		
		//-----------------------------------------------
		public function _initKeyboard(_stage:Stage)
		{
			p_stage 												= _stage;
			_setKeyboardButtons();
			_setKeyboardFingers();
		}
		
		
		
		
		
		//-----------------------------------------------
		private function _setKeyboardFingers()
		{
			_kf.visible = false;
		}
		
		
		
		
		//-----------------------------------------------
		public function toggleKeyboardFingers()
		{
			if(!_kf.visible)
			{
				_kf.visible = true;
			}
			else
			{
				_kf.visible = false;
			}
		}
		
		
		
		
		//-----------------------------------------------
		private function _setKeyboardButtons()
		{
			_space.visible 											= false;
			_dot.visible 											= false;
			_comma.visible 											= false;
			_enter.visible 											= false;
			
			
			
			
			//---------------------------------------------------
			for(i = 0; this["s_" + i] != undefined; i ++)
			{
				var _lettersShift:MovieClip 						= this["s_" + i];
				_lettersShift.visible 								= false;
				_letterShiftArr.push(_lettersShift);
			}
			
			
			
			//---------------------------------------------------
			for(i = 0; this["n_" + i] != undefined; i ++)
			{
				var _numbers:MovieClip 								= this["n_" + i];
				_numbers.visible 									= false;
				_numbers._values 									= _numbersUIArray[i];
				_numbersArr.push(_numbers);
				
			}
			
			
			
			//---------------------------------------------------
			for(i = 0; this["l_" + i] != undefined; i++)
			{
				var _letterButton:MovieClip 						= this["l_" + i];
				_letterButton._letter 								= _letterUIArray[i];
				_letterButton._bigLetter 							= _letterBigUIArray[i];
				_letterButton.visible 								= false;
				_letterAllArray.push(_letterButton);
			}
			
			
			
			//---------------------------------------------------
			for(i = 0; this["f_" + i] != undefined; i++)
			{
				var _fButton:MovieClip 								= this["f_" + i];
				_fButton.visible 									= false;
				_fArray.push(_fButton);
			}
		}
		
		
		
		
		//-----------------------------------------------
		public function getLetterByName(_name:String)
		{
			
			
			
			//-----------------------------------------------
			if(_name == ":")
			{
				_semicolon.visible 									= true;
				_semicolon.letter_next.alpha 						= 0;
				Tweener.addTween(_semicolon.letter_next, 					{alpha:1, time:.5,transition:"easeIn"});
				s_0.visible 										= true;
				s_1.visible 										= true;
				
				s_0.gotoAndStop(1);
				s_1.gotoAndStop(1);
				
				s_0.alpha 											= 0;
				s_1.alpha 											= 0;
				
				Tweener.addTween(s_0._shift, 			{alpha:1, time:.5,transition:"easeIn"});
				Tweener.addTween(s_1._shift, 			{alpha:1, time:.5,transition:"easeIn"});
			}
			
			
			
			
			
			
			//-----------------------------------------------
			if(_name == ";" || _name == ":")
			{
				_semicolon.visible 									= true;
				_semicolon.gotoAndStop(1);
				_semicolon.letter_next.alpha 						= 0;
				Tweener.addTween(_semicolon.letter_next, 					{alpha:1, time:.5,transition:"easeIn"});
				_letterShiftArr[0].visible 							= false;
				_letterShiftArr[1].visible 							= false;
			}
			else
			{
				_semicolon.visible 									= false;
				
			}
			
			
			
			
			
			//-----------------------------------------------
			if(_name == "/")
			{
				_slash.visible 										= true;
				_slash.gotoAndStop(1);
				_slash.letter_next.alpha 							= 0;
				Tweener.addTween(_slash.letter_next, 						{alpha:1, time:.5,transition:"easeIn"});
				_letterShiftArr[0].visible 							= false;
				_letterShiftArr[1].visible 							= false;
			}
			else
			{
				_slash.visible 										= false;
				
			}
			
			
			
			//-----------------------------------------------
			if(_name == " ")
			{
				_space.visible = true;
				_space.gotoAndStop(1);
				_space.alpha = 0;
				Tweener.addTween(_space, 						{alpha:1, time:.5,transition:"easeIn"});
				_letterShiftArr[0].visible 							= false;
				_letterShiftArr[1].visible 							= false;
			}
			else
			{
				_space.visible = false;
				
			}
			
			
			
			//---------------------------------------------------
			if(_name == ".")
			{
				_dot.visible = true;
				_dot.gotoAndStop(1);
				_dot.letter_next.alpha = 0;
				Tweener.addTween(_dot.letter_next, 							{alpha:1, time:.5,transition:"easeIn"});
				_letterShiftArr[0].visible 							= false;
				_letterShiftArr[1].visible 							= false;
			}
			else
			{
				_dot.visible = false;
			}
			
			
			
			
			//---------------------------------------------------
			if(_name == ",")
			{
				_comma.visible = true;
				_comma.gotoAndStop(1);
				_comma.letter_next.alpha = 0;
				Tweener.addTween(_comma.letter_next, 						{alpha:1, time:.5,transition:"easeIn"});
				_letterShiftArr[0].visible 							= false;
				_letterShiftArr[1].visible 							= false;
			}
			else
			{
				_comma.visible = false;
			}
			
			
			
			
			//---------------------------------------------------
			for(var h in _numbersArr)
			{
				if(_name == _numbersArr[h]._values)
				{
					_numbersArr[h].visible 							= true;
					_numbersArr[h].gotoAndStop(1);
					_numbersArr[h].alpha 							= 0;
					_letterShiftArr[0].visible 						= false;
					_letterShiftArr[1].visible 						= false;
					Tweener.addTween(_numbersArr[h].letter_next, 			{alpha:1, time:.5, transition:"easeIn"});
				}
				else
				{
					_numbersArr[h].visible = false;
				}
			}
			
			
			
			
			//---------------------------------------------------
			for(var f in _fArray)
			{
				if(_name == _fArray[f]._values)
				{
					_fArray[f].visible 								= true;
					_fArray[f].alpha 								= 0;
					_letterShiftArr[0].visible 						= false;
					_letterShiftArr[1].visible 						= false;
					Tweener.addTween(_fArray[f], 					{alpha:1, time:.5, transition:"easeIn"});
				}
				else
				{
					_fArray[f].visible = false;
				}
			}
			
			
			
			
			//---------------------------------------------------
			for(var k in _letterAllArray)
			{
				if(_name == _letterAllArray[k]._letter)
				{
					_letterAllArray[k].visible 						= true;
					_letterAllArray[k].gotoAndStop(1);
					_letterAllArray[k].alpha 						= 0;
					Tweener.addTween(_letterAllArray[k], 		{alpha:1, time:.5,transition:"easeIn"});
					_letterShiftArr[0].visible 						= false;
					_letterShiftArr[1].visible 						= false;
				}
				else
				{
					_letterAllArray[k].visible 						= false;
					
				}
				if(_name == _letterAllArray[k]._bigLetter)
				{
					_letterAllArray[k].visible 						= true;
					_letterAllArray[k].gotoAndStop(1);
					
					_letterShiftArr[0].visible 						= true;
					_letterShiftArr[1].visible 						= true;
					
					_letterAllArray[k].alpha 						= 0;
					
					_letterShiftArr[0].alpha 						= 0;
					_letterShiftArr[1].alpha 						= 0;
					
					Tweener.addTween(_letterAllArray[k], 			{alpha:1, time:.5,transition:"easeIn"});
					Tweener.addTween(_letterShiftArr[0], 			{alpha:1, time:.5,transition:"easeIn"});
					Tweener.addTween(_letterShiftArr[1], 			{alpha:1, time:.5,transition:"easeIn"});
				}
				
			}

		}
		
		
		
		
		//-----------------------------------------------
		public function _showEnter()
		{
			_enter.visible = true;
			_enter.gotoAndStop(1);
			_enter.alpha = 0;
			Tweener.addTween(_enter, {alpha:1, time:.5, transition:"easeIn"});
		}
		
		
		
		
		//-----------------------------------------------
		public function _hideEnter()
		{
			_enter.visible = false;
		}
		
		
		
		
		
		//-----------------------------------------------
		public function _setPositionRelative(_posY:Number,_distanceFromTop:Number)
		{
			_thisY 													= _posY;
			_thisDistanceFromTop 									= _distanceFromTop;
			this.y 													= _posY+_thisDistanceFromTop;
		}
		
		
		
		
		//-----------------------------------------------
		public function _setSizeRelative()
		{
			var _relativeHeight:Number 								= 600 - (72 + _thisY + _thisDistanceFromTop);
			var _scaleRatio:Number 									= _relativeHeight/this.height;
			
			this.scaleX = this.scaleY = _scaleRatio;
			_setPosX();
		}
		
		
		
		
		
		//-----------------------------------------------
		private function _setPosX()
		{
			var _relativeWidth:Number = p_stage.width - this.width;
			this.x = this.x + (_relativeWidth/2);
		}
		
		
		
		
		
		
		//-----------------------------------------------
		public function get_enter():MovieClip
		{
			return _enter;
		}
		
		
		
		
		
		//-----------------------------------------------
		private function correctSize()
		{
			var _correctedRatio:Number = 800/this.width;
			this.scaleX  = _correctedRatio;
		}
	}
}
