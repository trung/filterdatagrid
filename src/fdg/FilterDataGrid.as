
package fdg {
	import fdg.filters.Filterable;
	import fdg.filters.TextInputHeaderColumn;
	
	import flash.events.Event;
	import flash.utils.Dictionary;
	
	import mx.controls.DataGrid;
	import mx.controls.dataGridClasses.DataGridColumn;

	/**
	 * @author Trung
	 * @version 1.0
	 */
	public class FilterDataGrid extends DataGrid {
		
		private var _columnsDefinition:XML;
		
		private var columnsDictionary:Dictionary = new Dictionary(); // Mapping dataField -> DataGridColumn
				
		public function FilterDataGrid() {
			super();
		}

		public function set filtersDictionary(fd:Dictionary):void {
			for each (var dgc:DataGridColumn in this.columns) {
				if (dgc.visible && dgc is Filterable) {
					var filterValue:Object = fd[dgc.dataField];
					if (filterValue != null) {
						Filterable(dgc).filterValue = filterValue;
					} else {
						Filterable(dgc).reset();
					}
				}
			}
			updateFilters();
		}
		
		public function resetFilters():void {
			for each (var dgc:DataGridColumn in this.columns) {
					if (dgc is Filterable) {
						Filterable(dgc).reset();
						dgc.visible = true;
					}
				}
			this.dataProvider.filterFunction = null;
			this.dataProvider.refresh();
		}
		
		override public function set columns(value:Array):void {
			super.columns = value;
			// add listeners
			for each (var dgc:DataGridColumn in columns) {
				if (dgc is Filterable) {
					dgc.addEventListener(Event.CHANGE, onFilterChangeEvent);
				}
				if (dgc.dataField != null) this.columnsDictionary[dgc.dataField] = dgc;
			}
		}
		
		public function get filtersDictionary():Dictionary {
			var filterValuesDictionary:Dictionary = new Dictionary();
			for each (var dgc:DataGridColumn in this.columns) {
				if (dgc.visible && dgc is Filterable) {
					filterValuesDictionary[dgc.dataField] = Filterable(dgc).filterValue;
				}
			}
			return filterValuesDictionary;
		}
			
		public function get columnsDefinition():XML {
			return this._columnsDefinition;
		}
		
		[Bindable]
		public function set columnsDefinition(cd:XML):void {
			this._columnsDefinition = cd;
			this.renderGrid();
		}
		
		private function renderGrid():void {
			/*var gridColumnsRef:ArrayCollection = new ArrayCollection(this.columns);
			for each (var col:Object in _columnsDefinition.column) {
				var dgc:TextInputHeaderColumn = new TextInputHeaderColumn();
				dgc.headerText = col.label;
				dgc.dataField = col.dataField;				
				dgc.visible = col.visible;
				dgc.headerWordWrap = true;
				// dgc.draggable = false;
				dgc.sortable = true;
				dgc.headerRenderer = new ClassFactory(TextInputHeaderRenderer);
				if (col.hasOwnProperty("align")) {
					dgc.setStyle("textAlign", col.align);
				}					
				if (col.hasOwnProperty("width")) {
					dgc.width = col.width;
				} else { 
					dgc.width = 100;
				}
				dgc.addEventListener(Event.CHANGE, onFilterChangeEvent);
				columnsDictionary[col.dataField] = dgc;
				gridColumnsRef.addItem(dgc);
			}
			this.columns = gridColumnsRef.toArray();*/
		}
		
		private function onFilterChangeEvent(evt:Event):void {
			updateFilters();
		}
		
		public function columnVisibility(dataField:String, visible:Boolean):void {
			var dgc:DataGridColumn = columnsDictionary[dataField] as DataGridColumn;
			if (dgc != null) {
				dgc.visible = visible;					
			}				
		}
		
		private function updateFilters():void {
			this.dataProvider.filterFunction = function(obj:Object):Boolean {
				var stay:Boolean = true;
				for each (var dgc:DataGridColumn in columns) {
					if (dgc.visible && dgc is Filterable) {
						if (Filterable(dgc).isFiltered(obj[dgc.dataField])) {
							stay = false;
							break;
						}
					}
					/*
					if (dgc.visible && dgc is TextInputHeaderColumn) {
						var filterValue:String = TextInputHeaderColumn(dgc).filterValue;
						if (filterValue != "") {
							var regex:RegExp = new RegExp(filterValue, "i");
							var str:String = obj[dgc.dataField];
							if (regex.exec(str) == null) {
								stay = false;
								break;
							}
						}
					} */
				}
				return stay;
			};
			this.dataProvider.refresh();
		}
		
	}
}