###*
* Main (root) UI container.
###
Ext.define( "DeftTemplateGenerator.view.MainPanel",
  extend: "Ext.panel.Panel"
  alias: "widget.deftTemplateGenerator-view-mainPanel"
  controller: "DeftTemplateGenerator.controller.MainPanelController"


  header: true
  title: "Main Panel"
  layout: "anchor"
  defaults:
    anchor: "100% 100%"


  initComponent: ->

    Ext.applyIf( @,
      items: [
        html: "<div style='padding: 20px; font-size: x-large'>Add your own views as children of MainPanel.</span>"
      ]
    )

    @callParent( arguments )

)