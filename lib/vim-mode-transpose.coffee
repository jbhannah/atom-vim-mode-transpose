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
      q = p.traverse([0, 1])
      r = p.traverse([0, 2])
      current = editor.getTextInBufferRange([p, q])
      next = editor.getTextInBufferRange([q, r])
      editor.setTextInBufferRange([p, r], next + current)
