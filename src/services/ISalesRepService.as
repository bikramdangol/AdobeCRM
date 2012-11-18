package services
{
	import model.beans.User;
	
	import mx.rpc.AsyncToken;

	public interface ISalesRepService
	{
		function getAllSalesReps() : AsyncToken;

		function getSalesRepByUserId( user : User ) : AsyncToken;
	}
}