package components.reports
{
	import mx.charts.CategoryAxis;
	import mx.charts.HitData;
	
	import utils.ChartSeriesUtils;
	import utils.PropertyUtils;

	public class LineChartReport extends BaseChart implements IBaseChartReport
	{

		override protected function fillChartSeries() : void
		{
			if ( reportBean.drillDownChartId == 0 )
			{
				chartSeries = ChartSeriesUtils.createCartesianSeries( reportBean.cartesianSeries );			
			}
			else
			{
				chartSeries = ChartSeriesUtils.createCartesianSeries( reportBean.cartesianSeries, true );			
			}
		}
		
		/**
		 *
		 * @param categoryValue
		 * @param previousCategoryValue
		 * @param axis
		 * @param categoryItem
		 * @return
		 *
		 */
		public function catAxisLabelFunc( categoryValue : Object , previousCategoryValue : Object , axis : CategoryAxis , categoryItem : Object ) : String
		{
			if ( !reportBean.horizontalAxisLabelField || reportBean.horizontalAxisLabelField == "" )
			{
				return categoryValue.toString();
			}
			
			var label : String = PropertyUtils.parseObjectChain( reportBean.horizontalAxisLabelField , categoryItem ) as String;
			
			return label;
		}
		
		/**
		 *
		 * @param axis
		 * @param item
		 * @return
		 *
		 */
		public function catAxisDataFunc( axis : CategoryAxis , item : Object ) : Object
		{
			return PropertyUtils.parseObjectChain( axis.categoryField , item );
		}
		
		/**
		 *
		 * @param hitData
		 * @return
		 *
		 */
		protected function dataTipFunction( hitData : HitData ) : String
		{
			if ( !hitData )
			{
				return "";
			}
			
			return ChartSeriesUtils.cartesianDataTipFunction( hitData, chartComponent, reportBean);
		}		
	}
}