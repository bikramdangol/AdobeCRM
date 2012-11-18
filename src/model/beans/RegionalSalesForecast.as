package model.beans
{

	[RemoteClass( alias="com.adobe.community.adobecrm.domain.RegionalSalesForecast" )]
	public class RegionalSalesForecast
	{
		private var _projectedTotalSales : Number;
		private var _salesQuota : Number;
		private var _regionalSalesManager : RegionalSalesManager;
		private var _region : Region;

		public function get projectedTotalSales() : Number
		{
			return _projectedTotalSales;
		}

		public function set projectedTotalSales( value : Number ) : void
		{
			_projectedTotalSales = value;
		}

		public function get salesQuota() : Number
		{
			return _salesQuota;
		}

		public function set salesQuota( value : Number ) : void
		{
			_salesQuota = value;
		}

		public function get regionalSalesManager() : RegionalSalesManager
		{
			return _regionalSalesManager;
		}

		public function set regionalSalesManager( value : RegionalSalesManager ) : void
		{
			_regionalSalesManager = value;
		}

		[Transient]
		public function get fullUserName() : String
		{
			return regionalSalesManager.fullUserName;
		}
	}
}