package model
{
	import commands.GetServiceDefinitions;
	
	import model.beans.ReportItem;
	
	import mx.collections.ArrayCollection;
	import mx.resources.ResourceManager;
	
	[ResourceBundle("crm")]
	
	[Bindable]
	public class ApplicationModel
	{
		public static var instance : ApplicationModel;
		public var pathToServices : String = ResourceManager.getInstance().getString( "crm", "xmlFiles.services" );
		
		public var reports : ArrayCollection = new ArrayCollection();
		public var navItems : ArrayCollection;
		public var reportGroups : ArrayCollection;
		
		private var _salesRegions : ArrayCollection;
		
		public function get salesRegions() : ArrayCollection
		{
			return _salesRegions;
		}
		
		public function set salesRegions( value : ArrayCollection ) : void
		{
			if ( !value )
			{
				return;
			}
			
			_salesRegions = value;
			
		}
		
		private var _users : ArrayCollection;
		
		public function get users() : ArrayCollection
		{
			return _users;
		}
		
		public function set users( value : ArrayCollection ) : void
		{
			if ( !value )
				return;
			
			_users = value;
		}
		
		private var _salesManagers : ArrayCollection;
		
		public function get salesManagers() : ArrayCollection
		{
			return _salesManagers;
		}
		
		public function set salesManagers( value : ArrayCollection ) : void
		{
			if ( !value )
				return;
			
			_salesManagers = value;
		}
		
		private var _salesForecasts : ArrayCollection;
		
		public function get salesForecasts() : ArrayCollection
		{
			return _salesForecasts;
		}
		
		public function set salesForecasts( value : ArrayCollection ) : void
		{
			if ( !value || value === _salesForecasts )
				return;
			
			_salesForecasts = value;
			
		}
		
		private var _clientDeals : ArrayCollection;
		
		public function get clientDeals() : ArrayCollection
		{
			return _clientDeals;
		}
		
		public function set clientDeals( value : ArrayCollection ) : void
		{
			if ( !value || value === _clientDeals )
				return;
			
			_clientDeals = value;
			
		}
		
		public function getReportDataById( id : int ) : ReportItem
		{
			var reportItem : ReportItem;
			var tempReportItem : ReportItem;
			var reportsLen : int = reports.length;
			
			for ( var i : int = 0 ; i < reportsLen ; i++ )
			{
				tempReportItem = reports.getItemAt( i ) as ReportItem;
				
				if ( tempReportItem.id == id )
				{
					reportItem = tempReportItem;
					break;
				}
				
			}
			
			return reportItem;
		}
		
		private var _curReportGroupId : int = 0;
		
		public function get curReportGroupId() : int
		{
			return _curReportGroupId;
		}
		
		public function set curReportGroupId( value : int ) : void
		{
			if ( isNaN( value ))
			{
				return;
			}
			
			_curReportGroupId = value;
		}
		
		
		public function ApplicationModel( singletonEnforcer : SingletonEnforcer )
		{
		}
		
		public static function getInstance() : ApplicationModel
		{
			if ( !instance )
			{
				instance = new ApplicationModel( new SingletonEnforcer());
				instance.init();
			}
			
			return instance;
		}
		
		private function init() : void
		{
			new GetServiceDefinitions( pathToServices ).execute();
		}
	}
}

class SingletonEnforcer
{
}