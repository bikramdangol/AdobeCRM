package components.reports
{
	import flash.utils.getDefinitionByName;
	
	import model.beans.TabularColumn;
	
	import mx.controls.DataGrid;
	import mx.controls.dataGridClasses.DataGridColumn;
	import mx.formatters.CurrencyFormatter;
	import mx.formatters.NumberBaseRoundType;
	import mx.formatters.NumberFormatter;
	
	import utils.PropertyUtils;

	public class TabularDataReport extends BaseChart implements IBaseTabularReport
	{
		[Bindable]
		public var dataGridComponent : DataGrid;
		
		private var dataGridColumnsChanged : Boolean = false;

		private var _dataGridColumns : Array = new Array();

		[Bindable( event="dataGridColumnsChanged" )]
		public function get dataGridColumns() : Array
		{
			return _dataGridColumns;
		}

		public function set dataGridColumns( value : Array ) : void
		{
			if ( !value )
			{
				return;
			}

			dataGridColumnsChanged = true;

			_dataGridColumns = value;

			dispatchEvent( new Event( "dataGridColumnsChanged" ));

			invalidateProperties();
		}

		protected function fillDataGridColumns( columns : Array ) : void
		{
			if ( !columns )
			{
				return;
			}

			if ( !dataGridComponent )
			{
				callLater( fillDataGridColumns , [ columns ]);
				return;
			}

			var columnsLen : int = columns.length;
			var columnClass : Object;
			var tabColumn : TabularColumn;
			var column : DataGridColumn;
			

			var tempColColumns : Array = new Array();

			for ( var i : int = 0 ; i < columnsLen ; i++ )
			{
				// get the TabularColumn bean from the columns array
				tabColumn = ( columns[ i ] as TabularColumn );

				// 	get the Class reference to the columns type
				//	or subtype to instantiate and pass to
				//	tempcolumns
				columnClass = getDefinitionByName( tabColumn.type );

				column = new columnClass() as DataGridColumn;
				column.dataField = tabColumn.dataField;
				column.labelFunction = colLabelFunc;
				column.headerText = tabColumn.headerText;
				column.resizable = true;

				tempColColumns.push( column );
			}

			dataGridColumns = tempColColumns;
			
		}

		public function colLabelFunc( item : Object , column : DataGridColumn ) : Object
		{
			var colLabel : Object;
			var currencyFormatter : CurrencyFormatter;
			var numFormatter : NumberFormatter;
			var colIndex : int = dataGridComponent.columns.indexOf( column );
			var tabColumn : TabularColumn = reportBean.tabularColumns[ colIndex ];

			colLabel = PropertyUtils.parseObjectChain( column.dataField , item );

			if ( colLabel is Number )
			{
				numFormatter = new NumberFormatter();
				numFormatter.precision = 2;
				
				colLabel = numFormatter.format( colLabel );
				
				if ( tabColumn.isCurrency )
				{
					currencyFormatter = new CurrencyFormatter();
					currencyFormatter.rounding = NumberBaseRoundType.NEAREST;
					currencyFormatter.precision = 0;
	
					colLabel = currencyFormatter.format( colLabel );
				}
			}

			return colLabel;
		}
		
		override protected function commitProperties() : void
		{
			if ( reportBeanChanged )
			{
				reportBeanChanged = false;

				callDataProviderCommand();
				fillDataGridColumns( _reportBean.tabularColumns );
			}

			if ( dataGridColumnsChanged )
			{
				dataGridColumnsChanged = false;

				dataGridComponent.columns = dataGridColumns;

				dataGridComponent.invalidateDisplayList();
			}
		}
	}
}