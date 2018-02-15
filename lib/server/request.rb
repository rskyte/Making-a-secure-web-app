require 'pry'

class Request
  attr_reader :text_arr, :hash, :params

  def initialize(text)
    @text_arr = text.split("\r\n")
    @hash = {}
    @params = {}
  end

  def generate_hashes
    create_hash
    create_params_hash if get_method == 'POST'
  end

  def get_method
    hash['method']
  end

  def get_location
    hash['location']
  end

  def get_param(param)
    params[param]
  end

  def get_cookie(key)
    return if !hash['Cookie']
    cookie_hash = hash['Cookie'].split('; ').map { |cookie| cookie.split('=', 2) }.to_h
    cookie_hash[key]
  end

  def has_cookie?
    !!hash['Cookie']
  end

  private

  def create_hash
    hash['method'], @hash['location'] = text_arr.shift.split(' ')
    text_arr.each do |item|
      key, value = item.split(':')
      if key && value
        hash[key] = value.strip
      else
        hash['body'] = key
      end
    end
  end

  def create_params_hash
    p 'post request received, creating params:'
    if hash['body']
      param_arr = hash['body'].split('&')
      param_arr.each { |item|
        key, value = item.split('=')
        params[key] = value
      }
    end
  end

end
