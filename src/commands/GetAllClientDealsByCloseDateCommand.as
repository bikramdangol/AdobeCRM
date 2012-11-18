package commands
{
	import model.ApplicationModel;
	import model.beans.ClientDeal;
	
	import mx.collections.ArrayCollection;
	import mx.collections.IViewCursor;
	import mx.collections.Sort;
	import mx.collections.SortField;
	import mx.resources.ResourceManager;
	import mx.rpc.events.ResultEvent;
	
	import services.ServiceFactory;

	[ResourceBundle("crm")]

	public class GetAllClientDealsByCloseDateCommand extends CommandAdapter
	{
		private var serviceFactory : ServiceFactory = ServiceFactory.getInstance();
		private var appModel : ApplicationModel = ApplicationModel.getInstance();
		
		public override function execute() : void
		{
			serviceFactory.getClientDealService( this ).getAllClientDeals();
		}
		
		override public function result( data : Object ) : void
		{
			// Do the processing for weeks
			
			var tempObject : ArrayCollection = createCloseWeekForDeals( data );
			
			var resultEvent : ResultEvent = new ResultEvent( data.type, data.bubbles, data.cancelable, tempObject as Object );
			
			super.result( resultEvent );
			
		}
		
		protected function createCloseWeekForDeals( data : Object ) : ArrayCollection
		{
			
			if ( !data )
			{
				return null;
			}
			
			var result : ArrayCollection = data.result as ArrayCollection;
			
			// 	Create sort and sort the arrayCollection
			//	based on clientDealId
			
			var sortField : SortField = new SortField( "clientDealId", true, false, true );
			
			var dealSortFields : Array = new Array();
				dealSortFields.push( sortField );
			
			var dealSort : Sort = new Sort();
				dealSort.fields = dealSortFields;
			
			result.sort = dealSort;
			result.refresh();
			
			//	Get the time from Jan 1st this year
			//	till UTC to subtract from the clientDeals
			//	estimatedCloseDate
			
			var clientWeeksCollection : ArrayCollection = new ArrayCollection();
			var weekObj : Object;
			var filteredDeals : IViewCursor;
			var curTotalRev : Number;

			// Process the data into the appropriate week and
			// build objects with the data needed for the charts
			
			for ( var i : int = 1; i <= 52; i++ )
			{
				curTotalRev = 0;
				
				// This object will store the data needed for the chart

				weekObj = {
							// X or Y axis label
							label : ResourceManager.getInstance().getString("crm", "labels.week") + i,
							
							// The closing week of the object
							closeWeekNumber : i,
							
							// Will store the clienDeals closing this week
							clientDealSet : new ArrayCollection(),
							
							// Will store sum of revenues of the clientDeals
							totalRevenue : 0
						};
				
				// Filters out the clientDeals for the ones closing this week
				
				result.filterFunction = function( item : Object ) : Boolean
				{
					return ( item as ClientDeal ).closeWeekNumber == i;
				};
				
				result.refresh();
				
				filteredDeals = result.createCursor();
				
				// Move through the filtered clientDeals to add them to the object's
				// collection and to sum the indiividual revenues
				
				while( filteredDeals.moveNext() )
				{
					curTotalRev = curTotalRev + ( filteredDeals.current as ClientDeal ).estimatedRevenue;
					weekObj.clientDealSet.addItem( filteredDeals.current );
				}
				
				weekObj.totalRevenue = curTotalRev;
				
				clientWeeksCollection.addItem( weekObj );
			}
			
			return clientWeeksCollection; 
		}
		
	}
}