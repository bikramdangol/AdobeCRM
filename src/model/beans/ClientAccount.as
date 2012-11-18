package model.beans
{

	[RemoteClass( alias="com.adobe.community.adobecrm.domain.ClientAccount" )]
	public class ClientAccount
	{
		private var _annualRevenue : Number;
		private var _clientId : Number;
		private var _clientName : String;
		private var _industry : String;
		private var _user : User;

		public function set annualRevenue( value : Number ) : void
		{
			_annualRevenue = value;
		}

		public function get annualRevenue() : Number
		{
			return _annualRevenue;
		}

		public function set clientId( value : Number ) : void
		{
			_clientId = value;
		}

		public function get clientId() : Number
		{
			return _clientId;
		}

		public function set clientName( value : String ) : void
		{
			_clientName = value;
		}

		public function get clientName() : String
		{
			return _clientName;
		}

		public function set industry( value : String ) : void
		{
			_industry = value;
		}

		public function get industry() : String
		{
			return _industry;
		}

		public function set user( value : User ) : void
		{
			_user = value;
		}

		public function get user() : User
		{
			return _user;
		}
	}
}