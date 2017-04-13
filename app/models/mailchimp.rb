class Mailchimp

  require 'curb'

  attr_accessor :api_key, :region

  def initialize
    # Populate this values
    self.api_key = "c15e30d585d1439efb7999d98286b1a5-us8"
    self.region = "us8"
  end

  def create_list
    http = Curl.post("https://#{region}.api.mailchimp.com/3.0/lists") do |http|
      http.headers['user'] = "anystring:#{api_key}"
      http.headers['header'] = 'content-type: application/json'
      http.headers['data'] = {"name" => "Kosher List",
        "contact" => {
          "company" => "MailChimp",
          "address1" => "675 Ponce De Leon Ave NE",
          "address2" => "Suite 5000",
          "city" => "Atlanta",
          "state" => "GA",
          "zip" => "30308",
          "country" => "US",
          "phone" => ""
          },
        "permission_reminder" => "You'\''re receiving this email because you signed up for updates about Freddie'\''s newest hats.",
        "campaign_defaults" => {
          "from_name" => "Freddie",
          "from_email" => "freddie@freddiehats.com",
          "subject" => "",
          "language" => "en"
          },
        "email_type_option" => true}
    end
  end

  def fetch_lists
    http = Curl.get("https://#{region}.api.mailchimp.com/3.0/lists") do |http|
      http.headers['user'] = "anystring:#{api_key}"
    end
  end

end