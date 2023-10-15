class HealthRoutes < Sinatra::Base
    
  get('/') do
    if request.env['AUTHED'] == true
      status 200
      'App working OK'
    else
      status 200
      'App working OK'
    end
  end
end

