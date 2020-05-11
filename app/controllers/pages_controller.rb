class PagesController < ApplicationController
  require 'discogs'

  before_action do
    @discogs = Discogs::Wrapper.new("Label Mates", user_token: "zQTIHZUhvDLiAOGaLjQZDaDLYdfEEYmGchCgkRmu")
  end

  # before_action :authenticate
  # before_action :callback

  skip_before_action :authenticate_user!


  def home
  end

  def index
  end

  def authenticate
    app_key      = ENV["DISCOGS_API_KEY"]
    app_secret   = ENV["DISCOGS_API_SECRET"]
    request_data = @discogs.get_request_token(app_key, app_secret,
                     "http://127.0.0.1:3000/pages/callback")

    session[:request_token] = request_data[:request_token]

    redirect_to request_data[:authorize_url]
  end

  def callback
    request_token = session[:request_token]
    verifier      = params[:oauth_verifier]
    access_token  = @discogs.authenticate(request_token, verifier)

    session[:request_token] = nil
    session[:access_token]  = access_token

    redirect_to :action => "index"
  end

  def artist_search
    if params[:query]
      @search = @discogs.search("#{params[:query]}", :per_page => 2, :type => :label)
    end
  end

  def label_search
  end

  private

end
