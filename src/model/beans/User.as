package model.beans
{

	[RemoteClass( alias="com.adobe.community.adobecrm.domain.User" )]
	public class User
	{
		private var _userId : Number;
		private var _fname : String;
		private var _lname : String;
		private var _isManager : int;
		private var _isRegionalManager : int;
		private var _regionId : Number;
		private var _fullName : String;

		public function set userId( value : Number ) : void
		{
			_userId = value;
		}

		public function get userId() : Number
		{
			return _userId;
		}

		public function set fname( value : String ) : void
		{
			_fname = value;
		}

		public function get fname() : String
		{
			return _fname;
		}

		public function set lname( value : String ) : void
		{
			_lname = value;
		}

		public function get lname() : String
		{
			return _lname;
		}

		public function set isManager( value : int ) : void
		{
			_isManager = value;
		}

		public function get isManager() : int
		{
			return _isManager;
		}

		public function set isRegionalManager( value : int ) : void
		{
			_isRegionalManager = value;
		}

		public function get isRegionalManager() : int
		{
			return _isRegionalManager;
		}

		public function set regionId( value : Number ) : void
		{
			_regionId = value;
		}

		public function get regionId() : Number
		{
			return _regionId;
		}


		[Transient]
		public function get fullName() : String
		{
			if ( !_fullName )
			{
				return this.fname + " " + this.lname;
			}
			else
			{
				return _fullName;
			}
		}

		public function set fullName( value : String ) : void
		{
			_fullName = value;
		}
	}
}