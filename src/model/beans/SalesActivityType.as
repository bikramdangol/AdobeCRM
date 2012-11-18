package model.beans
{

	[RemoteClass( alias="com.adobe.community.adobecrm.domain.SalesActivityType" )]
	public class SalesActivityType extends SalesActivityTypeBase
	{
		private var _activityTypeId : Number;
		private var _type : int;
		private var _typeName : String;

		public function set activityTypeId( value : Number ) : void
		{
			_activityTypeId = value;
		}

		public function get activityTypeId() : Number
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