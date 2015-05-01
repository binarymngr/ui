Spine  = @Spine or require('spine')
Server = require('models/server')

class ServersSingleStack extends Spine.Controller
  @extend Spine.Bindings

  className: 'col-xs-12'
  events:
    'click .can-cancel' : 'cancel'
    'click .can-destroy': 'destroy'
    'click .can-save'   : 'save'

  modelVar: 'model'
  bindings:
    # '.item input[name="id"]'      : 'id'
    '.item input[name="name"]'    : 'name'
    '.item input[name="ipv4"]'    : 'ipv4'
    # '.item input[name="owner_id"]': 'owner_id'

  constructor: ->
    super

    @routes
      '/servers/:id': (params) ->
        @render params

    Server.fetch()
    @model = new Server
    do @applyBindings

  cancel: (event) =>
    @navigate('/servers')

  destroy: (event) =>
    @model.destroy()
    @navigate('/servers')  # TODO: add check destory and confirm action

  render: (params) =>
    @model = Server.find(params.id)
    do @applyBindings
    @html @template @model

  save: (event) =>
    @model.save()  # TODO: add check destory and confirm action

  template: (item) ->
    require('views/servers/single')
      server: item

module.exports = ServersSingleStack
