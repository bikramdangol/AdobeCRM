package commands
{
	import model.ApplicationModel;
	import model.beans.User;
	
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	
	import services.ServiceFactory;

	public class GetTop10ClientDealsByUserIdCommand extends CommandAdapter
	{
		private var serviceFactory : ServiceFactory = ServiceFactory.getInstance();
		private var appModel : ApplicationModel = ApplicationModel.getInstance();
		private var user : User;
		private var lBoundDate : Date;
		private var uBoundDate : Date;
		
		public function GetTop10ClientDealsByUserIdCommand( args : Array )
		{
			this.user = args[ 0 ] as User;
			
			if ( args[1] && args[1] is Date )
			{
				lBoundDate = args[ 1 ] as Date;
			}
			
			if ( args[2] && args[2] is Date )
			{
				uBoundDate = args[ 2 ] as Date;
			}
			
		}
				
		public override function execute() : void
		{
			if ( !this.user )
				throw new Error( "You must supply a User in the args array for the getTop10ClientDealsByUserId's constructor." );
				
			serviceFactory.getClientDealService( this ).getTop10ClientDealsByUserId( user, this.lBoundDate, this.uBoundDate );
		}
		
		override public function result( data : Object ) : void
		{
			super.result( data );
			
			var event : ResultEvent = data as ResultEvent;
			
			if ( !event )
			{
				return;
			}
			
			trace( "event.result: " + event.result ); 
		}
		
		override public function fault( info : Object ) : void
		{
			super.fault( info );
			
			var event : FaultEvent = info as FaultEvent;
			
			if ( !event )
			{
				return;
			}
			
			trace( "event.message: " + event.message ); 
		}
		
	}
}	