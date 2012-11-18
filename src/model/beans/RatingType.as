package model.beans
{

	[RemoteClass( alias="com.adobe.community.adobecrm.domain.RatingType" )]
	public class RatingType
	{
		private var _ratingType : int;
		private var _ratingTypeId : Number;
		private var _typeName : String;

		public function set ratingType( value : int ) : void
		{
			_ratingType = value;
		}

		public function get ratingType() : int
		{
			return _ratingType;
		}

		public function set ratingTypeId( value : Number ) : void
		{
			_ratingTypeId = value;
		}

		public function get ratingTypeId() : Number
		{
			return _ratingTypeId;
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