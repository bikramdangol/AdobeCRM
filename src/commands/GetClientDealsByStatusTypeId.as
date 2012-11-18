package commands
{
	import model.ApplicationModel;
	import model.beans.StatusType;
	
	import services.ServiceFactory;

	public class GetClientDealsByStatusTypeId extends CommandAdapter
	{
		private var serviceFactory : ServiceFactory = ServiceFactory.getInstance();
		private var appModel : ApplicationModel = ApplicationModel.getInstance();
		
		private var statusType : StatusType;
				
		public function GetClientDealsByStatusTypeId( args : Array )
		{
			this.statusType = args[0] as StatusType;
		}
		
		public override function execute() : void
		{
			if ( !this.statusType )
				throw new Error( "You must supply a StatusType to the getClientDealsByStatus' constructor." );
							
			serviceFactory.getClientDealService( this ).getClientDealsByStatusTypeId( statusType );
		}
		
		override public function result( data : Object ) : void
		{
			super.result( data );
		}		
	}
}