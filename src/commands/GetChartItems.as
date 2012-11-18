package commands
{
	import flash.utils.getDefinitionByName;
	
	import model.ApplicationModel;
	import model.beans.CartesianReportSeries;
	import model.beans.PieReportSeries;
	import model.beans.ReportItem;
	import model.beans.TabularColumn;
	
	import mx.collections.ArrayCollection;
	import mx.rpc.AsyncToken;
	
	import services.ServiceFactory;

	public class GetChartItems extends CommandAdapter
	{
		
		/**
		 * 
		 * 
		 */
		public override function execute() : void
		{
			var token : AsyncToken = ServiceFactory.getInstance().getChartService( this ).getData();
		}
		 
		/**
		 * 
		 * @param data
		 * 
		 */
		public override function result(data:Object):void
		{
			super.result( data );
			
			var appModel : ApplicationModel = ApplicationModel.getInstance();
			var reports : ArrayCollection = new ArrayCollection();
			
			for each ( var reportNode : XML in data.result.report )
			{
				var report : ReportItem = new ReportItem();
				report.id = reportNode.@id;
				report.type = reportNode.@type;
				report.command = reportNode.@command;
				report.commandArgs = parseCommandArgs( reportNode.commandArgs.args );
				report.drillDownChartId = reportNode.@drillDown;
				report.drillDownField = reportNode.@drillDownField;
				report.filterSlider = Boolean( parseInt( reportNode.@filterSlider ));
				report.hideMinimizedLabels = Boolean ( parseInt( reportNode.@hideMinimizedLabels ) );
				report.reportIcon = reportNode.@reportIcon;
				report.verticalAxisType = reportNode.axis.vertical.@type;
				report.verticalAxisField = reportNode.axis.vertical.@field;
				report.horizontalAxisType = reportNode.axis.horizontal.@type;
				report.horizontalAxisField = reportNode.axis.horizontal.@field;
				report.horizontalAxisLabelField = reportNode.axis.horizontal.@labelField;
				report.chartTitle = reportNode.labels.title;
				report.navLabel = reportNode.labels.navigation;
				report.xAxis = reportNode.labels.xAxis;
				report.yAxis = reportNode.labels.yAxis;
				
				report.cartesianSeries = parseCartesianSeries( reportNode.reportSeries.cartesianSeries );
				
				report.pieSeries = parsePieSeries( reportNode.reportSeries.pieSeries );
				report.tabularColumns = parseTabularColumns( reportNode.tabularColumns.tabularColumn );
				
				reports.addItem(report);
			}
			
			appModel.reports = reports;
			
			new GetNavItems().execute();
			new GetReportGroupItems().execute();
		}
		
		/**
		 * Parses the command arguments in the XML to be passed to
		 * the command's constructor.
		 *  
		 * @param args
		 * @return 
		 * 
		 */
		protected function parseCommandArgs( args : XMLList ) : Array
		{
			var argsArray : Array = new Array();
			var tempArgClass : Object;
			var tempArg : Object;
			var attrName : String;
			
			for each( var argNode : XML in args )
			{
				tempArgClass = getDefinitionByName( argNode.@type );
				
				tempArg = new tempArgClass();
				
				for each ( var argAttr : XML in argNode.attributes() )
				{
					attrName = argAttr.name();
					
					if ( attrName != "type" )
					{
						tempArg[ attrName ] = argAttr.toString();
					}
				}
				
				argsArray.push( tempArg );
			}
			
			return argsArray;
		}
		
		/**
		 * Parses the Tabular Column Series XML node to create
		 * TabularColumn beans as a result.
		 *  
		 * @param series
		 * @return 
		 * 
		 */
		protected function parseTabularColumns( series : XMLList ) : Array
		{
			var seriesArray : Array = new Array();
			var tempSeries : TabularColumn;
			
			for each( var seriesNode : XML in series )
			{
				tempSeries = new TabularColumn();
				
				tempSeries.dataField = seriesNode.@dataField;
				tempSeries.sortField = seriesNode.@sortField;
				tempSeries.type = seriesNode.@type;
				tempSeries.headerText = seriesNode.@headerText;
				tempSeries.isCurrency = Boolean( parseInt( seriesNode.@isCurrency ) );
				
				seriesArray.push( tempSeries );
			}
			
			return seriesArray;
		}
		
		/**
		 * Parses the Cartesian Series XML node and creates
		 * a CartesianReportSeries bean as a result.
		 *  
		 * @param series
		 * @return 
		 * 
		 */
		protected function parseCartesianSeries( series : XMLList ) : Array
		{
			var seriesArray : Array = new Array();
			var tempSeries : CartesianReportSeries;
			
			for each ( var seriesNode : XML in series )
			{
				tempSeries = new CartesianReportSeries();
				
				tempSeries.type = seriesNode.@type;
				tempSeries.xField = seriesNode.@xField;
				tempSeries.yField = seriesNode.@yField;
				tempSeries.displayName = seriesNode.@displayName;
				tempSeries.isXFieldCurrency = Boolean( parseInt( seriesNode.@isXFieldCurrency ) );
				tempSeries.isYFieldCurrency = Boolean( parseInt( seriesNode.@isYFieldCurrency ) );
				tempSeries.isXFieldPercentage = Boolean( parseInt( seriesNode.@isXFieldPercentage ) );
				tempSeries.isYFieldPercentage = Boolean( parseInt( seriesNode.@isYFieldPercentage ) );				
				
				seriesArray.push( tempSeries );
			}
			
			return seriesArray;
		}
		
		/**
		 * Parses the XML for the Pie Series, storing it
		 * in a PieReportSeries Bean.
		 *  
		 * @param series
		 * @return 
		 * 
		 */
		protected function parsePieSeries( series : XMLList ) : Array
		{
			var seriesArray : Array = new Array();
			var tempSeries : PieReportSeries;
			
			for each( var seriesNode : XML in series )
			{
				tempSeries = new PieReportSeries();
				
				tempSeries.type = seriesNode.@type;
				tempSeries.nameField = seriesNode.@nameField;
				tempSeries.field = seriesNode.@field;
				tempSeries.isCurrency = Boolean( parseInt( seriesNode.@isCurrency ) );
				
				seriesArray.push( tempSeries );
			}
			
			return seriesArray;
		}
	}
}