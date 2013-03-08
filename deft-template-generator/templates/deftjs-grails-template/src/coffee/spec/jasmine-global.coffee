###*
* Global beforeEach runs before all specs in all test files.
###
beforeEach( ->
  @addMatchers(

    ###*
    * Add a global toBeBecause() matcher that accepts an optional failure message to better describe failed tests.
    * @param expected The expected value.
    * @param becauseMessage A custom message to show in the results instead of the useless default message.
    * @param {Boolean} verbose Defaults to false. If true, shows the expected and actual values in the message output.
    ###
    toBeBecause: ( expected, becauseMessage, verbose=false ) ->
      actual = @actual
      notText = (if @isNot then " not" else "")

      @message = ->
        if( verbose or not becauseMessage? )
          result = "Expected " + actual + notText + " to be " + expected
          result += " because " + becauseMessage if becauseMessage?
        else
          result = "Failed because: " + becauseMessage
        return result

      actual is expected
  )
)


###*
* Global helper function to add a componentTestArea div to the DOM for use in specs.
###
createComponentTestArea = ->
  if Ext.get( "componentTestArea" )? then Ext.removeNode( Ext.get( "componentTestArea" ).dom )
  Ext.DomHelper.append( Ext.getBody(), '<div id="componentTestArea" style="visibility: hidden"></div>' )
  return


###*
* Global helper function to help in accessing DeftJS dependencies in specs
* @param String dependencyNames A comma-separated list of dependency provider names to return references for.
* @return If a single dependency name is passed, returns the reference. If a list of names are passed, returns an object containing the references.
###
getDependency = ( dependencyNames ) ->
  dependencyList = dependencyNames.split( "," )
  if( dependencyList.length == 1 )
    return Deft.Injector.resolve( Ext.String.trim( dependencyList[ 0 ] ) )
  else
    result = {}
    for thisDependency in dependencyList
      thisDependency = Ext.String.trim( thisDependency )
      result[ thisDependency ] = Deft.Injector.resolve( thisDependency )
    return result

