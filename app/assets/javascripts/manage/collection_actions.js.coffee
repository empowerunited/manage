class CollectionActions
  constructor: (el) ->
    $el  = $(el)

    $el.on 'click', 'a', (e) ->
      e.stopPropagation()
      e.preventDefault()

      url = $(@).attr('href')
      requestType = $(@).data('method')

      # TODO : fetch search form params
      dataParams =  []
      $('.rs:checked').each ->
        dataParams.push($(@).attr('value'))

      if dataParams.length == 0
        alert 'Няма направвен избор'
        return false

      $.ajax(
        url: url
        type: requestType
        data: { selected_ids: dataParams }
      ).fail ->
        alert('Възникна грешка')

Handlers.register 'CollectionActions', CollectionActions
