class Admin::NewslettersController < AdminController

  def index
    newsletter = Mailchimp.new
    newsletter.fetch_lists
  end
end
