package model.beans
{

	[RemoteClass( alias="com.adobe.community.adobecrm.domain.SalesUnitForecast" )]
	public class SalesUnitForecast
	{
		private var _salesManager : SalesManager;

		private var _projectedTotalSales : Number;

		private var _salesQuota : Number;

		private var _region : Region;

		/**
		 * @return the salesManager
		 */
		public function get salesManager() : SalesManager
		{
			return _salesManager;
		}

		/**
		 * @param value the salesManager to set
		 */
		public function set salesManager( value : SalesManager ) : void
		{
			if ( !value )
			{
				return;
			}

			_salesManager = value;
		}

		/**
		 * @return the projectedTotalSales
		 */
		public function get projectedTotalSales() : Number
		{
			return _projectedTotalSales;
		}

		/**
		 * @param value the projectedTotalSales to set
		 */
		public function set projectedTotalSales( value : Number ) : void
		{
			if ( isNaN( value ))
			{
				return;
			}

			_projectedTotalSales = value;
		}

		/**
		 * @return the salesQuota
		 */
		public function get salesQuota() : Number
		{
			return _salesQuota;
		}

		/**
		 * @param value the salesQuota to set
		 */
		public function set salesQuota( value : Number ) : void
		{
			if ( isNaN( value ))
			{
				return;
			}

			_salesQuota = value;
		}

		/**
		 * @return the region
		 */
		public function get region() : Region
		{
			return _region;
		}

		/**
		 * @param value the region to set
		 */
		public function set region( value : Region ) : void
		{
			if ( !value )
			{
				return;
			}

			_region = value;
		}

	}
}