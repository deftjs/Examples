###*
* Controls the scenario grid.
###
Ext.define( "Phoenix.controller.ScenarioGridController",
	extend: "Phoenix.controller.AbstractPhoenixController"
	requires: [ "Ext.data.UuidGenerator" ]


	observe:
		scenarioContext:
			initialDataLoaded: "loadScenarios"


	control:
		view:
			itemdblclick: "onEditScenario"
		addButton:
			click: "onAddButtonClick"
		scenarioActionColumn:
			click: "onActionColumnClick"


	config:
		uuidGenerator: Ext.create( "Ext.data.UuidGenerator" )


	init: ->
		@callParent( arguments )


	###*
	* Loads the set of {Phoenix.model.Scenario} models
	###
	loadScenarios: ->
		@getView().setLoading( true )

		@getScenarioService().loadScenarios().then(

			failure: ( errorMessage ) =>
				@getNotificationService().error( "Error", errorMessage )

		).always( =>
			@getView().setLoading( false )
		)


	###*
	* Deletes the passed {Phoenix.model.Scenario}.
	* @param {Phoenix.model.Scenario} Scenario to delete.
	###
	deleteScenario: ( scenario ) ->
		@getView().setLoading( true )

		@getScenarioService().deleteScenario( scenario ).then(

			success: =>
				@getScenarioContext().scenarioDeleted( scenario )
				@getNotificationService().success( "Success", "The scenario was deleted successfully." )

			failure: =>
				@getNotificationService().error( "Error", "Error deleting Scenario." )

		).always( =>
			@getView().setLoading( false )
		)


	###*
	* Handles a click on the add button and opens a new Scenario view.
	###
	onAddButtonClick: ->
		scenario = Ext.create( "Phoenix.model.Scenario",
			id: @getUuidGenerator().generate()
			name: "New Scenario"
		)
		@getScenarioContext().scenarioOpened( scenario )


	###*
	* Handles a request to edit a {Phoenix.model.Scenario} model.
	###
	onEditScenario: ( grid, scenario, row, rowIndex, event ) ->
		@getScenarioContext().scenarioOpened( scenario )


	###*
	* Handles a click on the grid's action column.
	###
	onActionColumnClick: ( view, cell, rowIndex, columnIndex, event, scenario, row ) ->
		Ext.MessageBox.confirm(
			"Confirm",
			"Are you sure you want to delete the this Scenario: #{ scenario.get( "name" ) }",
			( button ) -> @deleteScenario( scenario ) if button is "yes"
		,
			@
		)


)