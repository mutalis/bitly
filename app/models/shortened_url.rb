class ShortenedUrl < ApplicationRecord
  validates :unique_key, presence: true
  validates :url, presence: true,
  format: { with: /^(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(([0-9]{1,5})?\/.*)?$/, multiline: true}


  REGEX_LINK_HAS_PROTOCOL = Regexp.new('\Ahttp:\/\/|\Ahttps:\/\/', Regexp::IGNORECASE)

  @@unique_key_length = 6

  cattr_accessor :unique_key_length

  # ensure the url starts with it protocol and is normalized
  def self.clean_url(url)

    url = url.to_s.strip

    if url !~ REGEX_LINK_HAS_PROTOCOL && url[0] != '/'
      url = "/#{url}"
    end
    URI.parse(url).normalize.to_s
  end

  # Returns shortened unique url key on success, nil on failure
  def self.generate(destination_url)
    begin
      retries ||= 0
      su = find_or_create_by!(url: clean_url(destination_url)) do |c|
        c.unique_key = SecureRandom.urlsafe_base64(unique_key_length)
      end
      return su.try(:unique_key)
    rescue ActiveRecord::RecordNotUnique, ActiveRecord::StatementInvalid => err
      logger.info('Failed to generate ShortenedUrl with unique_key')
      if (retries += 1) < 5
        logger.info('Retrying with different unique key')
        retry
      else
        logger.info('Too many retries, giving up')
        nil
      end
    end
  end

  def self.fetch_with_token(token: nil)
    shortened_url = ShortenedUrl.where(unique_key: token).first

    if shortened_url
      shortened_url.url
    else
      '/'
    end
  end

end
