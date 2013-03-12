Ext.Loader.setConfig(
	enabled: true
	paths:
		"Phoenix": "app"
)

# Force require of ExtJS classes that DeftJS depends on, for use in cases where ext-dev.js is used.
# There are plans to build this into DeftJS itself, but for now I just require these here.
# Has no effect when using bootstrap.js or ext-all-dev.js
Ext.syncRequire( [ "Ext.Component", "Ext.ComponentManager", "Ext.ComponentQuery", ] )