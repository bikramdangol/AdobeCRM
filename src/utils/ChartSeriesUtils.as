package utils
{
	import flash.utils.getDefinitionByName;
	
	import model.beans.CartesianReportSeries;
	import model.beans.ReportItem;
	
	import mx.charts.HitData;
	import mx.charts.chartClasses.ChartBase;
	import mx.charts.chartClasses.Series;
	import mx.charts.series.BarSeries;
	import mx.charts.series.ColumnSeries;
	import mx.charts.series.LineSeries;
	import mx.formatters.CurrencyFormatter;
	import mx.formatters.NumberBaseRoundType;
	import mx.formatters.NumberFormatter;
	import mx.graphics.SolidColor;
	import mx.graphics.SolidColorStroke;
	import mx.graphics.Stroke;
	import mx.states.SetStyle;
	import mx.charts.series.PieSeries;

	public class ChartSeriesUtils
	{
		private static var seriesArray : Array;
		
		private static var s1 : SolidColorStroke = new SolidColorStroke( 0xe5f309, 2 );
		private static var s2 : SolidColorStroke = new SolidColorStroke( 0x7a7ba5, 2 );
		private static var s3 : SolidColorStroke = new SolidColorStroke( 0xca1537, 2 );
		
		[Bindable]
		private static var columnSeriesColors:Array = new Array(
			new SolidColor(0x92f016, .8), 
			new SolidColor(0x75c111, .6)
		);
		
		[Bindable]
		private static var lineSeriesColors:Array = new Array(
			new SolidColor(0xa353cf, .8), 
			new SolidColor(0x7a7ba5, .8), 
			new SolidColor(0x8015f3, .8),
			new SolidColor(0x7a52a5, .8)
		);
		
		[Bindable]
		private static var pieSeriesColors:Array = new Array(
			new SolidColor(0xa353cf, .8), 
			new SolidColor(0x7a7ba5, .8), 
			new SolidColor(0x8015f3, .8),
			new SolidColor(0x7a52a5, .8)
		);
		
		public static function createCartesianSeries( series : Array, drillable : Boolean = false ) : Array
		{
			if ( !series )
			{
				return null;
			}
			
			var seriesArray : Array = new Array();
			
			var seriesLen : int = series.length;
			var seriesClass : Object;
			var cartesianReportSeries : CartesianReportSeries;
			var cartesianSeries : Object;
			
			var tempLineSeries : Array = new Array();
			
			for ( var i : int = 0 ; i < seriesLen ; i++ )
			{
				// get the ReportSeries bean from the series array
				cartesianReportSeries = ( series[ i ] as CartesianReportSeries );
				
				// 	get the Class reference to the Series type
				//	or subtype to instantiate and pass to
				//	tempSeries
				seriesClass = getDefinitionByName( cartesianReportSeries.type );
				
				cartesianSeries = new seriesClass();
				
				// Make sure the object is a cartesian series so the properties exist
				
				if ( !isCartesianSeries( cartesianSeries as Series ) )
				{
					return null;
				}
				
				if ( cartesianReportSeries.xField && cartesianReportSeries.xField != "" )
				{
					cartesianSeries.xField = cartesianReportSeries.xField;
				}
				
				if ( cartesianReportSeries.yField && cartesianReportSeries.yField != "" )
				{
					cartesianSeries.yField = cartesianReportSeries.yField;
				}
				
				cartesianSeries.displayName = cartesianReportSeries.displayName;
				
				cartesianSeries.dataFunction = seriesDataFunc;
				
				if(cartesianSeries is ColumnSeries)
				{
					cartesianSeries.setStyle( "fills" , columnSeriesColors );
					cartesianSeries.setStyle( "stroke" , s1 );
				}
				
				if(cartesianSeries is PieSeries)
				{
					cartesianSeries.setStyle( "fills" , pieSeriesColors );
					cartesianSeries.setStyle( "stroke" , s1 );
				}
				
				if(cartesianSeries is LineSeries){
					cartesianSeries.setStyle("lineStroke", s3);
				}
				
				if ( drillable )
				{
					cartesianSeries.buttonMode = true;
					cartesianSeries.useHandCursor = true;
				}
				
				seriesArray.push( cartesianSeries );
			}
			
			return seriesArray;
		}

		/**
		 *
		 * @param series
		 * @param item
		 * @param fieldName
		 * @return
		 *
		 */
		private static function seriesDataFunc( series : Object , item : Object , fieldName : String ) : Object
		{
			if ( !isCartesianSeries( series as Series )) {
				return null;
			}
				
			if ( fieldName == "xValue" )
			{
				return PropertyUtils.parseObjectChain( series.xField , item );
			}
			else if ( fieldName == "yValue" )
			{
				return PropertyUtils.parseObjectChain( series.yField , item );
			}
			
			return null;
		}
		
		/**
		 *
		 * @param hitData
		 * @return
		 *
		 */
		public static function cartesianDataTipFunction( hitData : HitData, chartComponent : ChartBase, reportBean : ReportItem ) : String
		{
			if ( !hitData )
			{
				return "";
			}
			
			var dataTip : String = "";
			
			if ( !hitData.element )
			{
				return "";
			}			
			
			var seriesIndex : int = chartComponent.series.indexOf( hitData.element );
			
			var reportSeries : Object = reportBean.cartesianSeries[ seriesIndex ];
			
			var reportSeriesXValue : Object = PropertyUtils.parseObjectChain( reportSeries.xField , hitData.chartItem.item );
			var reportSeriesYValue : Object = PropertyUtils.parseObjectChain( reportSeries.yField , hitData.chartItem.item );
			
			var currencyFormatter : CurrencyFormatter;
			var numberFormatter	  : NumberFormatter;
			
			if ( reportSeries.isXFieldCurrency )
			{
				currencyFormatter = new CurrencyFormatter();
				currencyFormatter.rounding = NumberBaseRoundType.NEAREST;
				currencyFormatter.precision = 0;
				
				reportSeriesXValue = currencyFormatter.format( reportSeriesXValue );
			}
			
			if ( reportSeries.isYFieldCurrency )
			{
				currencyFormatter = new CurrencyFormatter();
				currencyFormatter.rounding = NumberBaseRoundType.NEAREST;
				currencyFormatter.precision = 0;
				
				reportSeriesYValue = currencyFormatter.format( reportSeriesYValue );
			}
			
			if ( reportSeries.isXFieldPercentage )
			{
				numberFormatter = new NumberFormatter();
				numberFormatter.precision = 2;
				
				reportSeriesXValue = numberFormatter.format( reportSeriesXValue );
				reportSeriesXValue += "%";
			}
			
			if ( reportSeries.isYFieldPercentage )
			{
				numberFormatter = new NumberFormatter();
				numberFormatter.precision = 2;
				
				reportSeriesYValue = numberFormatter.format( reportSeriesYValue );
				reportSeriesYValue += "%";
			}
			
			if ( reportBean.horizontalAxisLabelField && reportBean.horizontalAxisLabelField != "" )
			{
				reportSeriesXValue = PropertyUtils.parseObjectChain( reportBean.horizontalAxisLabelField , hitData.chartItem.item );
			}
			
			dataTip += reportSeries.displayName + "\n";
			dataTip += reportSeriesYValue + "\n";
			dataTip += reportSeriesXValue + "\n";
			
			return dataTip;
		}		
		
		/**
		 * 
		 * @param series
		 * @return 
		 * 
		 */
		private static function isCartesianSeries ( series : Series ) : Boolean
		{
			if ( series is BarSeries || series is LineSeries || series is ColumnSeries ){
				return true;
			}
			
			return false;
		}
	}
}