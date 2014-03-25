module BasicAuthHelper
  def require_basic_auth(user, pass)
    return if authorized?(user, pass)
    headers['WWW-Authenticate'] = 'Basic realm="Restricted Area"'
    halt 401, { "error" => "Not authorized." }.to_json
  end

  def authorized?(user, pass)
    @auth ||=  Rack::Auth::Basic::Request.new(request.env)
    @auth.provided? and @auth.basic? and @auth.credentials and @auth.credentials == [user, pass]
  end
end
