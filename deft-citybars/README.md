Deft JS CityBars
================================

A Sencha Touch 2 app built with Sencha Cmd (v3.1.2.342) and Deft JS (v0.9.1) that uses the Yelp API to display local watering holes (pubs, bars, restaurants) per your current location. This is a port of Sencha's [CityBars example app](https://github.com/SenchaArchitect/CityBars), which was built using Sencha Architect. Not only does this example show how to build a Deft JS Touch app using Sencha Cmd, but it demonstrates a number of advantages that Deft JS offers over the "standard" architectural approach encouraged by Sencha.  

> **IMPORTANT:** Since this app uses the Yelp API, in order to run it you MUST obtain a free Yelp developer API key. Simply log in to Yelp, go to [http://www.yelp.com/developers/getting_started/api_overview](http://www.yelp.com/developers/getting_started/api_overview) and choose the V1 API to get an API key. Then add your key to the `app.js` file (toward the bottom, where it says `yelpKey`).

##### Key Differences between the Original and Deft JS versions:

* Application configuration: The `Deft.Injector` configuration seen in `app.js` centralizes values like the Yelp URL and API key. These are injected automatically into the classes that need to use them, rather than having this data set in the classes themselves.
* View Controllers: The Deft app uses ViewControllers instead of the global, singleton controller found in the original app. The [original controller](https://github.com/SenchaArchitect/CityBars/blob/master/CityBars/app/controller/Business.js) was an strange blend of view listeners, remote data loading, and location determination, and used element Ids or selectors that depend on the structure of the views. All of this is either gone or more properly encapsulated in the Deft version. Also, having a dedicated ViewController for each view (particularly the detail view, which is re-created each time details are shown) greatly simplifies the task of locating view elements and updating state in view components.
* Service Class and Promises: A service class has been added, which further clears up the ViewControllers and encapsulates data-load logic. The service uses a Promise chain rather than complicated nested callbacks, and allows the ViewController to leverage a standard service API based on Promises.
* Using an arbitrary "special" property on the Map object to track the current record is no longer needed.
* Building the proper Yelp URL is now encapsulated in the Store and uses dependency injection to obtain the base Yelp URL and API key.
* Explicit references to `Ext.Viewport` in the controller is no longer needed
* Separate `refs` and `control` blocks in the controller are no longer needed.
* Behavior related to the detail view is now separated from behavior related to the business list.

The original example was probably not meant to show "best-practice" architecture, so this isn't intended as a harsh critique of the original app. But it does provide a useful demonstration of many Deft JS features in addition to showing how to build a Deft JS Touch app using Sencha Cmd.