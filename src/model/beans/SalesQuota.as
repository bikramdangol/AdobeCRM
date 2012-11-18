package model.beans
{

	[RemoteClass( alias="com.adobe.community.adobecrm.domain.SalesQuota" )]
	public class SalesQuota
	{
		private var _quotaValue : Number;
		private var _user : User;
		private var _userId : Number;

		public function set quotaValue( value : Number ) : void
		{
			_quotaValue = value;
		}

		public function get quotaValue() : Number
		{
			return _quotaValue;
		}

		public function set user( value : User ) : void
		{
			_user = value;
		}

		public function get user() : User
		{
			return _user;
		}

		public function set userId( value : Number ) : void
		{
			_userId = value;
		}

		public function get userId() : Number
		{
			return _userId;
		}
	}
}