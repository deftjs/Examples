###*
* Fire events related to the scenario UI, which other objects can respond to.
###
Ext.define( "Phoenix.context.ScenarioContext",
	extend: "Phoenix.context.AbstractContext"


	###*
	* Constructor.
	###
	constructor: ( config={} ) ->
		@callParent( arguments )

		@addEvents(
			"initialDataLoaded"
			"scenarioOpened"
			"scenarioDeleted"
		)


	###*
	* Notifies interested objects that initial data has been loaded.
	###
	initialDataLoaded: ->
		###*
		* @event initialDataLoaded Initial data loaded.
		###
		@fireEvent( "initialDataLoaded" )


	###*
	* Notified interested objects that a scenario is being opened.
	* @param {Phoenix.model.Scenario} Scenario The Scenario being opened.
	###
	scenarioOpened: ( scenario ) ->
		###*
		* @event scenarioOpened Scenario opened.
  	* @param {Phoenix.model.Scenario} Scenario The Scenario being opened.
		###
		@fireEvent( "scenarioOpened", scenario )


	###*
	* Notified interested objects that a scenario is being deleted.
	* @param {Phoenix.model.Scenario} Scenario The Scenario being deleted.
	###
	scenarioDeleted: ( scenario ) ->
		###*
		* @event scenarioDeleted Scenario deleted.
		* @param {Phoenix.model.Scenario} Scenario The Scenario being deleted.
		###
		@fireEvent( "scenarioDeleted", scenario )
)