###*
* Manages the creation of Notification windows of types Success, Information, and Error
###
Ext.define( "Phoenix.service.NotificationService",
	extend: "Ext.Base"
	requires: [ "Phoenix.view.Notification" ]


	###*
	* Constructor.
	###
	constructor: ( config={} ) ->
		@initConfig( config )
		@callParent( arguments )


	###*
	* Creates a new notification window with "success" styling.
	* @param {String} Title for this notification window
	* @param {String} Message to show in the notification window
	###
	success: ( title, message ) ->
		Ext.create( "widget.uxNotification",
			title: title
			position: "tr"
			cls: "ux-notification-window ux-notification-success"
			iconCls: "ux-notification-icon-success"
			autoHide: true
			spacing: 20
			html: message
		).show()


	###*
	* Creates a new notification window with "info" styling.
	* @param {String} Title for this notification window
	* @param {String} Message to show in the notification window
	###
	info: ( title, message ) ->
		Ext.create( "widget.uxNotification",
			title: title
			position: "tr"
			cls: "ux-notification-window ux-notification-info"
			iconCls: "ux-notification-icon-info"
			autoHide: true
			spacing: 20
			html: message
		).show()


	###*
	* Creates a new notification window with "error" styling.
	* @param {String} Title for this notification window
	* @param {String} Message to show in the notification window
	###
	error: ( title, message ) ->
		Ext.create( "widget.uxNotification",
			title: title
			position: "tr"
			cls: "ux-notification-window ux-notification-error"
			iconCls: "ux-notification-icon-error"
			autoHide: false
			spacing: 20
			html: message
		).show()

)