###*
Collection of Probability objects.
###
Ext.define( "Phoenix.store.ProbabilityStore",
	extend: "Ext.data.ArrayStore"
	requires: [ "Phoenix.model.Probability" ]


	model: "Phoenix.model.Probability"
	autoLoad: false


	proxy:
		type: "memory"


	###*
  Simulate loading the Probability objects
	###
	load: ( options ) ->
		data = [
			{ id: 1, value: "Very Low (Less Than 10%)" }
			{ id: 2, value: "Low (10-30%)" }
			{ id: 3, value: "Moderate (30-50%)" }
			{ id: 4, value: "Significant (50-70%)" }
			{ id: 5, value: "High (70-90%)" }
			{ id: 6, value: "Very High (More than 90%)" }
		]

		@loadData( data )
		options.callback( @data.items, {}, true )

)