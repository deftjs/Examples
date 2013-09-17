Ext.define('CityBars.view.DetailPanel', {
    extend: 'Ext.tab.Panel',
    requires: 'CityBars.controller.DetailViewController',
    controller: "CityBars.controller.DetailViewController",
    alias: 'widget.detailpanel',

    config: {
        tabBar: {
            docked: 'top',
            ui: 'light',
            layout: {
                pack: 'center',
                type: 'hbox'
            }
        },
        items: [
            {
                xtype: 'container',
                title: 'Contact',
                id: 'contact',
                items: [
                    {
                        xtype: 'container',
                        id: 'info',
                        padding: 10,
                        tpl: [
                            '<img class="photo" src="{photo_url}" width="100" height="100"/>',
                            '<h2>{name}</h2>',
                            '<div class="info">',
                            '    {address1}<br/>',
                            '    <img src="{rating_img_url_small}"/>',
                            '</div>'
                        ],
                        layout: {
                            type: 'hbox'
                        },
                        items: [
                            {
                                xtype: 'component',
                                height: 100,
                                itemId: 'photo',
                                tpl: [
                                    '<img class="photo" src="{photo_url}" width="100" height="100"/>'
                                ],
                                width: 100
                            },
                            {
                                xtype: 'component',
                                itemId: 'data',
                                padding: 10,
                                tpl: [
                                    '<h2>{name}</h2>',
                                    '<div class="info">',
                                    '    {address1}<br/>',
                                    '    <img src="{rating_img_url_small}"/>',
                                    '</div>'
                                ]
                            }
                        ]
                    },
                    {
                        xtype: 'container',
                        layout: {
                            pack: 'center',
                            type: 'hbox'
                        },
                        items: [
                            {
                                xtype: 'button',
                                width: 100,
                                text: 'Call',
                                itemId: 'callButton'
                            },
                            {
                                xtype: 'spacer',
                                width: 57
                            },
                            {
                                xtype: 'button',
                                width: 100,
                                text: 'More'
                            }
                        ]
                    }
                ]
            },
            {
                xtype: 'map',
                title: 'Map',
                itemId: 'map'
            }
        ]
    }

});