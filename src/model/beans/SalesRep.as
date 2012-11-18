package model.beans
{

	[RemoteClass( alias="com.adobe.community.adobecrm.domain.SalesRep" )]
	public class SalesRep extends User
	{
		private var _managerUserId : Number;

		public function set managerUserId( value : Number ) : void
		{
			_managerUserId = value;
		}

		public function get managerUserId() : Number
		{
			return _managerUserId;
		}
	}
}