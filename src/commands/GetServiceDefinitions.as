package commands
{
	import flash.utils.getDefinitionByName;
	
	import mx.messaging.Channel;
	import mx.messaging.channels.AMFChannel;
	
	import services.ServiceFactory;
	
	public class GetServiceDefinitions extends CommandAdapter
	{
		private var path : String;
		private var serviceFactory : ServiceFactory = ServiceFactory.getInstance();
		
		public function GetServiceDefinitions( path : String )
		{
			this.path = path;
		}
		
		override public function execute() : void
		{
			serviceFactory.getServiceLoader( path, this ).getData();
		}
		
		/**
		 * 
		 * @param data
		 * 
		 */
		override public function result( data : Object ) : void
		{
			super.result( data );
			
			serviceFactory.navURL = data.result.config.nav;
			serviceFactory.reportsURL = data.result.config.reports;
			serviceFactory.reportGroupsURL = data.result.config.reportGroups;
			
			new GetChartItems().execute();
		}
		
		/**
		 * 
		 * @param info
		 * 
		 */
		public override function fault( info : Object) : void
		{
			super.fault( info );
		}
		
		
		
		
	}
}