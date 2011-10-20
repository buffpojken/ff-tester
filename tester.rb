require 'rubygems'
require 'base64'
require 'json'
require 'restclient'
require 'sinatra'
require 'digest/sha1'

set :root, File.dirname(__FILE__)
set :shared_secret, "ninja"


get '/' do 
  
  @user_data = {
    :username         => "buffpojken", 
    :email            => "daniel@qubator.com", 
    :account_name     => "dolphin kingdom"
  }

  expires = (Time.now + 600).to_i
  @signature = Digest::SHA1.hexdigest("ninja" + "POST" + "/api/accounts/buffpojken" + expires.to_s)
  @user_data[:expires] = expires.to_s

  
  @payload = Base64.encode64(JSON.generate(@user_data))
  
  
  erb :index
end

