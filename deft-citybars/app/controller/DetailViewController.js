Ext.define('CityBars.controller.DetailViewController', {
    extend: 'Deft.mvc.ViewController',
        
    control: {
        callButton: {
            tap: 'onCallButtonTap'
        },
        map: {
            activate: 'onMapActivate'
        },
        photo: true,
        data: true
    },
    
    config: {
        record: null
    },
    
    init: function() {
        var record = this.getRecord();
        this.getPhoto().setData(record.data);
        this.getData().setData(record.data);
    },

    onCallButtonTap: function(button, e, eOpts) {
        alert('call tap');
    },

    onMapActivate: function(newActiveItem, container, oldActiveItem, eOpts) {
        var map = newActiveItem,
            record = this.getRecord(),
            lat = record.get('latitude'),
            lng = record.get('longitude'),
            centerMap = Ext.Function.createDelayed(function() {
                map.setMapOptions({
                    zoom: 18
                });        
                map.setMapCenter({
                    latitude: lat,
                    longitude: lng
                });
            }, 250),
            geocoder, loc;

        if (lat && lng) {
            centerMap();
        } else {
            geocoder = this._geocoder || (this._geocoder = new google.maps.Geocoder());
            geocoder.geocode(
                {address: [
                    record.get('address1'), 
                    record.get('address2'), 
                    record.get('address3'), 
                    record.get('city'), 
                    record.get('state_code'),
                    record.get('zip')
                ].join(', ')},
                
                function(results, status) {
                    if (status == google.maps.GeocoderStatus.OK) {
                        loc = results[0].geometry.location;
                        lat = loc.lat();
                        lng = loc.lng();
                        record.set('latitude', lat);
                        record.set('longitude', lng);
                        centerMap();
                    } else {
                        Ext.Msg.alert("Could not find location: " + status);
                    }
                }
            );
        }

    }

});