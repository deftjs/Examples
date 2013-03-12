###*
* Controls the main (root) UI container for the application.
###
Ext.define( "Phoenix.controller.MainPanelController",
	extend: "Phoenix.controller.AbstractPhoenixController"
	requires: [ "Phoenix.view.ScenarioForm" ]


	observe:
		scenarioContext:
			scenarioOpened: "onScenarioOpened"
			scenarioDeleted: "onScenarioDeleted"


	control:
		view:
			boxready: "loadInitialData"


	init: ->
		@callParent( arguments )


	###*
	* Loads the initial reference dta.
	###
	loadInitialData: ->
		@getView().setLoading( true )

		@getScenarioService().loadInitialData().then(

			success: =>
				@getScenarioContext().initialDataLoaded()

			failure: ( errorMessage ) =>
				@getNotificationService().error( "Error", errorMessage )

		).always( =>
			@getView().setLoading( false )
		)


	###*
	* Responds when a {Phoenix.model.Scenario} view is opened.
	* @param {Phoenix.model.Scenario} Scenario being opened.
	###
	onScenarioOpened: ( scenario ) ->

		existingScenarioPanel = @findExistingTab( scenario )

		if( existingScenarioPanel? )
			existingScenarioPanel.show()

		else
			@getView().add(
				xtype: "phoenix-view-scenarioForm"
				itemId: "scenarioPanel_#{ scenario.getId() }"
				title: scenario.get( "name" )
				closable: true
				scenario: scenario
			).show()


	###*
	* Responds when a {Phoenix.model.Scenario} is deleted.
	* @param {Phoenix.model.Scenario} Scenario being deleted.
	###
	onScenarioDeleted: ( scenario ) ->
		existingScenarioPanel = @findExistingTab( scenario )
		existingScenarioPanel.close() if existingScenarioPanel?


	###*
	* Locates a view for the specified {Phoenix.model.Scenario}. If not view is open, returns null.
	* @param {Phoenix.model.Scenario} Scenario to locate a view for.
	* @return {Phoenix.view.ScenarioForm}
	###
	findExistingTab: ( scenario ) ->
		return @getView().child( "#scenarioPanel_#{ scenario.getId() }" )

)