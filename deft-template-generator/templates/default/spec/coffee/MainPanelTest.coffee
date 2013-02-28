describe "The Main Panel...", ->

  view = null
  viewController = null


  beforeEach( ->

    createComponentTestArea()

    view = Ext.create( "DeftTemplateGenerator.view.MainPanel",
      renderTo: "componentTestArea"
    )

    viewController = view.getController()
  )


  afterEach( ->
    view.destroy()
    view = null
    viewController = null
  )


  describe "During a successful startup...", ->


    it "should create the main panel view and view controller", ->
      expect( view? ).toBeBecause( true, "Main panel view should be defined." )
      expect( view.rendered ).toBeBecause( true, "Main panel view should be rendered." )
      expect( view instanceof DeftTemplateGenerator.view.MainPanel ).toBeBecause( true, "view should be an instance of MainPanel" )
      expect( viewController? ).toBeBecause( true, "MainPanelController should be defined." )
      expect( viewController instanceof DeftTemplateGenerator.controller.MainPanelController ).toBeBecause( true, "Main panel view should be an instance of MainPanelController." )
      expect( viewController.getView() is view ).toBeBecause( true, "View controller's getView() should return the MainPanel." )
