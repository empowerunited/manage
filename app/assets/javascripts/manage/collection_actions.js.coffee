class CollectionActions
  constructor: (el) ->
    $el  = $(el)

    $form = $el.closest('form')

    $el.on 'click', (e) ->
      e.stopPropagation()
      e.preventDefault()

      checkedCheckboxes = $('.rs:checked')
      unless checkedCheckboxes.length
        alert 'Select Items'
        return false

      # clear all hidden fields with class .hidden_selected_ids
      $form.find('input[type="hidden"]').remove()

      checkedCheckboxes.each ->
        # create a new hidden
        hidden_input = $('<input>').attr({
          type: 'hidden',
          name: 'selected_ids[]',
          value: $(@).val()
        }).appendTo($form)

      $form.submit()


Handlers.register 'CollectionActions', CollectionActions
