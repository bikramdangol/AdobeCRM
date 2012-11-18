package components.containers
{
	import flash.display.DisplayObject;
	import flash.events.MouseEvent;
	
	import flashx.textLayout.formats.Direction;
	
	import mx.core.DragSource;
	import mx.core.IUIComponent;
	import mx.core.IVisualElement;
	import mx.core.UIComponent;
	import mx.core.UIComponentCachePolicy;
	import mx.events.CloseEvent;
	import mx.events.DragEvent;
	import mx.events.ResizeEvent;
	import mx.managers.DragManager;
	
//	import org.osmf.events.GatewayChangeEvent;
	
	import spark.components.ResizeMode;
	import spark.components.TileGroup;
	
	public class DragDropTileGroup extends TileGroup
	{
		protected var tilesPerRow:Number = 3;
		protected var tilesPerColumn:Number = 3;
		
		protected var tileWidth:Number = 400;
		protected var tileHeight:Number = 270;
		
		protected var indexOfDragged : int;
		
		protected var childDragged : Boolean = false;
		
		// Stores the visual feedback given to
		// the user when dragging
		
		protected var visualFeedback : UIComponent;
		
		// These variables are used in the measure
		// method to define the cell size per child,
		// each cell being assigned an index in the
		// cell grid
		
		protected var cellWidth : Number = 400;
		protected var cellHeight : Number = 270;
		
		protected var sumWidthPadding : Number;
		protected var sumHeightPadding : Number;
		protected var borderSize : Number;
		
		private var _label:String;
		
		public function set label(s:String):void
		{
			this._label = s;
		}
		
		public function get label():String
		{
			return _label;
		}
		
		public function DragDropTileGroup()
		{
			super();
			
			x = 0;
			y = 0;
			
			requestedColumnCount = 3;
			requestedRowCount = 2;
			orientation = "rows";
			columnWidth = 400;
			rowHeight = 270;
			horizontalGap = 10;
			verticalGap = 10;
			
			addEventListener(DragEvent.DRAG_ENTER, dragEnterHandler);
			addEventListener(DragEvent.DRAG_DROP, dragDropHandler);
			
			addEventListener( DragEvent.DRAG_EXIT , dragExitHandler , false , 0 , true );
			addEventListener( DragEvent.DRAG_OVER , dragOverHandler , false , 0 , true );
			
		}
		
		override public function addElementAt(element:IVisualElement, index:int) : IVisualElement
		{
			var tempChild : IVisualElement = super.addElementAt( element , index );
			
			tempChild.addEventListener( MouseEvent.MOUSE_DOWN , elementMouseDownHandler , false , 0 , true );
			
			return tempChild;
		}
		
		protected function elementMouseDownHandler(event:MouseEvent):void 
		{
			if ( !event )
			{
				return;
			}
			
			var target : DisplayObject = DisplayObject( event.currentTarget );
			
			// Seeing how at this point the user's mouse interaction may be a drag or click,
			// we add listeners for a move and a mouse up. If the mouse up occurs before the
			// mouse move, it is registered as a mouse click. Alternatively, if the mouse is moved
			// before being released, it is registered as a mouse drag.
			//
			// Adding these two listeners lets us watch for these two distinct events.
			
			target.addEventListener( MouseEvent.MOUSE_UP , elementMouseUpHandler , false , 0 , true );
			target.addEventListener( MouseEvent.MOUSE_MOVE , elementMouseMoveHandler , false , 0 , true );
		}
		
		
		/**
		 * This method sets the child up to be dragged, creates a green sprite for a drag proxy, and adds the current
		 * target in the data source for the DragDropTile to access on a drop.
		 *
		 * The listener to this handle is originally set when the user triggers a MOUSE_DOWN event over a child
		 * of the DragDropTileGroup component. This handler signifies a drag of the component.
		 *
		 * @param event
		 *
		 */
		protected function elementMouseMoveHandler( event : MouseEvent ) : void
		{
			if ( !event )
			{
				return;
			}
			
			var target : UIComponent = UIComponent( event.currentTarget );
			
			if ( target.hasEventListener( MouseEvent.MOUSE_UP ))
			{
				target.removeEventListener( MouseEvent.MOUSE_UP , elementMouseUpHandler );
			}
			
			if(target){
				
			}
			
			// We indicate that it is a child of the container being dragged,
			// and store its index.
			// This is needed for the logic in our findIndex method.
			
			childDragged = true;
			indexOfDragged = getElementIndex( target );
			
			var dragProxy : UIComponent = createDragProxy( target );
			
			var ds : DragSource = new DragSource();
			
			DragManager.doDrag( target as UIComponent , ds , event , dragProxy , 0 , 0 , .5 );
			
			target.addEventListener( DragEvent.DRAG_COMPLETE , dragCompleteHandler , false , 0 , true );
		}
		
		/**
		 * Monitors the movement of the component being dragged over the DragDropTileGroup component so as to
		 * update the visual feedback display to the user.
		 *
		 * @param event
		 *
		 */
		protected function dragOverHandler( event : DragEvent ) : void
		{
			var dragInitiator : UIComponent;
			
			if ( !event )
			{
				return;
			}
			
			dragInitiator = UIComponent( event.dragInitiator );
			
			// If the dragged component is in fact a child of the container,
			// it is removed from the layout and set as invisible. This is
			// to then allow the visual feedback to simulate the dragging of
			// that component from its current location.
			
			if ( this.contains( dragInitiator ))
			{
				dragInitiator.visible = false;
				dragInitiator.includeInLayout = false;
			}
			
			var indexAt : Number;
			
			// Find the index location in the container's cell grid where
			// the mouse is currently located relative to the container.
			
			indexAt = findIndex( this.contentMouseX , this.contentMouseY );
			
			// Use this index as the location of the visualFeedback,
			// thereby giving the user indication of where the dragged 
			// component would be placed relative to the other children
			// in the container.
			
			showFeedback( indexAt , dragInitiator );
			
		}
		
		/**
		 * Handles a mouse click and removes the listener for a MOUSE_MOVE event as we are not dragging.
		 *
		 * @param event
		 *
		 */
		protected function elementMouseUpHandler( event : MouseEvent ) : void
		{
			var curTarget : DisplayObject;
			
			if ( event && event.currentTarget )
			{
				curTarget = event.currentTarget as DisplayObject;
				
				// Remove this listener and the mouseMove listener added on the mouseDown event
				// handler. These listeners, used to determind the mouse action, are no longer
				// required as it is apparent that this is a mouseClick action.
				
				curTarget.removeEventListener( MouseEvent.MOUSE_MOVE , elementMouseMoveHandler );
				curTarget.removeEventListener( MouseEvent.MOUSE_UP , elementMouseUpHandler );  				
			}
		}
		
		/**
		 * Checks to see if the object being dropped onto the container is one of its
		 * own children, accepting if so. This container is made to only allow the
		 * rearranging of its children, so it does not accept the dragged component
		 * otherwise.
		 * 
		 * @param event
		 *
		 */
		protected function dragEnterHandler( event : DragEvent ) : void
		{
			if ( !event )
			{
				return;
			}
			
			var dropTarget : DragDropTileGroup = event.target as DragDropTileGroup;
			
			// Accept the dragged component if it is
			// a child of this container
			
			if ( this.contains( event.dragInitiator as DisplayObject ))
			{
				DragManager.acceptDragDrop( dropTarget );
			}
		}
		
		protected function dragDropHandler(event:DragEvent):void 
		{
			if ( !event )
			{
				return;
			}
			
			var target : UIComponent = UIComponent( event.dragInitiator );
			
			// Find the current index the mouse is at in the container's cell grid
			
			var indexAt : Number = findIndex( this.contentMouseX , this.contentMouseY );
			
			// If the dropped component is a child of the container,
			// change the index of the component within the container
			// and remove the visual feedback representing the location
			// of that component while dragging.
			
			if ( target && contains( target ))
			{
				setElementIndex( target , indexAt );
				removeFeedback();
			}
			
			target.invalidateDisplayList();
		}
		
		protected function findIndex( x_Point : Number , y_Point : Number ) : Number
		{
			// These variables store the gap between children on the X and Y coordinates
			var tileXGap : Number = sumWidthPadding + borderSize;
			var tileYGap : Number = sumHeightPadding + borderSize;
			
			// These variables store the calculated row and column on which the mouse pointer is located.
			// The calculation is done by dividing the current position of the mouse by the size allocated to
			// the width and height of each tile and its associated border(s) 
			var onRow : int = y_Point / ( cellHeight + tileYGap );
			var onColumn : int = x_Point / ( cellWidth + tileXGap + 10 );
			
			// The index on which the mouse is located, based on the row and column calculations
			var mouseIndex : int = onRow * ( tilesPerRow ) + onColumn;
			
			// This is to compensate for the case where the dragged object is a child of the container and
			// is set to false on both includeInLayout and Visible.
			if ( childDragged && !isNaN( indexOfDragged ) && indexOfDragged <= mouseIndex )
			{	
				mouseIndex += 1;
			}
			
			// This ensures that we don't get an out of bounds exception when the mouse is in a row and column pair
			// where there is no child.
			if ( numElements == 0 )
			{
				mouseIndex = 0;
			}
			else if ( mouseIndex >= numElements )
			{
				mouseIndex = numElements - 1;
			}
			
			return mouseIndex;
		}
		
		/**
		 * Shows a dotted line drawing box at the index where the dragged item is to be placed.
		 *
		 * @param indexAt
		 * @param di
		 *
		 */
		protected function showFeedback( indexAt : int , di : UIComponent ) : void
		{
			if ( !di || isNaN( indexAt ))
				return;
			
			// Set the feedback's size to the same as the drag initiator's
			var vfWidth : Number = Math.max( di.width , cellWidth );
			var vfHeight : Number = Math.max( di.height , cellHeight );
			
			drawVisualFeedback( vfWidth , vfHeight );
			
			if ( contains( visualFeedback ))
			{
				if (( getElementIndex( visualFeedback ) == indexAt ))
				{
					return;
				}
				
				setElementIndex( visualFeedback , indexAt );
			}
			else
			{
				addElementAt( visualFeedback , indexAt );
			}
			
		}
		
		protected function drawVisualFeedback( visualWidth : Number , visualHeight : Number ) : void
		{
			// Create visual feedback if it does not exist
			if ( !visualFeedback )
			{
				visualFeedback = new UIComponent();
			}
			
			if ( visualFeedback.width != visualWidth && visualFeedback.height != visualHeight ){
				
				// Set the width and height values of the feedback to the ones passed in
				
				visualFeedback.width = visualWidth;
				visualFeedback.height = visualWidth;
				
				// Draw and create the drag proxy.
				
				visualFeedback.graphics.clear();
				visualFeedback.graphics.lineStyle( 1 , 0x000000 , 1 , true , "normal" , null , null , 3 );
				visualFeedback.graphics.beginFill( 0x00FF00 , 1 );
				visualFeedback.graphics.drawRoundRect( 0 , 0 , visualWidth * 0.9 , visualWidth * 0.9 , 15 );
				visualFeedback.graphics.endFill();
			}
		}
		
		/**
		 * Creates a UIComponent as a dragProxy for the drag event.
		 *
		 * @param passedWidth
		 * @param passedHeight
		 * @return
		 *
		 */
		protected function createDragProxy( passedComponent : UIComponent ) : UIComponent
		{
			// Creates a green rounded rectangular component to be used as the drag proxy.
			
			var greenBlock : UIComponent = new UIComponent();
			
			// Set the width and height to the same as the component you want to create a
			// drag proxy for.
			
			greenBlock.width = passedComponent.width;
			greenBlock.height = passedComponent.height;
			
			// Draw and create the drag proxy.
			
			greenBlock.graphics.clear();
			greenBlock.graphics.lineStyle( 1 , 0x000000 , 1 , true , "normal" , null , null , 3 );
			greenBlock.graphics.beginFill( 0x00FF00 , 1 );
			greenBlock.graphics.drawRoundRect( 0 , 0 , passedComponent.width * 0.9 , passedComponent.height * 0.9 , 15 );
			greenBlock.graphics.endFill();
			
			return greenBlock;
		}	
		
		/**
		 * Checks to see if the visual feedback exists and if it is a child of this container,
		 * removing it if so.
		 *
		 */
		protected function removeFeedback() : void
		{
			// Check to see if the visualFeedback exists and if it is a child of this container
			
			if ( visualFeedback != null )
			{
				removeElement( visualFeedback );
				visualFeedback = null;
			}
			
		}
		
		/**
		 * Calls the removeFeedback() method to remove the visual feedback upon exit of the mouse drag
		 * from the container.
		 * 
		 * @param event
		 *
		 */
		protected function dragExitHandler( event : DragEvent ) : void
		{
			removeFeedback();
		}
		
		/**
		 * Finds the max cell width and height of the tile components and sets internal variables to these values.
		 *
		 */
		protected function findCellSize() : void
		{
			// If user explicitly supplied both a tileWidth and
			// a tileHeight, then use those values.
			var widthSpecified : Boolean = !isNaN( tileWidth );
			var heightSpecified : Boolean = !isNaN( tileHeight );
			
			if ( widthSpecified && heightSpecified )
			{
				cellWidth = 400;
				cellHeight = 270;
				return;
			}
			
			// Reset the max child width and height
			
			var maxChildWidth : Number = 0;
			var maxChildHeight : Number = 0;
			
			// Loop over the children to find the max child width and height.
			
			var n : int = numElements;
			
			for ( var i : int = 0 ; i < n ; i++ )
			{
				var child : IUIComponent = IUIComponent( getElementAt( i ));
				
				// If the child is not included in the layout, skip to the
				// next iteration of the loop
				
				if ( !child.includeInLayout )
					continue;
				
				var width : Number = child.getExplicitOrMeasuredWidth();
				
				if ( width > maxChildWidth )
					maxChildWidth = width;
				
				var height : Number = child.getExplicitOrMeasuredHeight();
				
				if ( height > maxChildHeight )
					maxChildHeight = height;
			}
			
			// If user explicitly specified either width or height, use the
			// user-supplied value instead of the one we computed.
			cellWidth = widthSpecified ? tileWidth : maxChildWidth;
			cellHeight = heightSpecified ? tileHeight : maxChildHeight;
			
		}
		
		/**
		 * Finds the cell sizes of the tile and calculates the number of tiles per row
		 * and per column in the container, to be used for the indexing function.
		 *
		 */
		protected override function measure() : void
		{
			super.measure();
			
			// Find and set the new max cell size of the components to the internal variables
			findCellSize();
			
			// Calculate the padding and border size of the components
			sumWidthPadding = ( getStyle( "paddingLeft" ) * .5 ) + ( getStyle( "paddingRight" ) * .5 );
			sumHeightPadding = ( getStyle( "paddingTop" ) * .5 ) + ( getStyle( "paddingBottom" ) * .5 );
			borderSize = getStyle( "borderThickness" );
			
			// Calculate the number of tiles per row and column for the indexing function
			// Compensate for padding/2 + border around each component
			tilesPerRow = width / ( cellWidth + sumWidthPadding + borderSize );
			tilesPerColumn = height / ( cellHeight + sumHeightPadding + borderSize );
		}
		
		/**
		 * Resets all the logic used in dragging the component and removes the listeners.  
		 *  
		 * @param event
		 * 
		 */
		protected function dragCompleteHandler( event : DragEvent ) : void
		{
			if ( !event )
			{
				return;
			}
			
			var target : UIComponent = UIComponent( event.dragInitiator );
			
			// Ensure the component exists and is a child of this container
			
			if ( !target || !contains( target ))
			{
				return;
			}
			
			// Remove the listeners used for the drag
			
			if ( target.hasEventListener( DragEvent.DRAG_COMPLETE ))
			{
				target.removeEventListener( DragEvent.DRAG_COMPLETE , dragCompleteHandler );
			}
			
			if ( target.hasEventListener( MouseEvent.MOUSE_MOVE ))
			{
				target.removeEventListener( MouseEvent.MOUSE_MOVE , elementMouseMoveHandler );
			}
			
			// Reset the state of the component to once again be visible and included in
			// the layout of the container, as the index has changed and the visualFeedback
			// has been removed.
			
			target.visible = true;
			target.includeInLayout = true;
			
			// Reset these properties for the dragging logic
			
			childDragged = false;
			indexOfDragged = NaN;
		}
		
		
		
	}
}