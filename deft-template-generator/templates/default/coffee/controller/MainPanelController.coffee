###*
* Controls the main (root) UI container for the application.
###
Ext.define( "DeftTemplateGenerator.controller.MainPanelController",
  extend: "Deft.mvc.ViewController"

  ###
  Add any inject, control or observe configuration here. E.g.:

  inject: [ "someDependencyName" ]

  config:
    someDependencyName: null

  control:
    someItemId: true

  observe:
    someDependencyName:
      someEventName: "someHandlerMethodName"
  ###

  init: ->
    @callParent( arguments )


)