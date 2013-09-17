Ext.define('CityBars.store.BusinessStore', {
    extend: 'Ext.data.Store',
    inject: ["yelpKey","yelpUrl"],

    requires: [
        'CityBars.model.Business'
    ],

    config: {
        yelpKey: null,
        yelpUrl: null,
        model: 'CityBars.model.Business',
        proxy: {
            type: 'jsonp',
            reader: {
                type: 'json',
                rootProperty: 'businesses'
            }
        }
    },
    
    updateYelpUrl: function(latitude,longitude) {
        var url = this.getYelpUrl() +
            '?ywsid=' + this.getYelpKey() +
            '&term=Bars' +
            '&lat=' + latitude +
            '&long=' + longitude;
            
        this.getProxy().setUrl(url);
    }
    
});