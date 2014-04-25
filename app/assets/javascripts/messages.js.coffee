jQuery ->

  $("#message_delete_id").on "click", ->
    $("#delete_message_form").submit()

  $("#check_all_checkall").change ->
    if $(this).is(":checked")
      $(".message_check").each ->
        $(this).prop "checked", true
    else
      $(".message_check").each ->
        $(this).prop "checked", false

