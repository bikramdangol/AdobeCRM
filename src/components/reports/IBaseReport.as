package components.reports
{
	import model.beans.ReportItem;
	
	import mx.core.IVisualElement;

	public interface IBaseReport
	{
		function get reportBean() : ReportItem;

		function set reportBean( value : ReportItem ) : void;
		
		function get reportState() : String;
		
		function set reportState( value : String ) : void;
	}
}