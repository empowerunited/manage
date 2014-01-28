class TableCheckboxes
  constructor: (el) ->
    $el  = $(el)
    $mainContainer = $el.closest('table')

    $el.on 'click', (event, element)->
      check = if $el.is(':checked') then true else false

      $mainContainer.find('.rs').each ->
        $(@).prop('checked', check)

Handlers.register 'TableCheckboxes', TableCheckboxes