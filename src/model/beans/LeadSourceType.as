package model.beans
{

	[RemoteClass( alias="com.adobe.community.adobecrm.domain.LeadSourceType" )]
	public class LeadSourceType
	{
		private var _leadSourceType : int;
		private var _leadSourceTypeId : Number;
		private var _typeName : String;

		public function set leadSourceType( value : int ) : void
		{
			_leadSourceType = value;
		}

		public function get leadSourceType() : int
		{
			return _leadSourceType;
		}

		public function set leadSourceTypeId( value : Number ) : void
		{
			_leadSourceTypeId = value;
		}

		public function get leadSourceTypeId() : Number
		{
			return _leadSourceTypeId;
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