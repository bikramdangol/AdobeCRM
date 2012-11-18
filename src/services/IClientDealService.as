package services
{
	import model.beans.Region;
	import model.beans.StatusType;
	import model.beans.User;
	
	import mx.rpc.AsyncToken;

	public interface IClientDealService
	{
		function getAllClientDeals() : AsyncToken;

		function getAllClientDealsByStatus() : AsyncToken;
		
		function getClientDealsByStatusTypeId( status : StatusType ) : AsyncToken;
		
		function getTop10ClientDeals() : AsyncToken;

		function getTop10ClientDealsByRegionId( region : Region ) : AsyncToken;

		function getTop10ClientDealsByUserId( user : User, lBoundDate : Date = null, uBoundDate : Date = null ) : AsyncToken;
	}
}