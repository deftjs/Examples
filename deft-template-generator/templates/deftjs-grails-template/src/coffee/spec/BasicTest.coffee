describe "During initialization and setup, the application...", ->


  it "should load ExtJS 4", ->
    expect( Ext ).toBeDefined()
    expect( Ext.getVersion()? ).toBeBecause( true, "Ext.getVersion() should return a value." )
    expect( Ext.getVersion().major is 4 ).toBeBecause( true, "ExtJS major version is not 4." )


  it "should load ExtJS application", ->
    expect( window.Application? ).toBeBecause( true, "window.Application should be defined.")
    expect( window.Application.name is "DeftTemplateGenerator" ).toBeBecause( true, "Application name should be DeftTemplateGenerator." )


  it "should create DeftJS IoC items", ->
    expect( Deft.ioc.Injector.canResolve( "appConfig" ) ).toBeBecause( true, "Injector should resolve appConfig." )
    expect( Deft.ioc.Injector.canResolve( "some_$unknown$_alias" ) ).toBeBecause( false, "Injector should not resolve a dependency provider that doesn't exist." )


  it "should inject dependencies into a target object", ->
    target =
      appConfig: null
      someOtherProperty: null
      config: {}

    Deft.ioc.Injector.inject( "appConfig", target )

    expect( target.appConfig? ).toBeBecause( true, "appConfig should be injected into target object." )
    expect( target.someOtherProperty? ).toBeBecause( false, "A property with no dependency injected should remain null." )
