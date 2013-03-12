###*
Collection of {Phoenix.model.ScenarioItem} models.
###
Ext.define( "Phoenix.store.ScenarioItemStore",
	extend: "Ext.data.Store"
	alias: "store.scenarioItemStore"
	requires: [ "Phoenix.model.ScenarioItem" ]
	inject: [ "appConfig" ]


	config:
		appConfig: null


	model: "Phoenix.model.ScenarioItem"
	autoLoad: true


	###*
	* Constructor.
	###
	constructor: ( cfg={} ) ->
		@initConfig( cfg )

		Ext.apply( @,
			proxy:
				type: "localstorage"
				id: @getAppConfig().getEndpoint( "listScenarioItems" ).proxyId
		)

		@callParent( arguments )


	###*
	* Returns true the store contains unsynced {Phoenix.model.ScenarioItem} models.
	* @return {Boolean}
	###
	isSyncNeeded: ->
		result = false
		if( @getNewRecords().length or @getModifiedRecords().length or @getRemovedRecords().length or @getUpdatedRecords().length )
			result = true
		return result

)