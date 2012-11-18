package model.beans
{
	

	[Bindable]
	public class ReportItem
	{
		public var id : int;

		public var type : String;

		public var command : String;

		public var commandArgs : Array;

		public var drillDownChartId : int;

		public var drillDownField : String;
		
		public var filterSlider : Boolean;

		public var hideMinimizedLabels : Boolean;
		
		public var reportIcon : String;

		public var verticalAxisType : String;

		public var verticalAxisField : String;

		public var horizontalAxisType : String;

		public var horizontalAxisField : String;

		public var horizontalAxisLabelField : String;
		
		public var navLabel : String;
		
		public var xAxis : String;
		
		public var yAxis : String;

		public var chartTitle : String;
		
		public var cartesianSeries : Array;
		
		public var pieSeries : Array;
		
		public var tabularColumns : Array;
	}
}