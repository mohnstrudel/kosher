module Utility

  def pretty_url
    url = self.url
    if (URI::regexp(%w(http https)) =~ url) == nil
      url = "http://#{url}"
    end
    return url
  end
end