###*
* Abstract Context class. Acts as a base class for concrete Context objects to manage application state and
* fire events which other objects can respond to.
###
Ext.define( "Phoenix.context.AbstractContext",
	mixins:
		observable: "Ext.util.Observable"


	constructor: ( config={} ) ->
		@mixins.observable.constructor.call( @ )
		@initConfig( config )
		@callParent( arguments )


)