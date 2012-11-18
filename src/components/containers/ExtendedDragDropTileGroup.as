package components.containers
{
	
	import components.drawing.TilePlaceHolderView;
	import components.navigation.events.ReportsDrawerEvent;
	import components.reports.DrillDownReport;
	import components.reports.DrillDownReportView;
	import components.reports.events.ReportViewEvent;
	
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	
	import model.beans.ReportItem;
	
	import mx.controls.Image;
	import mx.core.BitmapAsset;
	import mx.core.IVisualElement;
	import mx.core.UIComponent;
	import mx.effects.Effect;
	import mx.effects.Fade;
	import mx.effects.Parallel;
	import mx.effects.Resize;
	import mx.effects.UnconstrainItemAction;
	import mx.events.CloseEvent;
	import mx.events.DragEvent;
	import mx.events.EffectEvent;
	import mx.events.IndexChangedEvent;
	import mx.events.ResizeEvent;
	import mx.geom.RoundedRectangle;
	import mx.managers.DragManager;
	
	import spark.components.Button;
	import spark.components.HGroup;
	import spark.components.mediaClasses.VolumeBar;
	import spark.effects.Animate;
	import spark.effects.Move;
	import spark.effects.Scale;
	import spark.effects.animation.MotionPath;
	import spark.effects.animation.SimpleMotionPath;
	import spark.filters.DropShadowFilter;
	
	public class ExtendedDragDropTileGroup extends DragDropTileGroup
	{
		protected var justAddedFeedback : Boolean = false;
		
		protected var maximizedReport : DrillDownReportView;
		
		protected var isMaximized:Boolean = false;
		
		protected var moveEffect : spark.effects.Move;
		protected var parallelEffect : Parallel;
		
		[Bindable]
		public var rearrangeable : Boolean;
		
		[Bindable]
		public var addRemoveEnabled : Boolean;
		
		protected var centerX:Number;
		protected var centerY:Number;
		
		protected  var originX:Number;
		protected  var originY:Number;
		
		protected var offsetX:Number;
		protected var offsetY:Number;
		
		protected  var moveToX:Number;
		protected var moveToY:Number;
		
		public function ExtendedDragDropTileGroup()
		{
			super();
			this.styleName = "dragDropTileGroup";
		}
		
		/**
		 * Handles the dragging of children, or the addition of new reports
		 * to the container.
		 * 
		 * @param event
		 *
		 */
		override protected function dragEnterHandler( event : DragEvent ) : void
		{
			super.dragEnterHandler( event );
			
			var dropTarget : DragDropTileGroup = event.currentTarget as DragDropTileGroup;
			
			// The dragSource must contain a report object if it is to be
			// added to the container. This report object is used to create
			// the component associated with this container.
			
			if ( event.dragSource.hasFormat( "report" ))
			{
				DragManager.acceptDragDrop( dropTarget );
			}
		}
		
		/**
		 * Adds listeners for a mouse up event and, if the mouse down is in the chrome, for a
		 * mouse move event.
		 * 
		 * @param event
		 *
		 */
		override protected function elementMouseDownHandler( event : MouseEvent ) : void
		{
			if ( !event )
			{
				return;
			}
			
			var currentTarget : DisplayObject = DisplayObject( event.currentTarget );
			
			currentTarget.addEventListener( MouseEvent.MOUSE_UP , elementMouseUpHandler , false , 0 , true );
			
			// If the report is rearrangeable and the mouse click was on the chrome
			// add the listener for the move.
			
			if ( (currentTarget is DrillDownReportView) && this.rearrangeable && !isMaximized)
			{
				
				var tempTarget : DisplayObject = event.target as DisplayObject;
				
				// Skip logic if you are clicking on a button
				
				if ( !(tempTarget is Button) )
				{
					// Get a reference to the component's chrome
					
					var reportControlBar : HGroup = ( event.currentTarget as DrillDownReportView ).reportControlBar;
					
					// If the user has clicked on the reportControlBar ( the chrome) or
					// any component in the chrome ( that is not a button ) then allow dragging
					
					if ( tempTarget == reportControlBar || reportControlBar.contains( tempTarget ) )
					{
						currentTarget.addEventListener( MouseEvent.MOUSE_MOVE , elementMouseMoveHandler , false , 0 , true );
					}
				}
			}
		}
		
		/**
		 * Shows the visual feedback and processing when a child is being dragged within
		 * the container or when a new report is being dragged in from the reportsDrawer.
		 * 
		 * @param event
		 *
		 */
		override protected function dragOverHandler( event : DragEvent ) : void
		{
			var dragInitiator : UIComponent;
			
			if ( !event )
			{
				return;
			}
			
			dragInitiator = UIComponent( event.dragInitiator );
			
			// If the dragInitiator is a child, set it to invisible and not included
			// in the layout so as to maintain the representation of the number of
			// children when adding the visual feedback.
			
			if ( this.contains( dragInitiator ))
			{
				dragInitiator.visible = false;
				dragInitiator.includeInLayout = false;
			}
			
			var indexAt : Number = findIndex( this.contentMouseX , this.contentMouseY );
			
			// If the visualFeedback exists at the current location of the mouse,
			// we don't need to do anything.
			
			if ( visualFeedback && contains( visualFeedback ) && ( getElementIndex( visualFeedback ) == indexAt ))
			{
				return;
			}
			
			showFeedback( indexAt , dragInitiator );
		}
		
		/**
		 * Maximizes the report to take up more onscreen realestate. 
		 *  
		 * @param event
		 *
		 */
		protected function maxBtn_ClickHandler( event : ReportViewEvent ) : void
		{
			if ( !event || event.type == "close")
			{
				return;
			}
			
			maximizedReport = event.currentTarget as DrillDownReportView;
			maximizedReport.isMaximized = true;
			isMaximized = true;
			
			centerX = (width/2);
			centerY = (height/2);
			
			originX = maximizedReport.x;
			originY = maximizedReport.y;
			
			offsetX = maximizedReport.width;
			offsetY = maximizedReport.height;
			
			moveToX = centerX - offsetX - originX;
			moveToY = centerY - offsetY - originY;
			
			var p:Parallel = new Parallel();
			p.duration = 600;
			p.target = this;
			
			var s:SimpleMotionPath = new SimpleMotionPath();
			s.valueFrom = 10;
			s.valueTo = 30;
			s.property = "horizontalGap";
			
			var s2:SimpleMotionPath = new SimpleMotionPath();
			s2.valueFrom = 10;
			s2.valueTo = 30;
			s2.property = "verticalGap"; 
			
			var v:Vector.<MotionPath> = new Vector.<MotionPath>();
			v.push( s );
			v.push( s2 );
			
			var a:Animate = new Animate();
			a.motionPaths = v;
			
			var sc:Scale = new Scale();
			sc.scaleXFrom = 1.0;
			sc.scaleYFrom = 1.0;
			sc.scaleXTo = 2;
			sc.scaleYTo = 2;
			sc.transformX = originX * this.scaleX * 2;
			sc.transformY = originY * this.scaleY * 2;
			
			p.addChild( a );
			p.addChild( sc );
			p.play(); 
			
			var drilldown:DrillDownReportView;
			for(var i:int=0;i<numElements;i++){
				drilldown = getElementAt(i) as DrillDownReportView;
				
				if(drilldown != maximizedReport){
					drilldown.enabled = false;
					drilldown.alpha = .2;
				}
			}
			
			maximizedReport.addEventListener( ReportViewEvent.MINIMIZE , handleMinimize , false , 0 , true );
			maximizedReport.reportState = DrillDownReport.MAXIMIZE_STATE;
			
		}
		
		/**
		 * Creates and adds the targets to the remove report effect.
		 *  
		 * @param target
		 * 
		 */
		protected function setupAndPlayRemoveEffect ( target : Object ) : void
		{
			
			// If the effect does not exist, create it
			
			if ( !parallelEffect )
			{
				var fadeEffect : Fade;
				fadeEffect = new Fade();
				fadeEffect.alphaFrom = 1.0;
				fadeEffect.alphaTo = 0;
				
				parallelEffect = new Parallel();
				parallelEffect.duration = 400;
				parallelEffect.addChild( fadeEffect );
			}
			
			parallelEffect.target = target;
			parallelEffect.captureStartValues();
			
			playEffect( parallelEffect );
		}
		
		/**
		 * Adds or moves the child as necessary then removes the visual feedback.
		 * 
		 * @param event
		 */
		override protected function dragDropHandler( event : DragEvent ) : void
		{
			// The superClass handles the case where the dragInitiator
			// is a child of the container.
			super.dragDropHandler( event );
			
			if ( !event )
			{
				return;
			}
			
			var target : DisplayObject = DisplayObject( event.dragInitiator );
			
			// Perform the logic for the case where the dragInitiator
			// is not a child of the container.
			
			if ( !this.contains( target ))
			{
				// Ensure that there is a report to build from
				
				if ( event.dragSource.hasFormat( "report" ))
				{
					var reportBean : ReportItem = ( event.dragSource.dataForFormat( "report" )) as ReportItem;
					
					var drillDown : DrillDownReportView = new DrillDownReportView();
					drillDown.reportBean = reportBean;
					
					// Find and add the component to the index where the mouse if currently at,
					// then remove the feedback
					
					var indexAt : Number = findIndex( this.contentMouseX , this.contentMouseY );
					
					addElementAt( drillDown , indexAt );
					
					removeFeedback();
				}
			}
		}
		
		/**
		 * Overridden to add listeners to the child when it is added.
		 * 
		 * @param element
		 * @param index
		 * @return
		 *
		 */
		override public function addElementAt(element:IVisualElement, index:int) : IVisualElement
		{
			// Use the superClass method to add the listeners to the child
			
			var tempChild : IVisualElement = super.addElementAt( element , index );
			
			// Perform additional logic if the child being added is a DrillDownReport
			
			if ( tempChild is DrillDownReport )
			{
				var tempDrillDown : DrillDownReport = tempChild as DrillDownReport;
				
				// If the report is not to be removed,
				// remove the close button.
				
				if ( !addRemoveEnabled )
				{
					tempDrillDown.closeButtonEnabled = false;
					tempDrillDown.closeButtonVisible = false;
				}
				else
				{
					// Add the close button listener
					
					tempDrillDown.addEventListener( ReportViewEvent.MINIMIZE , handleMinimize , false , 0 , true );					
				}
				
				if ( tempDrillDown.maxButtonEnabled )
				{
					// Add the maximize button listener
					
					tempDrillDown.addEventListener( ReportViewEvent.MAXIMIZE , maxBtn_ClickHandler , false , 0 , true );
				}
				
				tempDrillDown.rearrangeable = rearrangeable;
				tempDrillDown.addEventListener( CloseEvent.CLOSE , handleClose, false, 0, true );
				
				var dropShadow : DropShadowFilter = new DropShadowFilter( 10 , 45 , 0x000000 , .7 , 5 , 5 , .5 , 1 , false , false );				
				
				tempDrillDown.filters = [ dropShadow ];
			}
			
			this.validateNow();
			return tempChild;
		}
		
		/**
		 * Minimizes the report back to its original size.
		 * 
		 * @param event
		 *
		 */
		protected function handleMinimize( event : ReportViewEvent ) : void
		{
			if ( !event )
			{
				return;
			}
			
			var p:Parallel = new Parallel();
			p.duration = 600;
			p.target = this;
			
			var s:SimpleMotionPath = new SimpleMotionPath();
			s.valueFrom = 30;
			s.valueTo = 10;
			s.property = "horizontalGap";
			
			var s2:SimpleMotionPath = new SimpleMotionPath();
			s2.valueFrom = 30;
			s2.valueTo = 10;
			s2.property = "verticalGap"; 
			
			var v:Vector.<MotionPath> = new Vector.<MotionPath>();
			v.push( s );
			v.push( s2 );
			
			var a:Animate = new Animate();
			a.motionPaths = v;
			
			var sc:Scale = new Scale();
			sc.scaleXFrom = 2;
			sc.scaleYFrom = 2;
			sc.scaleXTo = 1.0;
			sc.scaleYTo = 1.0;
			sc.transformX = originX * this.scaleX * 1;
			sc.transformY = originY * this.scaleY * 1;
			
			p.addChild( a );
			p.addChild( sc );
			p.addEventListener(EffectEvent.EFFECT_END, resetCoordinates);
			p.play(); 
			
			var target : DrillDownReport = event.currentTarget as DrillDownReport;
			target.isMaximized = false;
			isMaximized = false;
			
			var drillDown:DrillDownReportView;
			for(var i:int=0;i<numElements;i++){
				drillDown = getElementAt(i) as DrillDownReportView;
				drillDown.enabled = true;
				drillDown.alpha = 1;
			}
			
			target.removeEventListener( ReportViewEvent.MINIMIZE , handleMinimize );
			target.reportState = DrillDownReport.NORMAL_STATE;
			
		}
		
		/**
		 * Resets the coordinates used for the min/max animations.
		 *  
		 * @param event
		 * 
		 */		
		
		protected function resetCoordinates(event:EffectEvent):void
		{
			centerX = 0;
			centerY = 0;
			
			originX = 0;
			originY = 0;
			
			offsetX = 0;
			offsetY = 0;
			
			moveToX = 0;
			moveToY = 0;
		}
		
		/**
		 * Handles the closing of a report view. 
		 * 
		 * @param event
		 * 
		 */		
		protected function handleClose(event:CloseEvent):void
		{
			var target : DrillDownReport = event.currentTarget as DrillDownReport;
			
			target.removeEventListener( CloseEvent.CLOSE, handleClose );
			setupAndPlayRemoveEffect ( target );
		}
		
		
		/**
		 * Creates and draws a visual feedback based on the width and height passed in.
		 *
		 * @param visualWidth
		 * @param visualHeight
		 *
		 */
		override protected function drawVisualFeedback( visualWidth : Number , visualHeight : Number ) : void
		{
			if ( !visualFeedback )
			{
				var placeHolder : TilePlaceHolderView = new TilePlaceHolderView();
				
				visualFeedback = placeHolder;
			}
			
			visualFeedback.width = visualWidth;
			visualFeedback.height = visualHeight;
		}
		
		/**
		 * Queues up a move effect on the children of the container and shuffles them around as needed.
		 *
		 */
		protected function setupAndPlayMoveEffect() : void
		{
			if ( moveEffect )
			{
				if ( moveEffect.isPlaying )
				{
					//	If there's a move effect playing,
					//	queue this one up for later.
					callLater( setupAndPlayMoveEffect );
					return;
				}
			}
			else
			{
				moveEffect = new spark.effects.Move();
				moveEffect.duration = 150;
			}
			
			var childTargets : Array = new Array();
			
			for ( var i : int = 0 ; i < numElements ; i++ )
			{
				var tempChild : IVisualElement = getElementAt( i );
				
				// This check is to ensure that move effect isn't done on
				// the visual feedback as it's added, before an actual move
				// has occurred.
				
				if ( !( tempChild == visualFeedback && justAddedFeedback ))
				{
					childTargets.push( tempChild );
				}
			}
			
			justAddedFeedback = false;
			
			moveEffect.targets = childTargets;
			moveEffect.captureStartValues();
			
			playEffect( moveEffect );
		}
		
		/**
		 * Plays an effect passed in as an argument, performing the manual control
		 * of the autoLayout as well. This is done to ensure no flickering occurs.
		 *  
		 * @param effect
		 * 
		 */
		protected function playEffect ( effect : Effect ) : void
		{
			// Due to the fact that we are going
			// to set the autoLayout to false,
			// we need to take care of this manually
			this.validateSize();
			this.validateProperties();
			this.validateDisplayList();
			
			// We set this to false to stop the container
			// from constantly jumping the children back
			// to their start/end positions as part of the autolayout code. 
			this.autoLayout = false;
			
			// Listener for the end of the effect to reset the autoLayout to true.
			effect.addEventListener( EffectEvent.EFFECT_END , segueEnd );
			
			effect.play();			
		}
		
		/**
		 * Calls super and shows the visualFeedback, then calls setupAndPlayMoveEffect()
		 *
		 * @param indexAt
		 * @param di
		 *
		 */
		override protected function showFeedback( indexAt : int , di : UIComponent ) : void
		{
			if ( isNaN( indexAt ) || !di )
				return;
			
			// Set the feedback's size to the same as the drag initiator's
			
			var vfWidth : Number = Math.max( di.width , cellWidth );
			var vfHeight : Number = Math.max( di.height , cellHeight );
			
			drawVisualFeedback( vfWidth , vfHeight );
			
			// Check if the visualFeedback already exists at that index,
			// and return if so.
			
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
				// Add the visualFeedback and set the flag
				// to ensure that the moveEffect doesn't occur
				// on the visualFeedback when added
				
				addElementAt( visualFeedback , indexAt );
				justAddedFeedback = true;
			}
			
			setupAndPlayMoveEffect();
		}
		
		/**
		 * Takes the passedComponent and creates a bitmap of it, setting it for use as a dragProxy
		 *  
		 * @param passedComponent
		 * @return 
		 * 
		 */
		override protected function createDragProxy( passedComponent : UIComponent ) : UIComponent
		{
			// Get the bounds of the passedComponent
			
			var boundsRect : Rectangle = passedComponent.getBounds( this as DisplayObject );
			
			// Create a rounded rectangle of that size
			
			var roundRect : mx.geom.RoundedRectangle = new RoundedRectangle( boundsRect.x , boundsRect.y , passedComponent.width , passedComponent.height , 5 );
			
			// Extract the bitmap data of the passedComponent and create an asset
			
			var tempBitmapData : BitmapData = new BitmapData( roundRect.width , roundRect.height , true , 0x484848 );
			tempBitmapData.draw( passedComponent as UIComponent );
			
			var targetBitmapAsset : BitmapAsset = new BitmapAsset( tempBitmapData );
			
			var dragProxy : Image = new Image();
			dragProxy.width = roundRect.width;
			dragProxy.height = roundRect.height;
			dragProxy.source = targetBitmapAsset;
			
			return dragProxy;
		}
		
		/**
		 * Creates a new DrillDownReportView component based on the report passed in through the event.
		 * 
		 * @param event
		 * 
		 */
		public function populateView ( event : ReportsDrawerEvent ) : void
		{
			if ( !event )
			{
				return;
			}
			
			var newReport : DrillDownReportView = new DrillDownReportView(); 
			newReport.reportBean = ( event.report as ReportItem );
			
			addElementAt( newReport, 0 );
			this.validateDisplayList();
		}
		
		/**
		 * Moves the children if the index of any of the children has changed.
		 *  
		 * @param event
		 * 
		 */
		protected function childIndexChanged ( event : IndexChangedEvent ) : void
		{
			if ( !event )
			{
				return;
			}
			
			setupAndPlayMoveEffect();
		}		
		
		/**
		 * Resets the autoLayout of the container to true if the methods are done playing.
		 *
		 * @param event
		 *
		 */
		protected function segueEnd( event : Event ) : void
		{
			// If the effect is still playing, we don't want
			// to set the autoLayout to true and get the flicker
			// from the children jumping back and forth. Also,
			// we can negate the responsability now, as it's obvious
			// that the current play will call this handler once it's
			// done and redo this logic.
			
			if ( event )
			{
				// If the effect is the remove effect, remove the child
				// used for the effect. Then perform a move effect to
				// show the change in the children.
				if ( event && event.currentTarget is Parallel && event.currentTarget.isPlaying == false )
				{
					removeElement( (event.currentTarget as Parallel).target as IVisualElement );
					setupAndPlayMoveEffect();
				}
					// If it's not the Parallel effect, it must be the Move effect
					// Also, no additional logic other than autoLayout = true is
					// required.
				else
				{
					this.autoLayout = true;
				}
			}
		}
		
		
		
	}
}