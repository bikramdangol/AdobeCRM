package model.beans
{

	[RemoteClass( alias="com.adobe.community.adobecrm.domain.SalesActivity" )]
	public class SalesActivity
	{
		private var _activityType : SalesActivityType;
		private var _clientDeal : ClientDeal;
		private var _createdDate : Date;
		private var _user : User;

		public function set activityType( value : SalesActivityType ) : void
		{
			_activityType = value;
		}

		public function get activityType() : SalesActivityType
		{
			return _activityType;
		}

		public function set clientDeal( value : ClientDeal ) : void
		{
			_clientDeal = value;
		}

		public function get clientDeal() : ClientDeal
		{
			return _clientDeal;
		}

		public function set createdDate( value : Date ) : void
		{
			_createdDate = value;
		}

		public function get createdDate() : Date
		{
			return _createdDate;
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