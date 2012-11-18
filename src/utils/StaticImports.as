package utils
{
	import commands.GetAllClientDealsByCloseDateCommand;
	import commands.GetAllClientDealsByStatusCommand;
	import commands.GetAllClientDealsCommand;
	import commands.GetAllRegionalSalesForecastsCommand;
	import commands.GetAllSalesForecastsCommand;
	import commands.GetClientDealsByStatusTypeId;
	import commands.GetOverallSalesProgressCommand;
	import commands.GetSalesForecastsByUserIdCommand;
	import commands.GetSalesRepSalesForecastsBySalesManagerIdCommand;
	import commands.GetSalesUnitForecastsByRegionIdCommand;
	import commands.GetTop10ClientDealsByRegionIdCommand;
	import commands.GetTop10ClientDealsByStatusTypeID;
	import commands.GetTop10ClientDealsByUserIdCommand;
	import commands.GetTop10ClientDealsCommand;
	import commands.GetTop10SalesRepForecastsByPercentOfQuotaCommand;
	
	import components.reports.BarChartReportView;
	import components.reports.ColumnChartReportView;
	import components.reports.LineChartReportView;
	import components.reports.PieChartReportView;
	import components.reports.TabularDataReportView;	

	public class StaticImports
	{
		// Static chart imports
		
		private static var col_chart : ColumnChartReportView;
		private static var grid_chart : TabularDataReportView;
		private static var pie_chart : PieChartReportView;
		private static var bar_chart : BarChartReportView;
		private static var line_chart : LineChartReportView;
		
		// Static command imports
		
		private static var getAllSalesForecastsCommand : GetAllSalesForecastsCommand;
		private static var getSalesForecastsByUserIdCommand : GetSalesForecastsByUserIdCommand;
		private static var getTop10ClientDealsCommand : GetTop10ClientDealsCommand;
		private static var getTop10ClientDealsByRegionIdCommand : GetTop10ClientDealsByRegionIdCommand;
		private static var getTop10ClientDealsByStatusTypeIdCommand : GetTop10ClientDealsByStatusTypeID;
		private static var getAllRegionalSalesForecastsCommand : GetAllRegionalSalesForecastsCommand;
		private static var getSalesUnitForecastsByRegionIdCommand : GetSalesUnitForecastsByRegionIdCommand;
		private static var getSalesRepSalesForecastsBySalesManagerIdCommand : GetSalesRepSalesForecastsBySalesManagerIdCommand;
		private static var getAllClientDealsCommand : GetAllClientDealsCommand;
		private static var getAllClientDealsByStatusCommand : GetAllClientDealsByStatusCommand;
		private static var getAllClientDealsByCloseDateCommand : GetAllClientDealsByCloseDateCommand;
		private static var getClientDealsByStatusCommand : GetClientDealsByStatusTypeId;
		private static var getTop10ClientDealsByUserId : GetTop10ClientDealsByUserIdCommand;
		private static var getTop10SalesRepForecastsByPercentOfQuota : GetTop10SalesRepForecastsByPercentOfQuotaCommand;
		private static var getOverallSalesProgress : GetOverallSalesProgressCommand;
		
		// Static image embeds
		
		[Embed( source="/assets/skins/plusIcon_upIcon.png" )]
		public static const tilePlaceHolderPlusIcon : Class;
		
		[Embed( source="/assets/skins/placeHolderWedge.png" )]
		public static const tilePlaceHolderWedgeIcon : Class;
		
		[Embed( source="/assets/skins/reportThumbGel.png" )]
		public static const reportsDrawerRendererOverlayImage : Class;
		
		[Embed( source="/assets/skins/crosshair_icon.png" )]
		public static const crosshairIcon : Class;
		
		[Embed( source="/assets/images/headerPieChart.png" )]
		public static const headerPieChart : Class;
		
		[Embed( source="/assets/skins/topBackground.gif" )]
		public static const topBackground : Class;
	}
}
