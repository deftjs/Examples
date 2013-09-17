Ext.define('CityBars.controller.BusinessViewController', {
    extend: 'Deft.mvc.ViewController',
    inject: ['businessService','businessStore'],
        
    control: {
        dataList: {
            itemtap: 'onListItemTap'
        }
    },
    
    config: {
        businessStore: null,
        businessService: null
    },
    
    init: function() {
        this.getBusinesses();
    },
    
    onListItemTap: function(dataview, index, target, record, e, eOpts) {
        var map,
            info,
            details;

        if (record) {
            details = Ext.create('CityBars.view.DetailPanel', {
                title: 'Details',
                controllerConfig: {
                    record: record
                }
            });

            this.getView().push(details);
        }
    },
    
    getBusinesses: function(location, callback) {
        this.getView().setMasked({ xtype: 'loadmask', indicator: true, message: 'Loading Yelp Businesses...' });
        this.getBusinessService().loadBusinessesForCurrentLocation().always({ 
            fn: function() {
                this.getView().setMasked(false);
            },
            scope: this
        });
        
    }

});