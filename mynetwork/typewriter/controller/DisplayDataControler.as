package pl.mynetwork.typewriter.controller
{
	import flash.display.Stage;
	import pl.mynetwork.typewriter.Cmd;
	import pl.mynetwork.typewriter.controller._root.Controler;
	import pl.mynetwork.typewriter.view.DisplayDataView;
	import flash.display.MovieClip;
	import flash.events.MouseEvent;

	public class DisplayDataControler extends Controler
	{


		//-----------------------------------------------
		private static var p_stage:Stage;




		//-----------------------------------------------
		private var _displayDataView:DisplayDataView;




		//-----------------------------------------------
		private var _displayDataContainer:MovieClip;





		//-----------------------------------------------
		private var posX:Number = 0;





		private var _elementsArray:Array;




		//-----------------------------------------------
		public function DisplayDataControler()
		{

		}





		//-----------------------------------------------
		public function _initControler(_stage:Stage):void
		{
			p_stage = _stage;

			_displayDataView = new DisplayDataView();
			_displayDataContainer = new displayDataContainer();
		}




		//-----------------------------------------------
		public function _startControler():void
		{
			prepareUI();
			initUI(Cmd.DISPLAY_DATA_CATEGORY);

		}





		//-----------------------------------------------
		public function updateDisplayControler(_a:Number,_b:Number,_c:Number,_d:Number):void
		{
			_displayDataView.updateViewArray(_a,_b,_c,_d);
		}





		//-----------------------------------------------
		private function prepareUI():void
		{
			Cmd.APP_MAIN_CONTAINER.addChild(_displayDataContainer);

			_displayDataContainer.x = 0;
			_displayDataContainer.y = p_stage.height - _displayDataContainer.height;
			_displayDataContainer.dd_background.width = p_stage.width;
			_elementsArray = new Array();

			setUIButtons();
		}





		//-----------------------------------------------
		private function setUIButtons()
		{
			_displayDataContainer.btn_0.addEventListener(MouseEvent.CLICK, onShowKeyboardFingers);
			_displayDataContainer.btn_1.addEventListener(MouseEvent.CLICK, onShowInstruction);
			_displayDataContainer.btn_2.addEventListener(MouseEvent.CLICK, onShowHelp);
			_displayDataContainer.btn_3.addEventListener(MouseEvent.CLICK, onClick);
		}



		//-----------------------------------------------
		private function onShowInstruction(e:MouseEvent):void
		{
			Cmd.getInstructionModule()._initInstruction(Cmd.getScreenModel_().get_instructionData());
		}



		//-----------------------------------------------
		private function onShowHelp(e:MouseEvent):void
		{
			Cmd.getInstructionModule()._initInstruction(Cmd.getScreenModel_().get_helpData());
		}




		//-----------------------------------------------
		private function onShowKeyboardFingers(e:MouseEvent):void
		{
			Cmd.getKeyboardController().getKeyboardModel().toggleKeyboardFingers();
		}




		//-----------------------------------------------
		private function onClick(e:MouseEvent):void
		{
			trace("click")
		}





		//-----------------------------------------------
		private function initUI(_iterations:Number):void
		{
			for(var i:Number = 0; i < _iterations; i ++)
			{
				var _displayData:MovieClip = new displayData();
				_displayDataContainer.addChild(_displayData);

				_displayData.setBorder(false);
				_displayData.setType(Cmd.UI_OBJECT_LIST[i])
				_displayData.x = Cmd.UI_POS_X[i];
				_displayData.y = Cmd.UI_POS_Y[i];
				posX = posX + _displayData.width;
				_elementsArray.push(_displayData);
			}
			_displayDataView._displayArray(_elementsArray);
		}





		//-----------------------------------------------
		public function get_displayDataView():DisplayDataView
		{
			return _displayDataView;
		}
	}
}
