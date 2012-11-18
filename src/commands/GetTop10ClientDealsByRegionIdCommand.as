package commands
{
	import model.ApplicationModel;
	import model.beans.Region;
	
	import services.ServiceFactory;
	
	public class GetTop10ClientDealsByRegionIdCommand extends CommandAdapter
	{
		private var region : Region;
		private var serviceFactory : ServiceFactory = ServiceFactory.getInstance();
		private var appModel : ApplicationModel = ApplicationModel.getInstance();
		
		public function GetTop10ClientDealsByRegionIdCommand( args : Array )
		{
			this.region = args[ 0 ] as Region;
		}
				
		public override function execute() : void
		{
			if ( !this.region )
				throw new Error( "You must supply a Region to the GetTop10ClientDealsByRegionIdCommand's constructor." );
			
			serviceFactory.getClientDealService( this ).getTop10ClientDealsByRegionId( this.region );
		}
		
		override public function result( data : Object ) : void
		{
			super.result( data );
		}
	}
}