package services.remote
{
	import model.beans.User;
	
	import mx.rpc.AbstractOperation;
	import mx.rpc.AbstractService;
	import mx.rpc.AsyncToken;
	import mx.rpc.IResponder;
	
	import services.ISalesQuotaService;

	public class SalesQuotaServiceRemote implements ISalesQuotaService
	{
		private var service : AbstractService;
		private var resp : IResponder;
		
		/**
		 * 
		 * @param service
		 * @param resp
		 * 
		 */
		public function SalesQuotaServiceRemote( service : AbstractService, resp : IResponder )
		{
			this.service = service;
			this.resp = resp;
		}
		
		/**
		 * 
		 * @param user
		 * @return 
		 * 
		 */
		public function getSalesQuotasByUserId( user : User ) : AsyncToken
		{
			var abstractOp : AbstractOperation = service.getOperation( "getSalesQuotasByUserId" );
			abstractOp.arguments = [ user ];

			var token : AsyncToken = abstractOp.send();
			token.addResponder( resp );

			return token;
		}
		
		/**
		 * 
		 * @return 
		 * 
		 */
		public function getAllSalesQuotas() : AsyncToken
		{
			var abstractOp : AbstractOperation = service.getOperation( "getAllSalesQuotas" );

			var token : AsyncToken = abstractOp.send();
			token.addResponder( resp );

			return token;
		}
	}
}