$(document).on "turbolinks:load", ->
  if $('.bricklayer').length
    $("a[id='load-more']").click (e) ->
      e.preventDefault()
      page_url = $('#load-more').attr('href')
      isLoadingData = true
      $('#load-more').hide()
      $('#loading-gif').show()
      #This function resides in published-at.js
      data_container = $('#data-container').attr('value')
      #Make an ajax call passing along our last published_at date

      $.ajax
          #Make a get request to the server
          type: "GET",
          #Get the url from the href attribute of our link
          url: page_url,
          #Send the last published_at time to our rails app
          data:
            feed_data: data_container,
          #The response will be a script
          dataType: "script",
          #Upon success
          success: ->
              isLoadingData = false
              $('#load-more').show()
              $('#loading-gif').hide()
