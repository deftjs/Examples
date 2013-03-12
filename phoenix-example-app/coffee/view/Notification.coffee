###*
* Notification Window
* Modified from code by eirik (who modified from efattal)
###
Ext.define "Phoenix.view.Notification",
	extend: "Ext.window.Window"
	alias: "widget.uxNotification"


	statics:
		defaultManager:
			el: null


	cls: "ux-notification-window"
	autoHide: true
	autoHeight: true
	plain: false
	draggable: false
	shadow: false
	focus: Ext.emptyFn
	manager: null
	useXAxis: false
	position: "br"
	spacing: 6
	paddingX: 30
	paddingY: 10
	slideInAnimation: "easeIn"
	slideBackAnimation: "bounceOut"
	slideInDuration: 600
	slideBackDuration: 600
	hideDuration: 600
	autoHideDelay: 5000
	stickOnClick: true
	stickWhileHover: true
	isHiding: false
	readyToHide: false
	xPos: 0
	yPos: 0


	getXposAlignedToManager: ->
		me = this
		xPos = 0
		if me.manager and me.manager.el and me.manager.el.dom
			unless me.useXAxis
				return me.el.getLeft()
			else
				if me.position is "br" or me.position is "tr" or me.position is "r"
					xPos += me.manager.el.getAnchorXY("r")[0]
					xPos -= (me.el.getWidth() + me.paddingX)
				else
					xPos += me.manager.el.getAnchorXY("l")[0]
					xPos += me.paddingX
		xPos


	getYposAlignedToManager: ->
		me = this
		yPos = 0
		if me.manager and me.manager.el and me.manager.el.dom
			if me.useXAxis
				return me.el.getTop()
			else
				if me.position is "br" or me.position is "bl" or me.position is "b"
					yPos += me.manager.el.getAnchorXY("b")[1]
					yPos -= (me.el.getHeight() + me.paddingY)
				else
					yPos += me.manager.el.getAnchorXY("t")[1]
					yPos += me.paddingY
		yPos


	getXposAlignedToSibling: (sibling) ->
		me = this
		if me.useXAxis
			if me.position is "tl" or me.position is "bl" or me.position is "l"
				sibling.xPos + sibling.el.getWidth() + sibling.spacing
			else
				sibling.xPos - me.el.getWidth() - me.spacing
		else
			me.el.getLeft()


	getYposAlignedToSibling: (sibling) ->
		me = this
		if me.useXAxis
			me.el.getTop()
		else
			if me.position is "tr" or me.position is "tl" or me.position is "t"
				sibling.yPos + sibling.el.getHeight() + sibling.spacing
			else
				sibling.yPos - me.el.getHeight() - sibling.spacing


	getNotifications: (alignment) ->
		me = this
		me.manager.notifications[alignment] = []  unless me.manager.notifications[alignment]
		me.manager.notifications[alignment]


	beforeShow: ->
		me = this
		me.position = me.corner  if Ext.isDefined(me.corner)
		me.slideBackAnimation = me.slideDownAnimation  if Ext.isDefined(me.slideDownAnimation)
		me.autoHideDelay = me.autoDestroyDelay  if Ext.isDefined(me.autoDestroyDelay)
		me.slideInDuration = me.slideInDelay  if Ext.isDefined(me.slideInDelay)
		me.slideBackDuration = me.slideDownDelay  if Ext.isDefined(me.slideDownDelay)
		me.hideDuration = me.fadeDelay  if Ext.isDefined(me.fadeDelay)
		me.position = me.position.replace(/c/, "")

		switch me.position
			when "br"
				me.paddingFactorX = -1
				me.paddingFactorY = -1
				me.siblingAlignment = "br-br"
				if me.useXAxis
					me.managerAlignment = "bl-br"
				else
					me.managerAlignment = "tr-br"
			when "bl"
				me.paddingFactorX = 1
				me.paddingFactorY = -1
				me.siblingAlignment = "bl-bl"
				if me.useXAxis
					me.managerAlignment = "br-bl"
				else
					me.managerAlignment = "tl-bl"
			when "tr"
				me.paddingFactorX = -1
				me.paddingFactorY = 1
				me.siblingAlignment = "tr-tr"
				if me.useXAxis
					me.managerAlignment = "tl-tr"
				else
					me.managerAlignment = "br-tr"
			when "tl"
				me.paddingFactorX = 1
				me.paddingFactorY = 1
				me.siblingAlignment = "tl-tl"
				if me.useXAxis
					me.managerAlignment = "tr-tl"
				else
					me.managerAlignment = "bl-tl"
			when "b"
				me.paddingFactorX = 0
				me.paddingFactorY = -1
				me.siblingAlignment = "b-b"
				me.useXAxis = 0
				me.managerAlignment = "t-b"
			when "t"
				me.paddingFactorX = 0
				me.paddingFactorY = 1
				me.siblingAlignment = "t-t"
				me.useXAxis = 0
				me.managerAlignment = "b-t"
			when "l"
				me.paddingFactorX = 1
				me.paddingFactorY = 0
				me.siblingAlignment = "l-l"
				me.useXAxis = 1
				me.managerAlignment = "r-l"
			when "r"
				me.paddingFactorX = -1
				me.paddingFactorY = 0
				me.siblingAlignment = "r-r"
				me.useXAxis = 1
				me.managerAlignment = "l-r"

		me.manager = Ext.getCmp(me.manager)  if typeof me.manager is "string"
		unless me.manager
			me.manager = me.statics().defaultManager
			me.manager.el = Ext.getBody()  unless me.manager.el
		me.manager.notifications = {}  if typeof me.manager.notifications is "undefined"

		if me.stickOnClick
			if me.body and me.body.dom
				Ext.fly(me.body.dom).on "click", (->
					me.cancelAutoHide()
					me.addCls "notification-fixed"
				), me
		me.el.hover (->
			me.mouseIsOver = true
		), (->
			me.mouseIsOver = false
		), me

		if me.autoHide
			me.task = new Ext.util.DelayedTask(me.doAutoHide, me)
			me.task.delay me.autoHideDelay

		notifications = me.getNotifications(me.managerAlignment)

		if notifications.length
			me.el.alignTo notifications[notifications.length - 1].el, me.siblingAlignment, [ 0, 0 ]
			me.xPos = me.getXposAlignedToSibling(notifications[notifications.length - 1])
			me.yPos = me.getYposAlignedToSibling(notifications[notifications.length - 1])
		else
			me.el.alignTo me.manager.el, me.managerAlignment, [ (me.paddingX * me.paddingFactorX), (me.paddingY * me.paddingFactorY) ]
			me.xPos = me.getXposAlignedToManager()
			me.yPos = me.getYposAlignedToManager()

		Ext.Array.include notifications, me

		me.stopAnimation()
		me.el.animate
			to:
				x: me.xPos
				y: me.yPos
				opacity: 1

			easing: me.slideInAnimation
			duration: me.slideInDuration
			dynamic: true


	slideBack: ->
		me = this
		notifications = me.getNotifications(me.managerAlignment)
		index = Ext.Array.indexOf(notifications, me)
		if not me.isHiding and me.el and me.manager and me.manager.el and me.manager.el.dom and me.manager.el.isVisible()
			if index
				me.xPos = me.getXposAlignedToSibling(notifications[index - 1])
				me.yPos = me.getYposAlignedToSibling(notifications[index - 1])
			else
				me.xPos = me.getXposAlignedToManager()
				me.yPos = me.getYposAlignedToManager()
			me.stopAnimation()
			me.el.animate
				to:
					x: me.xPos
					y: me.yPos

				easing: me.slideBackAnimation
				duration: me.slideBackDuration
				dynamic: true


	cancelAutoHide: ->
		me = this
		if me.autoHide
			me.task.cancel()
			me.autoHide = false


	doAutoHide: ->
		me = this
		me.el.hover (->
		), (->
			me.hide()
		), me
		me.hide()  unless me.stickWhileHover and me.mouseIsOver


	hide: ->
		me = this
		if not me.isHiding and me.el
			me.isHiding = true
			me.cancelAutoHide()
			me.stopAnimation()
			me.el.animate
				to:
					opacity: 0

				easing: "easeIn"
				duration: me.hideDuration
				dynamic: false
				listeners:
					afteranimate: ->
						if me.manager
							notifications = me.getNotifications(me.managerAlignment)
							index = Ext.Array.indexOf(notifications, me)
							unless index is -1
								Ext.Array.erase notifications, index, 1
								while index < notifications.length
									notifications[index].slideBack()
									index++
						me.readyToHide = true
						me.hide()

		if me.readyToHide
			me.isHiding = false
			me.readyToHide = false
			me.removeCls "notification-fixed"
			@callParent arguments