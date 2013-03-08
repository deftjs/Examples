Ext.Loader.setConfig(
  enabled: true
  paths:
    "DeftTemplateGenerator": "js/app"
    # "Ext": "/ext-4.2.0-beta/src" (Path to use for loading individual ExtJS/Touch classes)
)

# Force require of ExtJS classes that DeftJS depends on, for use in cases where ext-dev.js is used.
# Has no effect when using bootstrap.js or ext-all-dev.js
Ext.syncRequire( [ "Ext.Component", "Ext.ComponentManager", "Ext.ComponentQuery", ] )