package components.reports
{
	[Event( name="dataGridDataProviderChanged" , type = "flash.events.Event" )]
	[Event( name="collectionChange" , type = "mx.events.CollectionEvent" )]
	public interface IBaseTabularReport extends IBaseReport
	{
		function get dataGridColumns() : Array;

		function set dataGridColumns( value : Array ) : void;
	}
}