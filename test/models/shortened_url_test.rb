require 'test_helper'

class ShortenedUrlTest < ActiveSupport::TestCase

  setup do
    @shorturl = create(:ShortenedUrl)
  end

  test 'valid short url' do
    assert @shorturl.valid?
  end

  test 'invalid without unique key' do
    shorturl = build(:ShortenedUrl)
    shorturl.unique_key = nil
    refute shorturl.valid?, 'saved shorturl without a unique key'
    # puts shorturl.errors[:unique_key].inspect
    refute_empty shorturl.errors[:unique_key], 'no validation error for unique key present'
  end

  test 'invalid without a Url' do
    shorturl = build(:ShortenedUrl)
    shorturl.url = nil
    refute shorturl.valid?, 'saved shorturl without a Url'
    # puts shorturl.errors[:url].inspect
    refute_empty shorturl.errors[:url], 'no validation error for Url present'
  end

  test 'invalid Url' do
    shorturl = build(:ShortenedUrl)
    shorturl.url = Faker::Internet.domain_name
    refute shorturl.valid?, 'saved shorturl with an invalid Url'
    # puts shorturl.errors[:url].inspect
    refute_empty shorturl.errors[:url], 'no validation error for valid Url'
  end

  test 'fetch with a valid token' do
    shorturl = ShortenedUrl.fetch_with_token(token: @shorturl.unique_key)
    assert_equal shorturl, @shorturl.url
  end

  test 'fetch the "/" character with an invalid token' do
    shorturl = ShortenedUrl.fetch_with_token(token: 'the invalid token')
    assert_equal shorturl, '/'
  end
end
