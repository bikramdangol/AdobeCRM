package components.reports
{
	import mx.collections.ArrayCollection;

	[Event( name="chartDataProviderChanged" , type = "flash.events.Event" )]
	[Event( name="collectionChange" , type = "mx.events.CollectionEvent" )]
	public interface IBaseChartReport extends IBaseReport
	{
		function get chartDataProvider() : ArrayCollection;

		function set chartDataProvider( value : ArrayCollection ) : void;
	}
}