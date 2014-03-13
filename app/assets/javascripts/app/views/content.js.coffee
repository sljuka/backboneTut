class App.Views.Content extends Backbone.View

	className: "row"

	template: HandlebarsTemplates['app/templates/content']

	initialize: ->
		@listenTo App.Vent, "project:create", @swapMainToEmpty
		@listenTo App.Vent, "project:new", @swapMainToNewProject
		@listenTo App.Vent, "project:show", @projectShow
		@listenTo App.Vent, "project:destroy", @swapMainToEmpty
		@listenTo App.Vent, "project:edit", @editProject

	render: ->
		@$el.html(@template())
		@

	editProject: (model ) ->
		@swapMain(new App.Views.NewProject({ model: model}))
		Backbone.history.navigate('projects/edit/' + model.id)

	swapMainToEmpty: ->
		@swapMain(new App.Views.Empty())
		Backbone.history.navigate("/projects")

	swapMain: (v) ->
		@changeCurrentMainView(v)
		@$('#main-area').html(@currentMainView.render().el)

	changeCurrentMainView: (v) ->
		@currentMainView.leave() if @currentMainView
		@currentMainView = v

	swapSide: (v) ->
		@changeCurrentSideView(v)
		@$('#sidebar-area').html(@currentSideView.render().el)

	changeCurrentSideView: (v) ->
		@currentSideView.leave() if @currentSideView
		@currentSideView = v

	swapMainToNewProject: ->
		@swapMain(new App.Views.NewProject({ model : new App.Models.Project}))
		Backbone.history.navigate("/projects/new")

	projectShow: (model) ->
		@swapMain(new App.Views.ProjectDetails({ model: model}))
