package services
{
	import model.beans.Region;
	import model.beans.SalesManager;
	import model.beans.User;

	import mx.rpc.AsyncToken;

	public interface ISalesForecastService
	{
		function getAllSalesForecasts() : AsyncToken;

		function getAllRegionalSalesForecasts() : AsyncToken;

		function getSalesForecastsByUserId( user : User ) : AsyncToken;

		function getRegionalSalesForecastsByRegionId( region : Region ) : AsyncToken;

		function getSalesUnitForecastsByRegionId( region : Region ) : AsyncToken;

		function getSalesRepSalesForecastsBySalesManagerId( salesManager : SalesManager ) : AsyncToken;
		
		function getTop10SalesRepForecastsByPercentOfQuota() : AsyncToken;
	}
}