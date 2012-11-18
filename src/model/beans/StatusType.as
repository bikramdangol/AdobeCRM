package model.beans
{

	[RemoteClass( alias="com.adobe.community.adobecrm.domain.StatusType" )]
	public class StatusType
	{
		private var _statusType : int;
		private var _statusTypeId : Number;
		private var _typeName : String;

		public function set statusType( value : int ) : void
		{
			_statusType = value;
		}

		public function get statusType() : int
		{
			return _statusType;
		}

		public function set statusTypeId( value : Number ) : void
		{
			_statusTypeId = value;
		}

		public function get statusTypeId() : Number
		{
			return _statusTypeId;
		}

		public function set typeName( value : String ) : void
		{
			_typeName = value;
		}

		public function get typeName() : String
		{
			return _typeName;
		}
	}
}