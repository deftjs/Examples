Ext.define("CityBars.service.BusinessService", {
    requires: [
        "Deft.promise.Chain"
    ],
    inject: ["businessStore"],
  
    config: {
        businessStore: null,
        currentLocation: null
    },

    constructor: function(config) {
        if (config == null) {
          config = {};
        }
        this.initConfig(config);
        return this.callParent(arguments);
    },
    
    loadBusinessesForCurrentLocation: function() {
        return Deft.Chain.sequence([this.getLocation, this.loadBusinesses], this);
    },
    
    getLocation: function() {
        var me = this,
            deferred = Ext.create("Deft.promise.Deferred");
            
        if (navigator && navigator.geolocation) {
            // https://developer.mozilla.org/en-US/docs/Web/API/Geolocation.getCurrentPosition
            navigator.geolocation.getCurrentPosition(function(position) {
                me.setCurrentLocation(position);
                deferred.resolve(position);
            }, function(error) {
                deferred.reject("Error loading Location");
            });
        }
        
        return deferred.promise;
    },

    loadBusinesses: function() {
        var store = this.getBusinessStore(),
            currentLocation = this.getCurrentLocation(),
            deferred = Ext.create("Deft.promise.Deferred");
            
        this.getBusinessStore().updateYelpUrl(currentLocation.coords.latitude, currentLocation.coords.longitude);
        
        store.load({
            callback: function(records, operation, success) {
                if (success) {
                    deferred.resolve();
                } else {
                    deferred.reject("Error loading Businesses");
                }
            },
            scope: this
        });
        
        return deferred.promise;
    }
  
});
