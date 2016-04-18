VimModeTransposeView = require './vim-mode-transpose-view'
{CompositeDisposable} = require 'atom'

module.exports = VimModeTranspose =
  vimModeTransposeView: null
  modalPanel: null
  subscriptions: null

  activate: (state) ->
    @vimModeTransposeView = new VimModeTransposeView(state.vimModeTransposeViewState)
    @modalPanel = atom.workspace.addModalPanel(item: @vimModeTransposeView.getElement(), visible: false)

    # Events subscribed to in atom's system can be easily cleaned up with a CompositeDisposable
    @subscriptions = new CompositeDisposable

    # Register command that toggles this view
    @subscriptions.add atom.commands.add 'atom-workspace', 'vim-mode-transpose:toggle': => @toggle()

  deactivate: ->
    @modalPanel.destroy()
    @subscriptions.dispose()
    @vimModeTransposeView.destroy()

  serialize: ->
    vimModeTransposeViewState: @vimModeTransposeView.serialize()

  toggle: ->
    console.log 'VimModeTranspose was toggled!'

    if @modalPanel.isVisible()
      @modalPanel.hide()
    else
      @modalPanel.show()
