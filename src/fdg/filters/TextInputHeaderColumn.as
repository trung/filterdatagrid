package fdg.filters {
import fdg.filters.renderer.TextInputHeaderRenderer;

import flash.events.Event;

import mx.controls.dataGridClasses.DataGridColumn;
import mx.core.ClassFactory;

/**
 *  Dispatched when the TextInput contents changes as a result of user
 *  interaction, 
 *
 *  @eventType flash.events.Event.CHANGE
 */
[Event(name="change", type="flash.events.Event")]

public class TextInputHeaderColumn extends DataGridColumn implements Filterable {

	public function TextInputHeaderColumn()	{
		super();
		super.headerRenderer = new ClassFactory(TextInputHeaderRenderer);
	}

	[Bindable] public var _filterText:String = "";
	
	public function reset():void {
		this._filterText = "";
		// this.dispatchEvent(new Event("change"));
	}
	
	public function isFiltered(objValue:Object):Boolean {
		var regex:RegExp = new RegExp(this._filterText, "i");
		var str:String = objValue.toString();
		return regex.exec(str) != null;
	}
	
	public function get filterValue():Object {
		return _filterText;
	}
 
	public function set filterValue(fv:Object):void {
		this._filterText = String(fv);
		//this.dispatchEvent(new Event("change"));
	}
}

}