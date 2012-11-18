package components.reports
{
	import mx.charts.CategoryAxis;
	import mx.charts.HitData;
	
	import utils.ChartSeriesUtils;
	import utils.PropertyUtils;

	public class BarChartReport extends BaseChart implements IBaseChartReport
	{
		/** MISC METHODS **/

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
		 * @param axis
		 * @param item
		 * @return
		 *
		 */
		public function catAxisFunc( axis : CategoryAxis , item : Object ) : Object
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