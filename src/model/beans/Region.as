package model.beans
{

	[RemoteClass( alias="com.adobe.community.adobecrm.domain.Region" )]
	public class Region
	{

		private var _regionId : Number;
		private var _regionName : String;

		public function get regionId() : Number
		{
			return _regionId;
		}

		public function set regionId( value : Number ) : void
		{
			if ( isNaN( value ))
			{
				return;
			}

			_regionId = value;
		}

		public function get regionName() : String
		{
			return _regionName;
		}

		public function set regionName( value : String ) : void
		{
			if ( !value )
			{
				return;
			}

			_regionName = value;
		}

	}
}