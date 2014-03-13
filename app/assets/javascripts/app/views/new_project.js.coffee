class App.Views.NewProject extends Backbone.View

	template: HandlebarsTemplates['app/templates/new_project']

	events:
		"click button": "saveProject"

	initialize: ->
		@listenTo @model, "sync", @triggerProjectCreate

	triggerProjectCreate: ->
		App.Vent.trigger "project:create", @model

	render: ->
		@$el.html(@template(@model.toJSON()))
		@

	saveProject: (e) ->
		e.preventDefault()
		@model.set name: @$('#name').val()
		@model.set description: @$('#description').val()
		@model.save()

		###
		or we can use callbacks instead of line 8 - 12.
		@model.save {},
			success: (model) -> App.Vent.trigger "project:create", model 


		###