require 'pry'
class UsersController < ApplicationController

    get '/' do
        erb :index
    end

    get "/signup" do
        if logged_in?
            redirect "/tweets"
        end
        puts session
        erb :"users/signup"
    end

    post '/signup' do
        if params[:username].empty? || params[:email].empty? || params[:password].empty?
            redirect :'/signup'
        elsif User.find_by(username: params[:username])
            redirect :"/signup"
        elsif User.find_by(email: params[:email])
            redirect :'/signup'
        else
            @user = User.create(params)
            session[:user_id] = @user.id

            redirect :'/tweets'
        end
    end

    get "/login" do
        if logged_in?
            redirect "/tweets"
        end
        erb :'users/login'
    end

    post '/login' do
        @user = User.find_by(username: params["username"])
        if @user && @user.authenticate(params["password"])
            session[:user_id] = @user.id

            redirect '/tweets'
        end
        erb :'users/login'
    end

    get '/logout' do
        if !logged_in?
            redirect "/"
        end
        session.clear
        redirect "/login"
    end

    get '/users/:slug' do
        @user = User.find_by_id(params[:slug])
        erb :'/users/show'
    end

end