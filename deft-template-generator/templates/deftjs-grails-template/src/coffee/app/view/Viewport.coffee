###*
* Viewport shell for the DeftTemplateGenerator application.
###
Ext.define( "DeftTemplateGenerator.view.Viewport",
  extend: "Ext.container.Viewport"
  requires: [ "DeftTemplateGenerator.view.MainPanel" ]


  layout:
    type: "fit"


  initComponent: ->

    Ext.applyIf( @,
      items: [
        xtype: "deftTemplateGenerator-view-mainPanel"
      ]
    )

    @callParent( arguments )

)