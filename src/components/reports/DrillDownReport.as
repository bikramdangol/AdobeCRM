package components.reports
{
	import components.reports.events.ReportViewEvent;
	
	import flash.display.DisplayObject;
	import flash.events.MouseEvent;
	import flash.utils.*;
	
	import model.ApplicationModel;
	import model.beans.PieReportSeries;
	import model.beans.ReportItem;
	
	import mx.charts.events.ChartItemEvent;
	import mx.collections.ArrayCollection;
	import mx.containers.ViewStack;
	import mx.controls.ToggleButtonBar;
	import mx.core.ClassFactory;
	import mx.core.INavigatorContent;
	import mx.core.IVisualElement;
	import mx.core.UIComponent;
	import mx.events.CloseEvent;
	import mx.events.ItemClickEvent;
	
	import spark.components.Button;
	import spark.components.NavigatorContent;
	import spark.components.SkinnableContainer;
	import spark.skins.SparkSkin;
	
	import utils.PropertyUtils;

	public class DrillDownReport extends SkinnableContainer implements IBasePod
	{

		/** STATIC CONSTANTS **/
		
		public static const MAXIMIZE_STATE:String = "maximize";
		public static const NORMAL_STATE:String = "normal";
	
		/** UI ELEMENTS **/
		
		[Bindable]
		protected var appModel : ApplicationModel = ApplicationModel.getInstance();
		
		[Bindable]
		public var reportState : String;
		
		[Bindable]
		public var titleAppender : String = "";
		
		[Bindable]
		public var rearrangeable : Boolean = true;
		
		[Bindable]
		public var closeButtonEnabled : Boolean = true;
		
		[Bindable]
		public var closeButtonVisible : Boolean = true;
		
		[Bindable]
		public var maxButtonEnabled : Boolean = true;
		
		[Bindable]
		public var isMaximized : Boolean = false;
		
		[Bindable]
		public var maxButtonVisible : Boolean = true;
		
		[Bindable]
		public var chartStack : ViewStack;

		[Bindable]
		public var chartButton:Button;
		
		[Bindable]
		public var tabularButton:Button;

		[Bindable]
		public var allowBackTrack : Boolean = false;
		
		[Bindable]
		public var maskObject : DisplayObject;
		
		[Bindable]
		public var maxButton : Button;
		
		[Bindable]
		public var closeButton : Button;	
		
		private var tabularView : IBaseTabularReport;
		
		/** MISC FIELDS **/
		
		protected var reportBeanChanged : Boolean = false;
		
		protected var _reportBean : ReportItem;
		
		// Stores the reportBean of charts that
		// were drilled from, so the user can return
		
		public var backTrack : Array = new Array();
		
		public var backTrackTitleAppender : Array = new Array();
		
		public function DrillDownReport()
		{
			this.styleName = "drillDownReport";
		}
		
		/**
		 *
		 * @return
		 *
		 */
		[Bindable( event="reportBeanChanged" )]
		public function get reportBean() : ReportItem
		{
			return _reportBean;
		}
		
		/**
		 *
		 * @param value
		 *
		 */
		public function set reportBean( value : ReportItem ) : void
		{
			if ( !value )
				return;
			
			_reportBean = value;
			
			reportBeanChanged = true;
			
			invalidateProperties();
			
			this.dispatchEvent( new Event( "reportBeanChanged" ));
		}
		
		protected var _reportView : IBaseReport;		
		
		[Bindable]
		public function get reportView():IBaseReport
		{
			return _reportView;
		}
		
		public function set reportView(value:IBaseReport):void
		{
			_reportView = value;
		}

		/** HANDLER METHODS **/

		/**
		 *
		 * @param event
		 *
		 */
		protected function handleClose( event : MouseEvent ) : void
		{
			var dspEvent:CloseEvent = new CloseEvent(CloseEvent.CLOSE);
			
			dispatchEvent( dspEvent );
		}
		
		/**
		 * Dispatches a custom _chartContainerEvent passing this object as a parameter. The listening
		 * component should be the parent container.
		 *
		 * @param event
		 *
		 */
		protected function maxButton_ClickHandler( event : MouseEvent ) : void
		{
			var chartEvent : ReportViewEvent;
			
			if(reportState == "maximize"){
				chartEvent = new ReportViewEvent( ReportViewEvent.MINIMIZE , true );
			} else {
				chartEvent = new ReportViewEvent( ReportViewEvent.MAXIMIZE , true );
			}
			
			dispatchEvent( chartEvent as ReportViewEvent );
		}
		
		/**
		 *
		 * @param event
		 *
		 */
		protected function drillDownHandler( event : ChartItemEvent ) : void
		{
			if ( !event )
			{
				return;
			}

			if ( reportBean.drillDownChartId == 0 )
			{
				return;
			}

			backTrack.push( reportBean );
			backTrackTitleAppender.push( titleAppender );
			
			allowBackTrack = true;
			
			// Used to dynamically determine a reportBean
			var item : Object = event.hitData.item;

			var drillReport : ReportItem = appModel.getReportDataById( reportBean.drillDownChartId );

			var drillDownData : Object = PropertyUtils.parseObjectChain( reportBean.drillDownField , item );
			
			var tempAppender : Object;
			
			if ( drillDownData )
			{
				drillReport.commandArgs.splice( 0 );
				drillReport.commandArgs.push( drillDownData );
			
				if ( reportBean.horizontalAxisField )
				{
					tempAppender = PropertyUtils.parseObjectChain( reportBean.horizontalAxisField, item );
				}
				else if ( reportBean.verticalAxisField )
				{
					tempAppender = PropertyUtils.parseObjectChain( reportBean.verticalAxisField, item );
				}
				else if ( reportBean.pieSeries.length > 0 )
				{
					var tempString : PieReportSeries = reportBean.pieSeries[0];
					
					tempAppender = PropertyUtils.parseObjectChain( tempString.nameField, item );
				}
			}
			
			titleAppender = " " + tempAppender;

			reportBean = drillReport;
		}
		
		protected function backTrackButton_clickHandler( event : MouseEvent ) : void
		{
			if ( !event )
			{
				return;
			}
			
			if ( !backTrack || backTrack.length == 0 )
			{
				return;
			}
			
			reportBean = backTrack.pop();
			titleAppender = backTrackTitleAppender.pop();
			
			if ( backTrack.length == 0 )
			{
				allowBackTrack = false;
			}
			
		}
		
		protected function chartButton_ClickHandler(event:MouseEvent):void
		{
			if ( !event )
			{
				return;
			}
			
			chartStack.selectedIndex = 0;
		}
		
		protected function tabularButton_ClickHandler(event:MouseEvent):void
		{
			if ( !event )
			{
				return;
			}
			
			chartStack.selectedIndex = 1;
		}
		
		/** MISC METHODS **/
		
		/**
		 * Create a new chart in the pod based on the reportBean assigned to the pod.
		 *
		 */
		protected function createNewChart() : void
		{
			chartStack.removeAllChildren();

			var ReportClass : Object = getDefinitionByName( reportBean.type ) as Class;

			reportView = new ReportClass() as BaseChart;

			if ( !reportView )
				return;
		
			reportView.reportBean = reportBean;
			reportView.reportState = reportState;
			
			var n:NavigatorContent = new NavigatorContent();
			n.addElement( reportView as IVisualElement );
			
			chartStack.addChild( n );

			chartStack.selectedChild = (n as INavigatorContent);
			
			if ( reportBean.tabularColumns.length > 0 && !( reportView is IBaseTabularReport ))
			{
				tabularView = new TabularDataReportView();
				tabularView.reportBean = reportBean;
				
				var n2:NavigatorContent = new NavigatorContent();
				n2.addElement( tabularView as IVisualElement );
				
				chartStack.addChild( n2 );
				
				chartButton.visible = true;
				tabularButton.visible = true;

			}
			
		}
		
		protected function showRearrangeableToolTip ( rearrange : Boolean ) : String
		{
			if ( rearrange )
			{
				return resourceManager.getString('crm','statusMessage.moveReport');
			}
			else
			{
				return null;
			}
		}

		/** OVERRIDDEN METHODS **/
		
		/**
		 *
		 *
		 */
		override protected function commitProperties() : void
		{
			if ( reportBeanChanged )
			{
				reportBeanChanged = false;
				
				createNewChart();
				
				( reportView as UIComponent ).addEventListener( ChartItemEvent.ITEM_CLICK , drillDownHandler , false , 0 , true );
				
				if ( reportState == MAXIMIZE_STATE )
				{
					rearrangeable = false;
				}
			}
			
			super.commitProperties();
		}

	}
}