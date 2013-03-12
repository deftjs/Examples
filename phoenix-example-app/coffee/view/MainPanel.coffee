###*
* Main (root) UI container.
###
Ext.define( "Phoenix.view.MainPanel",
	extend: "Ext.tab.Panel"
	alias: "widget.phoenix-view-mainPanel"
	requires: [ "Phoenix.view.ScenarioGrid" ]
	controller: "Phoenix.controller.MainPanelController"


	header: false
	plain: true
	title: "PHOENIX Disaster Recovery Scenario Planner (DeftJS Example Application)"


	initComponent: ->

		Ext.applyIf( @,
			items: [
				xtype: "phoenix-view-scenarioGrid"
			]
		)

		@callParent( arguments )

)