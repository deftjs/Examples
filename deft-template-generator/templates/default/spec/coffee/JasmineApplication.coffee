###*
* DeftJS Jasmine Application class for the DeftTemplateGenerator Jasmine specs.
###
Ext.define( "DeftTemplateGenerator.test.JasmineApplication",
  extend: "DeftTemplateGenerator.Application"


  ###*
  * @protected
  * Override parent method to alter the returned Deft.Injector.configure() configuration object so the Jasmine tests can run.
  * @return {Object} The Injector configuration object.
  ###
  buildInjectorConfiguration: ->
    result = @callParent()

    ###
    Force tests to run in mock data mode. Can add or override any dependency configuration defined in the main Application class.
    ###
    Ext.apply( result,
      appConfig:
        className: "DeftTemplateGenerator.config.AppConfig"
        parameters: [ environment: DeftTemplateGenerator.config.AppConfig.MOCK_DATA_ENV ]
    )

    return result


  ###*
  * @protected
  * Override parent method to start Jasmine spec runner.
  ###    
  afterInit: ->
    # Once ExtJS is ready, begin running the Jasmine tests.
    window.executeJasmineSpecs()

)
