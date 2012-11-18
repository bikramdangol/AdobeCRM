package model.beans
{

	[RemoteClass( alias="com.adobe.community.adobecrm.domain.ClientDeal" )]
	[Bindable]
	public class ClientDeal
	{
		private var _campaign : Campaign;
		private var _clientAccount : ClientAccount;
		private var _clientDealId : Number;
		private var _createdDate : Date;
		private var _description : String;
		private var _estimatedCloseDate : Date;
		private var _estimatedRevenue : Number;
		private var _leadSourceType : LeadSourceType;
		private var _priorityLevel : int;
		private var _probability : Number;
		private var _ratingType : RatingType;
		private var _stageType : StageType;
		private var _statusType : StatusType;
		private var _statusTypeCount : Number;
		private var _title : String;
		private var _user : User;
		private var _region : Region;

		private var _closeWeekNumber : Number;

		public function set campaign( value : Campaign ) : void
		{
			_campaign = value;
		}

		public function get campaign() : Campaign
		{
			return _campaign;
		}

		public function set clientAccount( value : ClientAccount ) : void
		{
			_clientAccount = value;
		}

		public function get clientAccount() : ClientAccount
		{
			return _clientAccount;
		}

		public function set clientDealId( value : Number ) : void
		{
			_clientDealId = value;
		}

		public function get clientDealId() : Number
		{
			return _clientDealId;
		}

		public function set createdDate( value : Date ) : void
		{
			_createdDate = value;
		}

		public function get createdDate() : Date
		{
			return _createdDate;
		}

		public function set description( value : String ) : void
		{
			_description = value;
		}

		public function get description() : String
		{
			return _description;
		}

		public function set estimatedCloseDate( value : Date ) : void
		{
			_estimatedCloseDate = value;
		}

		public function get estimatedCloseDate() : Date
		{
			return _estimatedCloseDate;
		}

		public function set estimatedRevenue( value : Number ) : void
		{
			_estimatedRevenue = value;
		}

		public function get estimatedRevenue() : Number
		{
			return _estimatedRevenue;
		}

		public function set leadSourceType( value : LeadSourceType ) : void
		{
			_leadSourceType = value;
		}

		public function get leadSourceType() : LeadSourceType
		{
			return _leadSourceType;
		}

		public function set priorityLevel( value : int ) : void
		{
			_priorityLevel = value;
		}

		public function get priorityLevel() : int
		{
			return _priorityLevel;
		}

		public function set probability( value : Number ) : void
		{
			_probability = value;
		}

		public function get probability() : Number
		{
			return _probability;
		}

		public function set ratingType( value : RatingType ) : void
		{
			_ratingType = value;
		}

		public function get ratingType() : RatingType
		{
			return _ratingType;
		}

		public function set stageType( value : StageType ) : void
		{
			_stageType = value;
		}

		public function get stageType() : StageType
		{
			return _stageType;
		}

		public function set statusType( value : StatusType ) : void
		{
			_statusType = value;
		}

		public function get statusType() : StatusType
		{
			return _statusType;
		}

		public function get statusTypeCount() : Number
		{
			return _statusTypeCount;
		}

		public function set statusTypeCount( value : Number ) : void
		{
			_statusTypeCount = value;
		}

		[Transient]
		public function get statusTypeName() : String
		{
			var statusTypeName : String = "";

			if ( statusType && statusType.typeName )
			{
				return statusType.typeName;
			}

			return statusTypeName;
		}

		public function set title( value : String ) : void
		{
			_title = value;
		}

		public function get title() : String
		{
			return _title;
		}

		public function set user( value : User ) : void
		{
			_user = value;
		}

		public function get user() : User
		{
			return _user;
		}

		public function set region( value : Region ) : void
		{
			_region = value;
		}

		public function get region() : Region
		{
			return _region;
		}

		[Transient]
		public function get closeWeekNumber() : Number
		{
			var dealYear : Number = new Number( estimatedCloseDate.getFullYear() );
			var firstOfYear : Date = new Date( dealYear , 0 , 1 );
			var truncTime : Number = firstOfYear.getTime();


			var closingWeek : Number = estimatedCloseDate.getTime() - truncTime;
			closingWeek = Math.floor( closingWeek / ( 1000 * 60 * 60 * 24 * 7 ) );

			return closingWeek = closingWeek + 1;
		}

		[Transient]
		public function get userFName() : String
		{
			if ( user )
			{
				return user.fname;
			}
			else
			{
				return "";
			}
		}
		
		[Transient]
		public function get userLName() : String
		{
			if ( user )
			{
				return user.lname;
			}
			else
			{
				return "";
			}
		}
		
		[Transient]
		public function get userFullName() : String
		{
			return user.fullName;
		}
		
	}
}