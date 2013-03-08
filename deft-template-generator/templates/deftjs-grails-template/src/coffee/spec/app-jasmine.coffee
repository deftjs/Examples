# Create a reference to executeJasminSpecs() so that JasmineApplication can call it.
window.executeJasmineSpecs = executeJasmineSpecs


Ext.Loader.setConfig(
  enabled: true
  paths :
    "DeftTemplateGenerator": "js/app"
    "DeftTemplateGenerator.test": "js/spec"
)


Ext.application(
  autoCreateViewport: false
  name: "DeftTemplateGenerator"
  appFolder: "js/app"

  launch: ->
    #Create a reference to the ExtJS Application object so we can perform tests against it.
    window.Application = @
)


# DeftJS configuration and Jasmine spec runner startup is now handled by the Application class.
Ext.syncRequire( [ "DeftTemplateGenerator.test.JasmineApplication" ] )
Ext.create( "DeftTemplateGenerator.test.JasmineApplication" )