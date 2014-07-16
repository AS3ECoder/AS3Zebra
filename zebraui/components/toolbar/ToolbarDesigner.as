package zebraui.components.toolbar
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.geom.Rectangle;
	import zebraui.components.container.Box;
	import zebraui.components.layout.HBoxLayout;
	import zebraui.components.layout.ILayoutManager;
	import zebraui.components.layout.LayoutAlign;
	import zebraui.components.layout.LayoutMargin;
	import zebraui.components.UIComponent;
	import zebraui.UIFramework;
	import zebraui.util.Scale9GridBitmap;
	
	public class ToolbarDesigner extends UIComponent
	{
		public var backgroundSprite:Scale9GridBitmap;
		protected var boxleft:Box;
		protected var boxcenter:Box;
		protected var boxright:Box;
		private var _leftLayout:ILayoutManager;
		private var _centerLayout:ILayoutManager;
		private var _rightLayout:ILayoutManager;
		protected var backgroundBitmap:BitmapData;
		protected var backgroundRect:Rectangle;
		
		public function ToolbarDesigner(bgBitmap:BitmapData,bgBitmapRect:Rectangle,preferWidth:Number = 0, preferHeight:Number = 0)
		{
			backgroundBitmap = bgBitmap;
			backgroundRect = bgBitmapRect;
			super(preferWidth, preferHeight);
		}
		
		override protected function initialize():void
		{
			//var bmd:BitmapData = UIFramework.resource.getBitmapData("UIComponent.DefaultTheme.Toolbar.Background");
			//var rect:Rectangle = UIFramework.resource.getElementRectangle("Toolbar", "DefaultTheme");
			if(backgroundBitmap){
			backgroundSprite = new Scale9GridBitmap(backgroundBitmap, backgroundRect);
			addChild(backgroundSprite);
			backgroundSprite.width = _preferWidth;
			backgroundSprite.height = _preferHeight;}
			
			_leftLayout = new HBoxLayout();
			_leftLayout.margin = new LayoutMargin(5, 0, 5, 0);
			_leftLayout.vAlign = LayoutAlign.VAlign_CENTER;
			_leftLayout.hAlign = LayoutAlign.HAlign_LEFT;
			
			boxleft = new Box(_preferWidth, _preferHeight);
			boxleft.setLayout(_leftLayout);
			addChild(boxleft);
			
			
			
			_centerLayout = new HBoxLayout();
			_centerLayout.vAlign = LayoutAlign.VAlign_CENTER;
			_centerLayout.hAlign = LayoutAlign.HAlign_CENTER;
			boxcenter = new Box(_preferWidth, _preferHeight)
			boxcenter.setLayout(_centerLayout);
			addChild(boxcenter);
			
			
			_rightLayout = new HBoxLayout();
			_rightLayout.margin = new LayoutMargin(5, 0, 5, 0);
			_rightLayout.vAlign = LayoutAlign.VAlign_CENTER;
			_rightLayout.hAlign = LayoutAlign.HAlign_RIGHT;
			
			boxright = new Box(_preferWidth, _preferHeight);
			boxright.setLayout(_rightLayout);
			addChild(boxright);
			super.initialize();
		}
		
		override public function set width(value:Number):void
		{
		
			super.width = value;
			if(backgroundSprite){
			backgroundSprite.width = _preferWidth;
			}
			boxright.width = _preferWidth;
			boxleft.width = _preferWidth;
			boxcenter.width = _preferWidth;
		}
		
		override public function set height(value:Number):void
		{
			
			super.height = value;
			if(backgroundSprite){
			backgroundSprite.height = _preferHeight;
			}
			boxright.height = value;
			boxleft.height = value;
			boxcenter.height = value;
		}
		override public function get width():Number
		{
			return _preferWidth;
		}
		override public function get height():Number
		{
			return _preferHeight;
		}
		
		public function appendLeft(target:DisplayObject):void
		{
			boxleft.append(target);
		}
		
		public function removeLeft(target:DisplayObject):void
		{
			boxleft.remove(target);
		}
		
		
				
		public function appendCenter(target:DisplayObject):void
		{
			boxcenter.append(target);
		}
		
		public function removeCenter(target:DisplayObject):void
		{
			boxcenter.remove(target);
		}
		
		public function appendRight(target:DisplayObject):void
		{
			boxright.append(target);
		}
		
		public function removeRight(target:DisplayObject):void
		{	
			boxright.remove(target);
		}
	
		
		public function clearAll():void {
			boxleft.clear()
			boxcenter.clear();
			boxright.clear()
		}
		
	}

}