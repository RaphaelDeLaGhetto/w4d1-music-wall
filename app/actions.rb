

# Homepage (Root path)
get '/' do
  erb :index
end

#
# tracks
#
get '/tracks' do
  @tracks = Track.joins('LEFT OUTER JOIN upvotes ON upvotes.track_id = tracks.id').all.group(:id).order('COUNT(upvotes.track_id) DESC')
  erb :'tracks/index'
end

get '/tracks/new' do
  @track = Track.new
  erb :'tracks/new'
end

get '/tracks/:id' do
  @track = Track.find params[:id]
  erb :'tracks/show'
end

post '/tracks' do
  @track = Track.new(
              song_title: params[:song_title],
              url: params[:url],
              author:  params[:author],
              user: current_user
            )
  if @track.save
    redirect '/tracks'
  else
    erb :'tracks/new'
  end
end

#
# users
#
get '/users/new' do
  @user = User.new
  erb :'users/new'
end

post '/users' do
  @user = User.new(
              email: params[:email],
              password: params[:password],
              password_confirmation: params[:password_confirmation]
          )
  if @user.save
    redirect '/tracks'
  else
    erb :'users/new'
  end
end

#
# sessions
#
get '/login' do
  erb :'sessions/new'
end

post '/login' do
  user = User.find_by(email: params[:email])

  if user && user.authenticate(params[:password])
    session[:user_id] = user.id
    redirect '/tracks'
  else
    erb :'sessions/new'
  end
end

get '/logout' do
  session[:user_id] = nil
  redirect '/', notice: "Adios!"
end

#
# upvote
#
post '/upvote' do
  current_user.upvotes.create(track_id: params[:track_id]) if current_user.upvotes.where(track_id: params[:track_id]).empty?
  redirect '/tracks'
end


#
# helpers
#
helpers do
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
end


