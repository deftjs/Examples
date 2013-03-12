###*
Collection of Items potentially affected by a disaster.
###
Ext.define( "Phoenix.store.AffectedItemStore",
	extend: "Ext.data.ArrayStore"
	requires: [ "Phoenix.model.RevenueImpact" ]


	model: "Phoenix.model.AffectedItem"
	autoLoad: false


	proxy:
		type: "memory"


	sorters: [
		property: "value"
		direction: "ASC"
	]

	###*
	Simulate loading the Affected Items
	###
	load: ( options ) ->
		data = [
			{ id: 1, value: "Server - Web" }
			{ id: 2, value: "Server - Mail" }
			{ id: 3, value: "Server - NAS" }
			{ id: 4, value: "Server - Intranet" }
			{ id: 5, value: "Server - Database" }
			{ id: 6, value: "Server - Analytics" }
			{ id: 7, value: "Phone - PBX" }
			{ id: 8, value: "Network - Router" }
			{ id: 9, value: "Network - Firewall" }
			{ id: 10, value: "Hardware - Printer" }
			{ id: 11, value: "Physical - Patient Records" }
			{ id: 12, value: "Physical - Office" }
			{ id: 13, value: "Hardware - Receptionist Computer" }
			{ id: 14, value: "Physical - Electrical System" }
		]

		@loadData( data )
		options.callback( @data.items, {}, true )

)