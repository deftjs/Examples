/*
 * This application requires use of the Sencha Touch 2.2.x library, under independent license.
 * License of Sencha Architect does not include license for Sencha Touch 2.2.x. For more
 * details see http://www.sencha.com/license or contact license@sencha.com.
 */

//@require @packageOverrides

// This Loader config is used when running the app directly from the source, rather than a compiled build...
//<debug>
Ext.Loader.setPath({
    'Ext': 'touch/src',
    'Deft': 'packages/deft/src/js',
    'CityBars': 'app'
});
Ext.syncRequire(['Deft.mixin.Injectable','Deft.mixin.Controllable']);
//</debug>

//@require Deft.mixin.Injectable
//@require Deft.mixin.Controllable

Ext.application({

    requires: [
        'Ext.dataview.List',
        'Ext.data.proxy.JsonP',
        'CityBars.store.BusinessStore',
        'CityBars.service.BusinessService'
    ],

    name: 'CityBars',

    launch: function() {

        Deft.Injector.configure({
            businessStore: 'CityBars.store.BusinessStore',
            businessService: 'CityBars.service.BusinessService',
            yelpUrl: {
                value: 'http://api.yelp.com/business_review_search'
            },
            
            // ****** ADD YOUR YELP KEY!!! ******
            // You must use your own yelp key, available by registering (for free) with Yelp:
            // http://www.yelp.com/developers/getting_started/api_overview
            // (in this app, we use the Review Search API v1.0)
            yelpKey: {
                value: '' // <-- Add Yelp API Key here
            }
        });
        
        Ext.create('CityBars.view.MainNav', {fullscreen: true});
    }

});
