package model.beans
{

	[RemoteClass( alias="com.adobe.community.adobecrm.domain.ActivityType" )]
	public class ActivityType
	{
		private var _activityTypeId : int;
		private var _type : int;
		private var _typeName : String;

		public function set activityTypeId( value : int ) : void
		{
			_activityTypeId = value;
		}

		public function get activityTypeId() : int
		{
			return _activityTypeId;
		}

		public function set type( value : int ) : void
		{
			_type = value;
		}

		public function get type() : int
		{
			return _type;
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