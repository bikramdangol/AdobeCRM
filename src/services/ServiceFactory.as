package services
{
	import mx.rpc.AbstractService;
	import mx.rpc.IResponder;
	import mx.rpc.http.HTTPService;
	import mx.rpc.remoting.mxml.RemoteObject;
	
	import services.remote.ClientDealServiceRemote;
	import services.remote.SalesForecastServiceRemote;
	import services.remote.SalesManagerServiceRemote;
	import services.remote.SalesQuotaServiceRemote;
	import services.remote.ServiceLoaderRemote;
	import services.remote.UserServiceRemote;
	import services.remote.XMLDataLoaderRemote;

	public class ServiceFactory
	{
		private var serviceLoaderService : HTTPService;
		private var navDefService : HTTPService;
		private var chartDefService : HTTPService;
		private var reportGroupsDefService : HTTPService;

		public var navURL : String;
		public var reportsURL : String;
		public var reportGroupsURL : String;

		private var clientDealService : AbstractService;
		private var salesForecastService : AbstractService;
		private var salesManagerService : AbstractService;
		private var salesRepService : AbstractService;
		private var salesQuotaService : AbstractService;
		private var userService : AbstractService;


		private static var instance : ServiceFactory;

		public static function getInstance() : ServiceFactory
		{
			if ( !instance )
			{
				instance = new ServiceFactory( new SingletonEnforcer() );
				instance.init();
			}

			return instance;
		}

		private function init() : void
		{
			serviceLoaderService = new HTTPService();
			serviceLoaderService.resultFormat = "e4x";

			navDefService = new HTTPService();
			navDefService.resultFormat = "e4x";

			chartDefService = new HTTPService();
			chartDefService.resultFormat = "e4x";

			reportGroupsDefService = new HTTPService();
			reportGroupsDefService.resultFormat = "e4x";

		
		}
		
		// Adding the dates to the URLs is a sort of a ‘cache-busting’ technique for loading XML files.
		// Browsers are notorious for hanging on to XML files even though a newer version of the file might exist on the server.
		// This technique of appending the current time in milliseconds to the URL request (i.e. the query string )
		// forces the browser to read the file we’re requesting from the server every time, as opposed to reading
		// the file from the its cache if the file has been previously downloaded.
			
		public function getServiceLoader( path : String , resp : IResponder ) : IXMLHTTPLoader
		{
			var d : Date = new Date();
			
			serviceLoaderService.url = path;
			return new ServiceLoaderRemote( serviceLoaderService , resp );
		}

		public function getNavService( resp : IResponder ) : IXMLHTTPLoader
		{
			var d : Date = new Date();
			
			navDefService.url = navURL;
			return new XMLDataLoaderRemote( navDefService , resp );
		}

		public function getReportGroupsService( resp : IResponder ) : IXMLHTTPLoader
		{
			var d : Date = new Date();
			
			reportGroupsDefService.url = reportGroupsURL;
			return new XMLDataLoaderRemote( reportGroupsDefService , resp );
		}

		public function getChartService( resp : IResponder ) : IXMLHTTPLoader
		{
			var d : Date = new Date();
			
			chartDefService.url = reportsURL;
			return new XMLDataLoaderRemote( chartDefService , resp );
		}

		public function getClientDealService( resp : IResponder ) : IClientDealService
		{ 
			var destPath : String = "clientDealService";

			// create new remote service, pass it the remote object and the responder and return it
			if ( !clientDealService )
			{
				clientDealService = new RemoteObject();
				RemoteObject( clientDealService ).destination = destPath;
				RemoteObject( clientDealService ).showBusyCursor = true;
			}

			return new ClientDealServiceRemote( clientDealService , resp );
		}

		public function getSalesForecastService( resp : IResponder ) : ISalesForecastService
		{
			var destPath : String = "salesForecastService";

			// create new remote service, pass it the remote object and the responder and return it
			if ( !salesForecastService )
			{
				salesForecastService = new RemoteObject();
				RemoteObject( salesForecastService ).destination = destPath;
				RemoteObject( salesForecastService ).showBusyCursor = true;
			}

			return new SalesForecastServiceRemote( salesForecastService , resp );
		}

		public function getSalesManagerService( resp : IResponder ) : ISalesManagerService
		{
			var destPath : String = "salesManagerService";

			// create new remote service, pass it the remote object and the responder and return it
			if ( !salesManagerService )
			{
				salesManagerService = new RemoteObject();
				RemoteObject( salesManagerService ).destination = destPath;
				RemoteObject( salesManagerService ).showBusyCursor = true;
			}

			return new SalesManagerServiceRemote( salesManagerService , resp );
		}

		public function getSalesQuotaService( resp : IResponder ) : ISalesQuotaService
		{
			var destPath : String = "salesQuotaService";

			// create new remote service, pass it the remote object and the responder and return it
			if ( !salesQuotaService )
			{
				salesQuotaService = new RemoteObject();
				RemoteObject( salesQuotaService ).destination = destPath;
				RemoteObject( salesQuotaService ).showBusyCursor = true;
			}

			return new SalesQuotaServiceRemote( salesQuotaService , resp );
		}

		public function getUserService( path : String , resp : IResponder ) : IUserService
		{
			var destPath : String = "userService";

			// create new remote service, pass it the remote object and the responder and return it
			if ( !userService )
			{
				userService = new RemoteObject();
				RemoteObject( userService ).destination = destPath;
				RemoteObject( userService ).showBusyCursor = true;
			}

			return new UserServiceRemote( userService , resp );
		}

		public function ServiceFactory( singletonEnforcer : SingletonEnforcer )
		{
		}
	}
}

class SingletonEnforcer
{
}