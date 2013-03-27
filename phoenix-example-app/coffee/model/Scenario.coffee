###*
* Domain model for a Scenario.
###
Ext.define( "Phoenix.model.Scenario",
	extend: "Ext.data.Model"
	requires: [
		"Phoenix.model.ScenarioItem"
		"Phoenix.store.ScenarioItemStore"
		"Ext.data.UuidGenerator"
	]


	idProperty: "id"


	fields: [
		name: "id"
		type: "string"
	,
		name: "name"
		type: "string"
	,
		name: "description"
		type: "string"
	,
		name: "dateUpdated"
		type: "date"
	,
		name: "probabilityId"
		type: "int"
	,
		name: "planCost"
		type: "float"
	,
		name: "impactCost"
		type: "float"
	,
		name: "impactLength"
		type: "float"
	,
		name: "totalImpact"
		type: "float"
	,
		name: "planEffectiveness"
		type: "string"
	]


	hasMany:
		model: "Phoenix.model.ScenarioItem"
		name: "scenarioItems"
		foreignKey: "scenarioId"
		storeConfig:
			type: "scenarioItemStore"


	###*
	* Returns true if this {Phoenix.model.Scenario} has any invalid associated {Phoenix.model.ScenarioItem} models.
	* @return {Boolean}
	###
	hasInvalidScenarioItems: ->
		result = false
		@scenarioItems().each( ( scenarioItem ) ->
			if( not scenarioItem.isValid() )
				result = true
				return false
		)
		return result


	###*
	* Updates the set of {Phoenix.model.ScenarioItem} associated with this {Phoenix.model.Scenario}.
	###
	updateScenarioItemsAssociation: ->
		scenarioId = @getId()
		@scenarioItems().each( ( scenarioItem ) ->
			scenarioItem.set( "scenarioId", scenarioId )
		)


	###*
	* Copies this {Phoenix.model.Scenario} and its set of {Phoenix.model.ScenarioItem}.
	* @return {Phoenix.model.Scenario} The copied Scenario.
	###
	copy: ->
		generator = new Ext.data.UuidGenerator()
		newScenario = @callParent( arguments )
		newScenario.setId( generator.generate() )
		newScenario.set( "name", "#{ newScenario.get( 'name' ) } (Copy)" )

		@scenarioItems().each( ( scenarioItem ) ->
			newItem = scenarioItem.copy()
			newItem.setId( generator.generate() )
			newItem.set( "scenarioId", newScenario.getId() )
			newScenario.scenarioItems().add( newItem )
			return true
		)

		return newScenario


	###*
	* Simulates a process that would normally happen on the server. Creates mock disaster plan analysis values
	* for this {Phoenix.model.Scenario}.
	###
	simulateServerCostBenefitAnalysis: ->
		@set( "planCost", Ext.Number.randomInt( 10, 50 ) )
		@set( "impactCost", Ext.Number.randomInt( 800, 5000 ) )
		@set( "impactLength", Ext.Number.randomInt( 4, 20 ) )
		@set( "totalImpact", Ext.Number.randomInt( 6000, 80000 ) )
		planEffectivenessOptions = [ "Terrible", "Poor", "Marginal", "Good", "Great", "Excellent" ]
		@set( "planEffectiveness", planEffectivenessOptions[ Ext.Number.randomInt( 0, 5 ) ] )

)