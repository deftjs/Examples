###*
* Service methods related to Scenarios.
###
Ext.define( "Phoenix.service.ScenarioService",
	inject: [
		"scenarioStore"
		"probabilityStore"
		"revenueImpactStore"
		"affectedItemStore"
	]


	config:
		scenarioStore: null
		probabilityStore: null
		revenueImpactStore: null
		affectedItemStore: null


	constructor: ( config={} ) ->
		@initConfig( config )
		@callParent( arguments )


	###*
	* Loads initial reference data: probabilities, revenue impacts, and affected item lists.
	* @return {Deft.promise.Promise}
	###
	loadInitialData: ->
		return Deft.Chain.parallel( [ @loadProbabilities, @loadRevenueImpacts, @loadAffectedItems ], @ )


	###*
	* Loads reference set of {Phoenix.model.Probability} models.
	* @return {Deft.promise.Promise}
	###
	loadProbabilities: ->
		deferred = Ext.create( "Deft.promise.Deferred" )

		@getProbabilityStore().load(

			callback: ( records, operation, success ) ->
				if( success )
					deferred.resolve()
				else
					deferred.reject( "Error loading Probabilities" )

			scope: @
		)

		return deferred.promise


	###*
	* Loads reference set of {Phoenix.model.RevenueImpact} models.
	* @return {Deft.promise.Promise}
	###
	loadRevenueImpacts: ->
		deferred = Ext.create( "Deft.promise.Deferred" )

		@getRevenueImpactStore().load(

			callback: ( records, operation, success ) ->
				if( success )
					deferred.resolve()
				else
					deferred.reject( "Error loading Revenue Impacts" )

			scope: @
		)

		return deferred.promise


	###*
	* Loads reference set of {Phoenix.model.AffectedItem} models.
	* @return {Deft.promise.Promise}
	###
	loadAffectedItems: ->
		deferred = Ext.create( "Deft.promise.Deferred" )

		@getAffectedItemStore().load(

			callback: ( records, operation, success ) ->
				if( success )
					deferred.resolve()
				else
					deferred.reject( "Error loading Affected Items" )

			scope: @
		)

		return deferred.promise


	###*
	* Loads the set of {Phoenix.model.Scenario} models.
	* @return {Deft.promise.Promise}
	###
	loadScenarios: ->
		deferred = Ext.create( "Deft.promise.Deferred" )

		@getScenarioStore().load(

			callback: ( records, operation, success ) ->
				if( success )
					deferred.resolve()
				else
					deferred.reject( "Error loading Scenarios" )

			scope: @
		)

		return deferred.promise


	###*
	* Saves the passed {Phoenix.model.Scenario} and its associated {Phoenix.model.ScenarioItem} models.
	* @param {Phoenix.model.Scenario} Scenario to save.
	* @return {Deft.promise.Promise}
	###
	saveScenario: ( scenario ) ->
		if( @isNewScenario( scenario ) )
			@getScenarioStore().add( scenario )

		scenario.set( "dateUpdated", new Date() )
		scenario.simulateServerCostBenefitAnalysis()

		sequence = [ @syncScenarioStore ]

		if( scenario.scenarioItems().isSyncNeeded() )
			sequence.push( -> @syncScenarioItemsStore( scenario ) )

		return Deft.Chain.sequence( sequence, @ )


	###*
	* Deletes the passed {Phoenix.model.Scenario} and its associated {Phoenix.model.ScenarioItem} models.
	* @param {Phoenix.model.Scenario} Scenario to delete.
	* @return {Deft.promise.Promise}
	###
	deleteScenario: ( scenario ) ->
		scenario.scenarioItems().load()
		scenario.scenarioItems().removeAll()
		@getScenarioStore().remove( scenario )
		return Deft.Chain.sequence( [ ( -> @syncScenarioItemsStore( scenario ) ), @syncScenarioStore ], @ )


	###*
	* Syncs the {Phoenix.store.ScenarioStore}.
	* @return {Deft.promise.Promise}
	###
	syncScenarioStore: ->
		deferred = Ext.create( "Deft.promise.Deferred" )

		@getScenarioStore().sync(

			success: ( batch, options ) ->
				deferred.resolve()

			failure: ( batch, options ) ->
				@getScenarioStore().rejectChanges()
				deferred.reject()

			scope: @
		)

		return deferred.promise


	###*
	* Syncs the {Phoenix.store.ScenarioItemStore} for the passed {Phoenix.model.Scenario}.
	* @param {Phoenix.model.Scenario} Scenario whos ScenarioItems will be synced.
	* @return {Deft.promise.Promise}
	###
	syncScenarioItemsStore: ( scenario ) ->
		deferred = Ext.create( "Deft.promise.Deferred" )
		scenario.updateScenarioItemsAssociation()

		scenario.scenarioItems().sync(

			success: ( batch, options ) ->
				deferred.resolve()

			failure: ( batch, options ) ->
				scenario.scenarioItems().rejectChanges()
				deferred.reject()

			scope: @
		)

		return deferred.promise


	###*
	* Returns true if the {Phoenix.model.Scenario} is not present in the {Phoenix.store.ScenarioStore}.
	* @param {Phoenix.model.Scenario}
	* @return {Boolean}
	###
	isNewScenario: ( scenario ) ->
		return not @getScenarioStore().getById( scenario.getId() )?
)