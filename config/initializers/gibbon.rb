Gibbon::Request.api_key = Figaro.env.mailchimp_api_key
Gibbon::Request.open_timeout = 15
Gibbon::Request.symbolize_keys = true
Gibbon::Request.debug = false