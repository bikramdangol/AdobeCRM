package services.remote
{
	import model.beans.Region;
	import model.beans.StatusType;
	import model.beans.User;
	
	import mx.rpc.AbstractOperation;
	import mx.rpc.AbstractService;
	import mx.rpc.AsyncToken;
	import mx.rpc.IResponder;
	
	import services.IClientDealService;

	public class ClientDealServiceRemote implements IClientDealService
	{
		private var service : AbstractService;
		private var resp : IResponder;

		public function ClientDealServiceRemote( service : AbstractService, resp : IResponder )
		{
			this.service = service;
			this.resp = resp;
		}

		public function getAllClientDeals() : AsyncToken
		{
			var abstractOp : AbstractOperation = service.getOperation( "getAllClientDeals" );

			var token : AsyncToken = abstractOp.send();
			token.addResponder( resp );

			return token;
		}

		public function getAllClientDealsByStatus() : AsyncToken
		{
			var abstractOp : AbstractOperation = service.getOperation( "getAllClientDealsByStatus" );

			var token : AsyncToken = abstractOp.send();
			token.addResponder( resp );

			return token;
		}
		
		public function getClientDealsByStatusTypeId( statusType : StatusType ) : AsyncToken
		{
			var abstractOp : AbstractOperation = service.getOperation( "getClientDealsByStatusTypeId" );
			abstractOp.arguments = [ statusType ];
			
			var token : AsyncToken = abstractOp.send();
			token.addResponder( resp );
			
			return token;
		}

		public function getTop10ClientDeals() : AsyncToken
		{
			var abstractOp : AbstractOperation = service.getOperation( "getTop10ClientDeals" );

			var token : AsyncToken = abstractOp.send();
			token.addResponder( resp );

			return token;
		}

		public function getTop10ClientDealsByRegionId( region : Region ) : AsyncToken
		{
			var abstractOp : AbstractOperation = service.getOperation( "getTop10ClientDealsByRegionId" );
			abstractOp.arguments = [ region ];

			var token : AsyncToken = abstractOp.send();
			token.addResponder( resp );

			return token;
		}

		public function getTop10ClientDealsByUserId( user : User, lBoundDate : Date = null, uBoundDate : Date = null ) : AsyncToken
		{
			var abstractOp : AbstractOperation = service.getOperation( "getTop10ClientDealsByUserId" );
			abstractOp.arguments = [ user, lBoundDate, uBoundDate ];

			var token : AsyncToken = abstractOp.send();
			token.addResponder( resp );

			return token;
		}

	}
}