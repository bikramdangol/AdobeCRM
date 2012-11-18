package model.beans
{

	[RemoteClass( alias="com.adobe.community.adobecrm.domain.StageType" )]
	public class StageType
	{
		private var _stageType : int;
		private var _stageTypeId : Number;
		private var _typeName : String;

		public function set stageType( value : int ) : void
		{
			_stageType = value;
		}

		public function get stageType() : int
		{
			return _stageType;
		}

		public function set stageTypeId( value : Number ) : void
		{
			_stageTypeId = value;
		}

		public function get stageTypeId() : Number
		{
			return _stageTypeId;
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