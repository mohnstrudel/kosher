class Mailchimp

  def initialize(params=nil)
    # @gibbon = Gibbon::Request.new(api_key: Figaro.env.mailchimp_api_key)
    if params
      @title = params[:title]
      @body = params[:body]
      @email = params[:email]
      @template_id = params[:template_id]
    end
  end

  def get_user_templates
    # Возвращает массив структуры
    # [{:id=>30983, :type=>"user", :name=>"Tell A Story", :drag_and_drop=>true, :responsive=>true, :category=>"", :date_created=>"2017-08-15T17:05:22+00:00",
    # :created_by=>"Anton Kostin", :active=>true, :thumbnail=>"http://gallery.mailchimp.com/ed88701ad0942e43ad9dd59f3/template-screens/30983_screen.1.png",
    # :share_url=>"", :_links=>[{:rel=>"self", :href=>"https://us16.api.mailchimp.com/3.0/templates/30983", :method=>"GET", :targetSchema=>"https://us16.api.mailchimp.com/schema/3.0/Definitions/Templates/Response.json"},
    # {:rel=>"parent", :href=>"https://us16.api.mailchimp.com/3.0/templates", :method=>"GET", :targetSchema=>"https://us16.api.mailchimp.com/schema/3.0/Definitions/Templates/CollectionResponse.json", :schema=>"https://us16.api.mailchimp.com/schema/3.0/CollectionLinks/Templates.json"}, {:rel=>"delete", :href=>"https://us16.api.mailchimp.com/3.0/templates/30983", :method=>"DELETE"}, {:rel=>"default-content", :href=>"https://us16.api.mailchimp.com/3.0/templates/30983/default-content", :method=>"GET", :targetSchema=>"https://us16.api.mailchimp.com/schema/3.0/Definitions/Templates/Default-Content/Response.json", :schema=>"https://us16.api.mailchimp.com/schema/3.0/CollectionLinks/Templates.json"}]}]
    Gibbon::Request.templates.retrieve(params: {"type": "user"}).body[:templates]
  end

  def subscribe
    begin
      puts "Subscribing user using params: #{@email}"
      gibbon = Gibbon::Request.new(api_key: Figaro.env.mailchimp_api_key)
      result = gibbon.lists(Figaro.env.mailchimp_list_id).members.create(body: {email_address: @email, status: "subscribed", merge_fields: {FNAME: "Kosher.ru", LNAME: "User"}})
      if result
        puts "User added successfully"
      else
        puts "Subscribing error"
      end
    rescue Gibbon::MailChimpError => e
      puts "Houston, we have a problem: #{e.message} - #{e.raw_body}"
    end
  end

  def unsubscribe
    email = Digest::MD5.hexdigest(@email)
    Gibbon::Request.lists(Figaro.env.mailchimp_list_id).members(email).update(body: { status: "unsubscribed" })
  end

  def deliver_campaign
    campaign_id = create_campaign
    body = {
      template: {
      id: @template_id.to_i
        # sections: {
        #   "name-of-mc-edit-area": "Content here"
        # }
      }
    }
    # Gibbon::Request.campaigns(campaign_id).content.upsert(body: { html: @body })
    Gibbon::Request.campaigns(campaign_id).content.upsert(body: body)
    begin
      Gibbon::Request.campaigns(campaign_id).actions.send.create
    rescue Gibbon::MailChimpError => e
      puts "Houston, we have a problem: #{e.message} - #{e.raw_body}"
    end
  end

  def create_campaign
    recipients = {
      list_id: Figaro.env.mailchimp_list_id
    }
    settings = {
      subject_line: @title,
      title: @title,
      from_name: "Anton Kosherstin",
      reply_to: "anton@yadadya.com"
    }

    body = {
      type: "regular",
      recipients: recipients,
      settings: settings
      # html: @body
    }

    begin
      response = Gibbon::Request.campaigns.create(body: body)
      return response.body[:id]
    rescue Gibbon::MailChimpError => e
      puts "Houston, we have a problem: #{e.message} - #{e.raw_body}"
    end
  end
end