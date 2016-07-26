$( document ).ready () ->
      $(".edit").on "click", (e) ->
        $(e.target).closest("tr").find(".display-contact").hide().siblings(".edit-contact").show()
        $(e.target).closest("tr").find("textarea").val("ZORG!")
      $(".cancel").on "click", (e) ->
        $(e.target).closest("tr").find(".display-contact").show().siblings(".edit-contact").hide()

      # Редактирование контактов

      #$('.add').on 'click',  (e) ->
      #  e.preventDefault()
      #  $.ajax {
      #    type: 'POST',
      #    url: '/request',
      #    data: $('e.target').closest("tr").find(".name").serialize() + $('e.target').closest("tr").find(".email").serialize() + $('e.target').closest("tr").find(".phone").serialize() + $('e.target').closest("tr").find(".message").serialize()
      #    success: (data) ->
      #      ???
      #    error: (error) ->
      #      ???
      #    dataType: 'JSON'
      #  }