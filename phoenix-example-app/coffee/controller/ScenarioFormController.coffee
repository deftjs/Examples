###*
* Controls the scenario form UI.
###
Ext.define( "Phoenix.controller.ScenarioFormController",
	extend: "Phoenix.controller.AbstractPhoenixController"
	requires: [ "Phoenix.model.AffectedItem" ]


	config:
		###*
		* The {Phoenix.model.Scenario} being displayed by the view.
		###
		scenario: null


	control:
		view:
			boxready: "onBoxReady"
		saveButton:
			click: "onSaveButtonClick"
		copyButton:
			click: "onCopyButtonClick"
		addButton:
			click: "addScenarioItem"
		scenarioItemGrid: true
		scenarioItemActionColumn:
			click: "onActionColumnClick"


	init: ->
		@callParent( arguments )


	###*
	* Performs initial view setup.
	###
	onBoxReady: ->
		@setScenario( @getView().getScenario() )
		@getView().loadRecord( @getScenario() )
		if( @getScenarioService().isNewScenario( @getScenario() ) )
			@getCopyButton().setVisible( false )


	###*
	* Handles a click on the save button.
	###
	onSaveButtonClick: ->
		@getView().getForm().updateRecord( @getScenario() )
		if( not @getScenario().hasInvalidScenarioItems() )
			@saveScenario( @getScenario() )


	###*
	* Saves the passed {Phoenix.model.Scenario}.
	* @param {Phoenix.model.Scenario} Scenario to save.
	###
	saveScenario: ( scenario ) ->
		@getView().setLoading( true )

		@getScenarioService().saveScenario( scenario ).then(

			success: =>

				@getView().setTitle( scenario.get( "name" ) )

				if( @getView().itemId isnt "scenarioPanel_#{ scenario.getId() }" )
					@getView().itemId = "scenarioPanel_#{ scenario.getId() }"

				@getCopyButton().setVisible( true )
				@getNotificationService().success( "Success", "The scenario was saved successfully." )

			failure: =>
				@getNotificationService().error( "Error", "Error saving the Scenario" )

		).always( =>
			@getView().setLoading( false )
		)


	###*
	* Copies the passed {Phoenix.model.Scenario}.
	* @param {Phoenix.model.Scenario} Scenario to copy.
	###
	saveScenarioCopy: ( scenario ) ->
		@getView().setLoading( true )

		@getScenarioService().saveScenario( scenario ).then(

			success: =>
				@getNotificationService().success( "Success", "The scenario was copied successfully." )
				@getScenarioContext().scenarioOpened( scenario )


			failure: =>
				@getNotificationService().error( "Error", "Error copying the Scenario" )

		).always( =>
			@getView().setLoading( false )
		)


	###*
	* Adds a new {Phoenix.model.ScenarioItem} to the set of items associated with the current {Phoenix.model.Scenario}.
	###
	addScenarioItem: ->
		scenarioItem = Ext.create( "Phoenix.model.ScenarioItem" )
		@getScenarioItemGrid().getStore().insert( 0, scenarioItem )
		scenarioItem.setUpDefaults()

		@getScenarioItemGrid().cellEditing.startEditByPosition(
			row: 0
			column: 0
		)


	###*
	* Handles a click on a row's action column.
	###
	onActionColumnClick: ( view, cell, rowIndex, columnIndex, event, scenarioItem, row ) ->
		Ext.MessageBox.confirm(
			"Confirm",
			"Are you sure you want to delete the this Scenario Item?",
			( button ) -> @deleteScenarioItem( scenarioItem ) if button is "yes"
		,
			@
		)


	###*
	* Deletes the passed {Phoenix.model.ScenarioItem}.
	* @param {Phoenix.model.ScenarioItem} ScenarioItem to delete.
	###
	deleteScenarioItem: ( scenarioItem ) ->
		@getScenario().scenarioItems().remove( scenarioItem )
		@getNotificationService().info( "Change Pending", "Scenario Item removed. Save the Scenario to persist the change." )


	###*
	* Handles a click on the copy button.
	###
	onCopyButtonClick: ->
		copyOfScenario = @getScenario().copy()
		@saveScenarioCopy( copyOfScenario )

)