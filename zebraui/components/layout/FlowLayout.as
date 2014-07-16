package zebraui.components.layout 
{
	import flash.display.DisplayObject;
	import flash.utils.setInterval;
	import flash.utils.setTimeout;
	import zebraui.components.container.IContainer; 
 
	
	public final class FlowLayout extends LayoutManager
	{	
		private var _flowLayoutModel:Vector.<FlowLayoutModel>;
	    private var _currentRow:int = 0;
		
		
		
		 /**
		  * Flow布局  对其相对于每行
		  * @param	container  容器对象
		  * @param	valign     每行的垂直对齐
		  * @param	halign     每行的水平对齐
		  * @param	hgap       水平间隔
		  * @param	vgap       垂直间隔
		  * @param	margin     内框
		  */
		public function FlowLayout(container:IContainer=null,valign:String="valign_top",halign:String="halign_left",hgap:int=5,vgap:int=5,margin:LayoutMargin=null) 
		{
			if (container)_container = container;
			 _flex = true;
			_vAlign = valign;
			_hAlign = halign;
			 this._hgap = hgap;
			 this._vgap = vgap;	
			// this._margin = new LayoutMargin(5, 5, 5, 5);
			 
			 if(margin!=null){
				this._margin  = margin;
			}
			 _flowLayoutModel = new Vector.<FlowLayoutModel>();
		 
		}
		
		
		override public function updateAlign(valign:String = null, halign:String = null):void {
			 super.updateAlign(valign, halign);
			 if (__elements.length == 0 || _container==null) return;
			 _currentRow = 0;
			  
		     for (var i:int = 0; i < __elements.length; i++) 
			 {
				 if(i==0){
					 __elements[i].x =  _margin.left;
					 __elements[i].y =  _margin.top;
					  //一行第一个元素宽度如果大于容器宽度
					 if (__elements[i].width + this._margin.left + this._margin.right > _container.width)
					 _container.width = __elements[i].width+ this._margin.left + this._margin.right;
					 var model:FlowLayoutModel = new FlowLayoutModel();
						 model.containerWidth = this._container.width;
						 model.margin = _margin;
						 model.row = _currentRow;
						 model.cmpList.push(__elements[i]);
					 _flowLayoutModel.push(model);
				 }else{ 
					 
					 __elements[i].x =  __elements[i - 1].x + __elements[i - 1].width + this.hgap ;
					 __elements[i].y =  __elements[i - 1].y;
					 
					 //换行判断
					 if (__elements[i].x + __elements[i].width  + this.hgap > this._container.width-_margin.right) {
						
						     _currentRow++;
							  var newRowModel:FlowLayoutModel = new FlowLayoutModel();
								  newRowModel.containerWidth = this._container.width;
								  newRowModel.margin = _margin;
								  newRowModel.row = _currentRow;
								  newRowModel.cmpList.push(__elements[i]);
							 _flowLayoutModel.push(newRowModel);
							 
							 __elements[i].x =  _margin.left;
							 __elements[i].y =  _flowLayoutModel[_currentRow - 1].cmpList[0].y + _flowLayoutModel[_currentRow - 1].maxHeight + this.vgap;
							 
							 //一行第一个元素宽度如果大于容器宽度
							  if (__elements[i].width + this._margin.left + this._margin.right > _container.width)
								  _container.width = __elements[i].width + this._margin.left + this._margin.right;
					    }else {						
							_flowLayoutModel[_currentRow].cmpList.push(__elements[i]);
						}
				 }
			 }
			 
			 
			 for each (var FLmodel:FlowLayoutModel in _flowLayoutModel) 
			 {
				 FLmodel.valign(this._vAlign);
				 FLmodel.halign(this._hAlign);
				 FLmodel.offX(_offx)
				 FLmodel.offY(_offy)				 
			 }
			 
			if (_flowLayoutModel.length > 0) {
				var maxElement:DisplayObject = _flowLayoutModel[_flowLayoutModel.length - 1].maxHeightElement;
			    _preferHeight = maxElement.height+ maxElement.y + _margin.bottom;
			}
			_flowLayoutModel = new Vector.<FlowLayoutModel>();

		}
		
		override public function set offX(value:Number):void 
		{
			this._offx = value;
			updateAlign(_vAlign, _hAlign);
		}
		
		override public function set offY(value:Number):void 
		{
			this._offy = value;
			updateAlign(_vAlign, _hAlign);
		}
		
		
		
		override public function setPreferWidth(value:Number):void 
		{
			super.setPreferWidth(value);
			_preferWidth = value;
		}
		
		override public function clear():void 
		{
			super.clear();
			_preferHeight =  _margin.top+ _margin.bottom;
		}
		
	}
	
}




import flash.display.DisplayObject;
 
import zebraui.components.layout.LayoutAlign;
import zebraui.components.layout.LayoutMargin;

internal  class FlowLayoutModel {
	    public var  containerWidth:Number;
		public var  margin:LayoutMargin;
		public var  row:int;
		public var  cmpList:Vector.<DisplayObject> = new Vector.<DisplayObject>();
		
		public function get maxHeightElement():DisplayObject {
			   var _height:Number = 0;
			   var _target:DisplayObject;
			   for each (var cmp:DisplayObject in cmpList) 
			   {
				   if (cmp.height > _height){
				   _height = cmp.height;
				   _target = cmp;
				   }
			   }
			   return _target;
			}
		
		public function  get  maxHeight():Number {
			  var _height:Number = 0;
			   for each (var cmp:DisplayObject in cmpList) 
			   {
				   if (cmp.height > _height)
				   _height = cmp.height;
			   }
			   return _height;
			}
			
			
		public function valign(value:String):void {
			var element:DisplayObject;
			var _maxHeightelement:DisplayObject  = maxHeightElement;
			switch(value) {
				  case LayoutAlign.VAlign_TOP:
					   for each ( element in cmpList) 
					   {
						   if(element!=_maxHeightelement){
						   element.y = _maxHeightelement.y;
						   }
					   }
					  break;
				   case LayoutAlign.VAlign_CENTER:
					   for each ( element in cmpList) 
					   {
							if(element!=_maxHeightelement){
							element.y = _maxHeightelement.y + _maxHeightelement.height/2-element.height/2;
							}
					   }
					  break;
				   case LayoutAlign.VAlign_BOTTOM:
					   for each ( element in cmpList) 
					   {
						   if(element!=_maxHeightelement){
							 element.y = _maxHeightelement.y + _maxHeightelement.height - element.height;
						   }
					   }
					  break;
				  
				}
			}	
		 
			public function halign(value:String):void {
				    
					var i:int = 0;
					var changevalue:Number = 0;
					switch(value) {
						  case LayoutAlign.HAlign_LEFT:
							   for (i = 0; i <cmpList.length ; i++) 
							   {
								 if (i == 0) {
									  changevalue =  cmpList[i].x - margin.left
									  cmpList[i].x += changevalue;
									 }else {
									  cmpList[i].x += changevalue;
									 }
							   }
							  break;
						   case LayoutAlign.HAlign_CENTER:
							  var  rowContentWidth:Number =  cmpList[cmpList.length - 1].x + cmpList[cmpList.length - 1].width-cmpList[0].x ;
							   if (cmpList.length == 1) rowContentWidth =  cmpList[0].width;
							   var  innerWidth:Number = containerWidth - this.margin.left - this.margin.right;
							   changevalue = (innerWidth-rowContentWidth)*.5
							    for (i = 0; i <cmpList.length ; i++) 
							    {
								    cmpList[i].x += changevalue;
								}
							  break;
						   case LayoutAlign.HAlign_RIGHT:
							   for (i = cmpList.length-1; i >=0 ; i--) 
							   {
								 if (i == cmpList.length-1) {
									  changevalue = containerWidth - margin.right - (cmpList[i].x + cmpList[i].width);
									  cmpList[i].x += changevalue;
									 }else {
									  cmpList[i].x += changevalue;
									 }
							   }
							  break;
						  
						}
				}
				public function offX(value:Number):void { 
								  for each ( var element:DisplayObject in cmpList) 
									   {
										   element.x +=value
									   } 
							
							}
				public function offY(value:Number):void { 
							  for each ( var element:DisplayObject in cmpList) 
								   {
									   element.y +=value
								   } 
						}
	}

	
