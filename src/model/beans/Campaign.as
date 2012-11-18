package model.beans
{
	import mx.collections.ListCollectionView;

	[RemoteClass( alias="com.adobe.community.adobecrm.domain.Campaign" )]
	public class Campaign
	{
		private var _actualCost : Number;
		private var _actualRevenue : Number;
		private var _campaignId : int;
		private var _campaignName : String;
		private var _campaignType : CampaignType;
		private var _clientDeals : ListCollectionView;
		private var _estimatedRevenue : Number;
		private var _expectedCost : Number;
		private var _expectedResponse : int;
		private var _user : User;

		public function set actualCost( value : Number ) : void
		{
			_actualCost = value;
		}

		public function get actualCost() : Number
		{
			return _actualCost;
		}

		public function set actualRevenue( value : Number ) : void
		{
			_actualRevenue = value;
		}

		public function get actualRevenue() : Number
		{
			return _actualRevenue;
		}

		public function set campaignId( value : int ) : void
		{
			_campaignId = value;
		}

		public function get campaignId() : int
		{
			return _campaignId;
		}

		public function set campaignName( value : String ) : void
		{
			_campaignName = value;
		}

		public function get campaignName() : String
		{
			return _campaignName;
		}

		public function set campaignType( value : CampaignType ) : void
		{
			_campaignType = value;
		}

		public function get campaignType() : CampaignType
		{
			return _campaignType;
		}

		public function set clientDeals( value : ListCollectionView ) : void
		{
			_clientDeals = value;
		}

		public function get clientDeals() : ListCollectionView
		{
			return _clientDeals;
		}

		public function set estimatedRevenue( value : Number ) : void
		{
			_estimatedRevenue = value;
		}

		public function get estimatedRevenue() : Number
		{
			return _estimatedRevenue;
		}

		public function set expectedCost( value : Number ) : void
		{
			_expectedCost = value;
		}

		public function get expectedCost() : Number
		{
			return _expectedCost;
		}

		public function set expectedResponse( value : int ) : void
		{
			_expectedResponse = value;
		}

		public function get expectedResponse() : int
		{
			return _expectedResponse;
		}

		public function set user( value : User ) : void
		{
			_user = value;
		}

		public function get user() : User
		{
			return _user;
		}
	}
}