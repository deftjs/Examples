###*
* Abstract ViewController for the Phoenix application.
###
Ext.define( "Phoenix.controller.AbstractPhoenixController",
	extend: "Deft.mvc.ViewController"
	inject: [
		"scenarioContext"
		"scenarioService"
		"notificationService"
	]


	config:
		scenarioContext: null
		scenarioService: null
		notificationService: null


	init: ->
		@callParent( arguments )

)