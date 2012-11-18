package components.reports
{
	import flash.utils.getDefinitionByName;
	
	import model.beans.PieReportSeries;
	import model.beans.ReportItem;
	
	import mx.charts.HitData;
	import mx.charts.chartClasses.Series;
	import mx.charts.series.PieSeries;
	import mx.charts.series.items.PieSeriesItem;
	import mx.formatters.CurrencyFormatter;
	import mx.formatters.NumberBaseRoundType;
	import mx.formatters.NumberFormatter;
	
	import utils.PropertyUtils;

	public class PieChartReport extends BaseChart implements IBaseChartReport
	{

		// METHODS

		override protected function fillChartSeries() : void
		{
			if ( !reportBean )
			{
				return;
			}

			if ( !chartComponent )
			{
				callLater( fillChartSeries , [ reportBean ]);
				return;
			}
			
			var series : Array = reportBean.pieSeries;
			var seriesLen : int = series.length;
			var seriesClass : Object;
			var rsBean : PieReportSeries;
			var pieSeries : PieSeries;

			var tempPieSeries : Array = new Array();

			for ( var i : int = 0 ; i < seriesLen ; i++ )
			{
				// Get the ReportSeries bean from the series array
				rsBean = ( series[ i ] as PieReportSeries );

				// 	Get the Class reference to the Series type
				//	or subtype to instantiate and pass to
				//	tempSeries
				seriesClass = getDefinitionByName( rsBean.type );

				pieSeries = new seriesClass() as PieSeries;

				pieSeries.nameField = rsBean.nameField;
				pieSeries.field = rsBean.field;
				pieSeries.dataFunction = pieSeriesDataFunc;
				pieSeries.labelFunction = pieSeriesLabelFunc;
				pieSeries.explodeRadius = .12;
				
				if ( rsBean.isCurrency )
				{
					_chartComponent.dataTipFunction = pieDataTipFunc;
				}

				
				pieSeries.setStyle( "labelPosition" , "callout" );
				pieSeries.setStyle( "calloutGap" , 2 );
				
				if ( reportBean.drillDownChartId != 0 )
				{
					pieSeries.useHandCursor = true;
					pieSeries.buttonMode = true;
					pieSeries.mouseChildren = false;
				}

				tempPieSeries.push( pieSeries );
			}

			chartSeries = tempPieSeries;
						
		}
		
		public function pieDataTipFunc ( hitData : HitData ) : String
		{
			var currencyFormatter : CurrencyFormatter = new CurrencyFormatter();
				currencyFormatter.rounding = NumberBaseRoundType.NEAREST;
				currencyFormatter.precision = 2;
			
			return currencyFormatter.format( ( hitData.chartItem as PieSeriesItem ).value );			
		}

		public function pieSeriesDataFunc( series : Series , item : Object , fieldName : String ) : Object
		{

			if ( fieldName == "value" )
			{
				var datatip : String = "";
				var hitItemData : Object = PropertyUtils.parseObjectChain(( series as PieSeries ).field , item );
				
				var reportSeries : PieReportSeries = reportBean.pieSeries[0] as PieReportSeries;

				datatip += hitItemData;
				return datatip;
			}
			else
			{
				return null;
			}
		}

		public function pieSeriesLabelFunc( data : Object , field : String , index : Number , percentValue : Number ) : Object
		{
			var label : String = PropertyUtils.parseObjectChain(( chartSeries[ 0 ] as PieSeries ).nameField , data ) as String;
			var numFormatter : NumberFormatter = new NumberFormatter();
			numFormatter.precision = 2;
			
			return label;
		}

	}
}