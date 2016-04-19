{CompositeDisposable} = require 'atom'

module.exports = VimModeTranspose =
  subscriptions: null

  activate: (state) ->
    @subscriptions = new CompositeDisposable

    @subscriptions.add atom.commands.add 'atom-text-editor.vim-mode.normal-mode',
      'vim-mode-transpose:transpose': => @transpose()

  deactivate: ->
    @subscriptions.dispose()

  transpose: ->
    editor = atom.workspace.getActiveTextEditor()
    for p in editor.getCursorBufferPositions()
      current = editor.getTextInBufferRange([p, p.traverse([0, 1])])
      next = editor.getTextInBufferRange([p.traverse([0, 1]), p.traverse([0, 2])])
      editor.setTextInBufferRange([p, p.traverse([0, 2])], next + current)
