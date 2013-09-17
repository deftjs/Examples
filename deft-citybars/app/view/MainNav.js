Ext.define('CityBars.view.MainNav', {
    extend: 'Ext.navigation.View',
    requires: 'CityBars.controller.BusinessViewController',
    controller: "CityBars.controller.BusinessViewController",
    alias: 'widget.mainnav',

    requires: [
        'CityBars.view.ListContainer',
        'Deft.mixin.Controllable',
        'Deft.mixin.Injectable'
    ],

    config: {
        navigationBar: {

        },
        items: [
            {
                xtype: 'listcontainer',
                title: 'City Bars'
            }
        ]
    }

});