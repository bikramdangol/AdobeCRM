package components.reports
{
	import model.beans.ReportItem;

	[Event( name="close" , type = "components.reports.events.ReportViewEvent" )]
	[Event( name="maximize" , type = "components.reports.events.ReportViewEvent" )]
	public interface IBasePod
	{
		function get reportBean() : ReportItem;
		
		function set reportBean( value : ReportItem ) : void;
		
		function get reportView() : IBaseReport;

		function set reportView( value : IBaseReport) : void;
	}
}