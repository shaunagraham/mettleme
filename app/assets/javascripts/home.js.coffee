jQuery ->

  $("#session_email").blur(->
    @value = "Email"  if @value is ""
    return
  ).focus ->
    @value = ""  if @value is "Email"
    return

  $("#session_password").blur(->
    @type = "password"
    @value = "Password"  if @value is ""
    return
  ).focus ->
    @type = "text"
    @value = ""  if @value is "Password"
    return