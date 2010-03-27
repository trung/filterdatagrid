package fdg.filters {
	public interface Filterable {
		function reset():void;
	
		function isFiltered(objValue:Object):Boolean;
		
		function get filterValue():Object;
		
		function set filterValue(fv:Object):void;
	}
}