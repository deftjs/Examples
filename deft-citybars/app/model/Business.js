Ext.define('CityBars.model.Business', {
    extend: 'Ext.data.Model',

    config: {
        fields: [
            {
                name: 'id',
                type: 'int'
            },
            {
                name: 'name'
            },
            {
                name: 'latitude'
            },
            {
                name: 'longitude'
            },
            {
                name: 'address1'
            },
            {
                name: 'address2'
            },
            {
                name: 'address3'
            },
            {
                name: 'phone'
            },
            {
                name: 'state_code'
            },
            {
                name: 'mobile_url'
            },
            {
                name: 'rating_img_url_small'
            },
            {
                name: 'photo_url'
            },
            {
                name: 'city'
            },
            {
                name: 'zip'
            }
        ]
    }
});