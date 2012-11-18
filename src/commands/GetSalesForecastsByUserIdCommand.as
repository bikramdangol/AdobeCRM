package commands
{
	import model.ApplicationModel;
	import model.beans.User;
	
	import mx.collections.ArrayCollection;
	
	import services.ServiceFactory;
	
	public class GetSalesForecastsByUserIdCommand extends CommandAdapter
	{
		private var path : String;
		private var user : User;
		private var serviceFactory : ServiceFactory = ServiceFactory.getInstance();
		private var appModel : ApplicationModel = ApplicationModel.getInstance();
		
		public function GetSalesForecastsByUserIdCommand( args : Array )
		{
			this.path = path;
			this.user = args[0] as User;
		}
				
		public override function execute() : void
		{
			if ( !this.user )
				throw new Error( "You must supply a User to the GetSalesForecastsByUserIdCommand's constructor." );
				 
			serviceFactory.getSalesForecastService( this ).getSalesForecastsByUserId( this.user );
		}
		
		override public function result( data : Object ) : void
		{
			super.result( data );
			appModel.salesForecasts = data.result as ArrayCollection;
		}
		
	}
}