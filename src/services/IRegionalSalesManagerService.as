package services
{

	public interface IRegionalSalesManagerService
	{
		function getRegionalSalesManagerById( regionalSalesManager : RegionalSalesManager ) : AsyncToken;

		function getSalesUnitsByRegionalSalesManagerId( regionalSalesManager : RegionalSalesManager ) : AsyncToken;

		function getAllRegionalSalesManagers() : AsyncToken;
	}
}