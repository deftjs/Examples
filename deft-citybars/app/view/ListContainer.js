Ext.define('CityBars.view.ListContainer', {
    extend: 'Ext.Container',
    alias: 'widget.listcontainer',
    inject: ['businessStore'],
    
    config: {
        layout: {
            type: 'fit'
        },
        businessStore: null
    },
    
    initialize: function() {
        this.callParent(arguments);
        this.add(
            {
                xtype: 'list',
                itemId: 'dataList',
                store: this.getBusinessStore(),
                loadingText: false,
                masked: false,
                itemTpl: [
                    '<img class="photo" src="{photo_url}" width="40" height="40"/>&nbsp;&nbsp;{name}<br/><img src="{rating_img_url_small}"/>&nbsp;&nbsp;<small>{address1}</small>'
                ]
            }
        );
    }

});