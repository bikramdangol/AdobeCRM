package services.remote
{
	import mx.rpc.AsyncToken;
	import mx.rpc.IResponder;
	import mx.rpc.http.HTTPService;

	import services.IXMLHTTPLoader;

	public class XMLDataLoaderRemote implements IXMLHTTPLoader
	{
		private var service : HTTPService;
		private var resp : IResponder;

		public function XMLDataLoaderRemote( service : HTTPService , resp : IResponder )
		{
			this.service = service;
			this.resp = resp;
		}

		public function getData() : AsyncToken
		{
			var token : AsyncToken = service.send();
			token.addResponder( resp );
			return token;
		}

	}
}