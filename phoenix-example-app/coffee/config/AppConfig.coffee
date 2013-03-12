###*
* Application configuration class, including endpoint lookup and runtime setting for mock vs. live data access.
* Inject into stores or other objects to resolve endpoints for loading data.
*
* Typically, this would allow lookup of server URLs. In this case, we store the memory proxy Ids.
###
Ext.define( "Phoenix.config.AppConfig",

	statics:
		MOCK_DATA_ENV: "MOCK_DATA_ENV"
		PRODUCTION_ENV: "PRODUCTION_ENV"


	config:
		environment: null

		# Specify data endpoints for a test/mock data environment. If no match found, attempt to use the defaults.
		MOCK_DATA_ENV:
			endpoints:
				listScenarios:
					proxyId: "deftjs-phoenix-scenarios-test"
				listScenarioItems:
					proxyId: "deftjs-phoenix-scenarioItems-test"

			defaults:
				urlPrefix: "data/"
				urlSuffix: ".json"
				dataRoot: ""

		# Specify data endpoints for production environment. If no match found, attempt to use the defaults.
		PRODUCTION_ENV:
			endpoints:
				listScenarios:
					proxyId: "deftjs-phoenix-scenarios"
				listScenarioItems:
					proxyId: "deftjs-phoenix-scenarioItems"

			defaults:
				urlPrefix: "/"
				urlSuffix: ".json"
				dataRoot: ""


	###*
	* Configures the application, particularly the endpoints used for server requests.
	* @param {Object} cfg A configuration object, usually pulled from a static property in an application-specific configuration class.
	* @param {String} environment Determines whether live server calls or mock JSON data files should be used. Set to MOCK_DATA_ENV or PRODUCTION_ENV. If no environment is specified, defaults to PRODUCTION_ENV.
	###
	constructor: ( cfg ) ->
		if cfg?.environment and Phoenix.config.AppConfig[ cfg.environment ]?
			@setEnvironment( Phoenix.config.AppConfig[ cfg.environment ] )
		else
			@setEnvironment( Phoenix.config.AppConfig.PRODUCTION_ENV )


	###*
	* Given an endpoint name, returns the URL and root JSON data element for that endpoint. If no endpoint can be found, attempt to use the default url prefix and suffix.
	* @param {String} Endpoint name
	* @return {Object} Object with keys defined for the endpoint ( typically 'url' and 'root')
	###
	getEndpoint: ( endpointName ) ->
		environmentConfig = @[ @getEnvironment() ]
		endpoints = environmentConfig.endpoints
		defaults = environmentConfig.defaults

		if endpoints?[ endpointName ]
			result = endpoints[ endpointName ]
			result.root = endpoints[ endpointName ]?.root ? defaults.dataRoot
		else
			result =
				url: defaults.urlPrefix + endpointName + defaults.urlSuffix
				root: defaults.dataRoot

		return result

)