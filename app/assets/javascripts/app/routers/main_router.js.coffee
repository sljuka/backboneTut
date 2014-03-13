class App.Routers.MainRouter extends Backbone.Router

	routes:
		"": "index"
		"projects" : "projects"
		"projects/new" : "newProject"
		"projects/:id" : "showProject"

	initialize: ->
		@headerView = new App.Views.Header()
		@contentView = new App.Views.Content()

	index: ->
		@layoutViews()
		@contentView.swapMain(new App.Views.Ads)
		@contentView.swapSide(new App.Views.News)

	newProject: ->
		@layoutViews()
		@contentView.swapMain(new App.Views.NewProject({ model: new App.Models.Project }))
		@contentView.swapSide(new App.Views.Projects({ collection: new App.Collections.Projects }))


	projects: ->
		@layoutViews()
		@contentView.swapMain(new App.Views.Empty())
		@contentView.swapSide(new App.Views.Projects({ collection: new App.Collections.Projects }))

	showProject: (id) ->
		@layoutViews()
		@contentView.swapSide(new App.Views.Projects({ collection: new App.Collections.Projects }))
		m = new App.Models.Project({id: id})
		@contentView.swapMain(new App.Views.ProjectDetails({ model: m }))
		 

	layoutViews: ->
		$('#header').html(@headerView.render().el)
		$('#content').html(@contentView.render().el)