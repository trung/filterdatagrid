package fdg.filters
{
import fdg.filters.renderer.ComboBoxHeaderRenderer;

import flash.events.Event;

import mx.controls.dataGridClasses.DataGridColumn;
import mx.core.ClassFactory;

/**
 *  Dispatched when the ComboBox contents changes as a result of user
 *  interaction, when the <code>selectedIndex</code> or
 *  <code>selectedItem</code> property changes, and, if the ComboBox control
 *  is editable, each time a keystroke is entered in the box.
 *
 *  @eventType mx.events.ListEvent.CHANGE
 */
[Event(name="change", type="mx.events.ListEvent")]

public class ComboBoxHeaderColumn extends DataGridColumn
{

	public function ComboBoxHeaderColumn()
	{
		super();
		super.headerRenderer = new ClassFactory(ComboBoxHeaderRenderer);
	}

	/**
	 *  The data provider for the combobox
	 */
	public var comboBoxDataProvider:Object;
	
	/**
	 * Auto feed the comboBoxDataProvider with the grid data
	 */
	public var comboBoxDataProviderAuto:Boolean = false;

	/**
	 *  The current combobox selectedIndex
	 */
	public var selectedIndex:int = 0;

	/**
	 *  The current combobox selectedItem
	 */
	public var selectedItem:Object;
	
	public function reset():void {
		this.selectedIndex = 0;
		// this.dispatchEvent(new Event("change"));
	}
	
	public function isFiltered(objValue:Object):Boolean {
		if (selectedIndex == 0) return false;
		return selectedItem.toString() == objValue.toString();
	}
	
	public function get filterValue():Object {
		return selectedItem;
	}

	public function set filterValue(fv:Object):void {
		this.selectedItem = fv;
		// this.dispatchEvent(new Event("change"));
	}
	
}

}