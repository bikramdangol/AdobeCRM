package model.beans
{
	

	[RemoteClass( alias="com.adobe.community.adobecrm.domain.SalesForecast" )]
	[Bindable]
	public class SalesForecast
	{
		private var _percentOfQuota : Number;
		private var _projectedTotalSales : Number;
		private var _salesQuota : Number;
		private var _totalSales : Number;
		private var _user : User;

		public function get totalSales() : Number
		{
			return _totalSales;
		}

		public function set totalSales( value : Number ) : void
		{
			_totalSales = value;
		}

		public function get percentOfQuota() : Number
		{
			return _percentOfQuota;
		}

		public function set percentOfQuota( value : Number ) : void
		{
			_percentOfQuota = value;
		}

		public function set projectedTotalSales( value : Number ) : void
		{
			_projectedTotalSales = value;
		}

		public function get projectedTotalSales() : Number
		{
			return _projectedTotalSales;
		}

		public function set salesQuota( value : Number ) : void
		{
			_salesQuota = value;
		}

		public function get salesQuota() : Number
		{
			return _salesQuota;
		}

		public function set user( value : User ) : void
		{
			_user = value;
		}

		public function get user() : User
		{
			return _user;
		}

		[Transient]
		public function get fullUserName() : String
		{
			return user.fullName;
		}
		
		[Transient]
		public function get userFName() : String
		{
			if ( user )
			{
				return user.fname;
			}
			else
			{
				return "";
			}
		}
		
		[Transient]
		public function get userLName() : String
		{
			if ( user )
			{
				return user.lname;
			}
			else
			{
				return "";
			}
		}
		
		[Transient]
		public function get userFullName() : String
		{
			return user.fullName;
		}
	}
}