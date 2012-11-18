package model.beans
{

	[RemoteClass( alias="com.adobe.community.adobecrm.domain.CampaignType" )]
	public class CampaignType
	{
		private var _campaignTypeId : int;
		private var _type : int;
		private var _typeName : String;

		public function set campaignTypeId( value : int ) : void
		{
			_campaignTypeId = value;
		}

		public function get campaignTypeId() : int
		{
			return _campaignTypeId;
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