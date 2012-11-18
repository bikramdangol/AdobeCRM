package services
{
	import model.beans.User;

	import mx.rpc.AsyncToken;

	public interface ISalesManagerService
	{
		function getAllSalesManagers() : AsyncToken;

		function getSalesManagerByUserId( user : User ) : AsyncToken;

		function getSalesRepsBySalesManagerUserId( user : User ) : AsyncToken;
	}
}