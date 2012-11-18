package components.reports
{
	import commands.CommandAdapter;
	
	import flash.utils.getDefinitionByName;
	
	import model.beans.ReportItem;
	
	import mx.charts.chartClasses.ChartBase;
	import mx.charts.chartClasses.Series;
	import mx.charts.effects.SeriesInterpolate;
	import mx.charts.effects.SeriesSlide;
	import mx.collections.ArrayCollection;
	import mx.effects.WipeRight;
	import mx.events.SliderEvent;
	import mx.rpc.events.ResultEvent;
	
	import spark.components.Group;
	import spark.components.SkinnableContainer;
	import spark.skins.SparkSkin;
	import assets.skins.ReportSkin;
	
	public class BaseChart extends SkinnableContainer implements IBaseReport
	{
		
		[Bindable]
		public var _chartComponent : ChartBase;
		
		protected var startWeek : Number = 1;
		protected var endWeek : Number = 52;		
		
		public function BaseChart():void
		{
			super();
		}
		
		/** PUBLIC PROPERTIES **/
		
		/**
		 *
		 * @return
		 *
		 */
		public function get chartComponent() : ChartBase
		{
			return _chartComponent;
		}
		
		protected var chartSeriesChanged : Boolean = false;
		
		protected var _chartSeries : Array = new Array();
		
		/**
		 *
		 * @return
		 *
		 */
		[Bindable( event="chartSeriesChanged" )]
		public function get chartSeries() : Array
		{
			return _chartSeries;
		}
		
		/**
		 *
		 * @param value
		 *
		 */
		public function set chartSeries( value : Array ) : void
		{
			if ( !value )
			{
				return;
			}
			
			chartSeriesChanged = true;
			
			_chartSeries = value;
			
			dispatchEvent( new Event( "chartSeriesChanged" ));
		}
		
		protected var reportBeanChanged : Boolean = false;
		
		protected var _reportBean : ReportItem;
		
		/**
		 *
		 * @return
		 *
		 */
		[Bindable( "reportBeanChanged" )]
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
			{
				return;
			}
			
			reportBeanChanged = true;
			
			_reportBean = value;
			
			invalidateProperties();
			
			dispatchEvent( new Event( "reportBeanChanged" ));
		}
		
		protected var _reportState : String;
		
		/**
		 *
		 * @return
		 *
		 */
		[Bindable( "reportStateChanged" )]
		public function get reportState() : String
		{
			return _reportState;
		}
		
		/**
		 *
		 * @param value
		 *
		 */
		public function set reportState( value : String ) : void
		{
			if ( reportState == value)
			{
				return;
			}
			
			_reportState = value;
		}

		protected var chartDataProviderChanged : Boolean = false;
		
		protected var _chartDataProvider : ArrayCollection = new ArrayCollection();
		
		[Bindable( "chartDataProviderChanged" )]
		/**
		 *
		 * @return
		 *
		 */
		public function get chartDataProvider() : ArrayCollection
		{
			return _chartDataProvider;
		}
		
		/**
		 *
		 * @param value
		 *
		 */
		public function set chartDataProvider( value : ArrayCollection ) : void
		{
			if ( !value )
			{
				return;
			}
			
			chartDataProviderChanged = true;
			
			_chartDataProvider = value;
			
			dispatchEvent( new Event( "chartDataProviderChanged" ));
			
			invalidateProperties();
		}

		/**
		 *
		 *
		 */
		protected function callDataProviderCommand() : void
		{
			var command : CommandAdapter;
			
			var commandClass : Object = getDefinitionByName( reportBean.command );
			
			if ( reportBean && reportBean.commandArgs && reportBean.commandArgs.length > 0 )
			{
				command = new commandClass( reportBean.commandArgs );
			}
			else
			{
				command = new commandClass();
			}
			
			
			command.addCallBack( handleCommandResult ).execute();
		}

		protected function fillChartSeries () : void
		{
			// Must be overriden and implemented in subclasses
		}
		
		protected function displayLabels () : Boolean
		{
			if ( reportBean.hideMinimizedLabels && reportState != DrillDownReport.MAXIMIZE_STATE )
			{
				return false;
			}
			
			return true;
		}
		
		/** HANDLER METHODS **/
		
		/**
		 * Checks to see if the current week is within the specified range.
		 *   
		 * @param item
		 * @return 
		 * 
		 */
		protected function filterDataSetByTimePeriod ( item : Object ) : Boolean
		{
			var closeWeek : Number = item.closeWeekNumber;
			
			if ( closeWeek >= startWeek && closeWeek <= endWeek )
			{
				return true;
			}
			
			return false;
		}
		
		/**
		 *
		 * @param event
		 *
		 */
		protected function handleCommandResult( event : ResultEvent ) : void
		{
			if ( !event )
			{
				return;
			}
			
			chartDataProvider = event.result as ArrayCollection;
			
			// Check for the filter, if it exists
			// set the associated filter function.
			
			if ( reportBean.filterSlider )
			{
				chartDataProvider.filterFunction = filterDataSetByTimePeriod;
				chartDataProvider.refresh();
			}
			
			var seriesEffect : WipeRight;
			seriesEffect = new WipeRight( this );
			seriesEffect.duration = 500;
			
			if ( chartComponent )
			{
				chartComponent.visible = true;
			}
			
			if ( chartComponent && chartComponent.series )
			{
				for each ( var item : Series in chartComponent.series )
				{
					item.setStyle( "showDataEffect" , seriesEffect );
				}
			}
		}
		
		protected function setTimePeriod ( event : SliderEvent ) : void
		{
			if ( !event )
			{
				return;
			}
			
			// Get the first day of the current year
			var firstOfYear : Date = new Date();
			firstOfYear.setMonth( 0, 1);
			
			// Get the UTC representation of this time
			// We can use this value for date calculations
			var truncTime : Number = firstOfYear.getTime();
			
			// Find the representation for the time from
			// the first of the year to the current date
			var currentWeek : Number = new Date().getTime() - truncTime;
			
			// Convert the number representation into a week representation
			currentWeek = Math.floor( currentWeek / ( 1000 * 60 * 60 * 24 * 7 ));
			
			// This is for the sake of clarity
			// Shifting 0-51 to 1-52 for weeks
			currentWeek = currentWeek + 1;			
			
			switch ( event.value )
			{
				case 0 :
					// Accounts for the whole year
					startWeek = 1;
					endWeek = 52;
					break;
				
				case 1 :
					// Checks for which quarter user
					// is in and sets accordingly
					if ( currentWeek <= 13 )
					{
						startWeek = 1;
						endWeek = 13;
					}
					else if ( currentWeek <= 26 )
					{
						startWeek = 14;
						endWeek = 26;
					}
					else if ( currentWeek <= 39 )
					{
						startWeek = 27;
						endWeek = 39;
					}
					else
					{
						startWeek = 40;
						endWeek = 52;
					}
					
					break;
				
				case 2 :
					// Sets to this week and 2 months ahead
					startWeek = currentWeek;
					endWeek = currentWeek + 7;
					break;
				
				case 3 :
					//Sets to one month ahead
					startWeek = currentWeek;
					endWeek = currentWeek + 3;
					break;
				
				case 4 :
					//Sets to current week
					startWeek = currentWeek;
					endWeek = currentWeek;
					
			}
			
			// Ensure endWeek does not exceed valid range
			endWeek = endWeek > 52 ? 52 : endWeek;
			
			var sliderEffect : SeriesSlide = new SeriesSlide();
			
			var seriesEffect : SeriesInterpolate;
			seriesEffect = new SeriesInterpolate();			
			
			// Changes the effect to a slide effect on the series'
			
			for each ( var item : Series in chartComponent.series )
			{
				item.setStyle( "showDataEffect" , sliderEffect );
				item.setStyle( "hideDataEffect" , sliderEffect );
			}
			
			chartDataProvider.refresh();
		}		
		
		/* OVERRIDES */
		
		/**
		 *
		 *
		 */
		override protected function commitProperties() : void
		{
			super.commitProperties();
			
			// If the reportBean is changed, a new chart associated
			// to that report must be created.
			
			if ( reportBeanChanged )
			{
				reportBeanChanged = false;

				// Hide the report until the effect plays.
				chartComponent.visible = false;
				callDataProviderCommand();
				
				fillChartSeries();
				
				chartComponent.invalidateProperties();
			}
			
			if ( chartDataProviderChanged )
			{
				chartDataProviderChanged = false;
				
				chartComponent.invalidateProperties();
				
			}
		}
	}
}