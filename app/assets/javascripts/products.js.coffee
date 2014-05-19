jQuery ->
 $("#search_sunspot").change ->
   $("#search").attr "value", $(this).val()
   return

 $("#search_sunspot").keyup (e) ->
   $("#search_form").submit()  if e.keyCode is 13
   return



 $(".category").on "click", ->
   $(".subcategory").hide()
   $(this).next().show()
   return

 $(".filter_gender").click ->
   $(".filter_gender").each ->
     $(this).attr "checked", false
     return

   $(this).attr "checked", true
#   $("#search_form").submit()
#   return

 $(".filter").click ->
   $.get $("#search_form").attr("action"), $("#search_form").serialize(), null, "script"

 $(".colors").click ->
   checkbox = $(this).next()
   if checkbox.attr("checked") is `undefined` or checkbox.attr("checked") is false
     checkbox.attr "checked", true
     checkbox.parent().addClass 'active'
     $.get $("#search_form").attr("action"), $("#search_form").serialize(), null, "script"
   else
     checkbox.attr "checked", false
     checkbox.parent().removeClass 'active'
     $.get $("#search_form").attr("action"), $("#search_form").serialize(), null, "script"

 $(".subscriber :checkbox").change ->
  $cs = $(this).closest(".subscriber").find(":checkbox:checked")
  @checked = false  if $cs.length > 3
  return




