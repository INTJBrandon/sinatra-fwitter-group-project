class TweetsController < ApplicationController

    get '/tweets' do

        if logged_in?
          @tweets = Tweet.all
          erb :index
        else

          redirect :'/login'
        end
    end
    
      get '/tweets/new' do
        if logged_in?
          erb :'/tweets/new'
        else

          redirect :'/login'
        end
      end
    
      post '/tweets' do
        if params[:content].empty?

          redirect :'/tweets/new'
        else
          @tweet = Tweet.create(params)
          @tweet.user_id = session[:user_id]
          @tweet.save
    

          redirect :"tweets/#{@tweet.id}"
        end
      end
    
      get '/tweets/:id' do
        if logged_in?
          @tweet = Tweet.find_by_id(params[:id])
          erb :'/tweets/show'
        else

          redirect :'/login'
        end
      end
    
      get '/tweets/:id/edit' do
        if logged_in?
          @tweet = Tweet.find(params[:id])
          if @tweet && session[:user_id] == @tweet.user_id
            erb :'/tweets/edit'
          else
            redirect :'/tweets'
          end
        else
    
          redirect :"/login"
        end
      end
    
      patch '/tweets/:id' do
        @tweet = Tweet.find_by_id(params[:id])
    
        if params[:content].empty?
        
          redirect :"/tweets/#{@tweet.id}/edit"
        elsif params[:content] == @tweet.content
        
          redirect :"/tweets/#{@tweet.id}"
        else
          @tweet.content = params[:content]
          @tweet.save
        
          redirect :"/tweets/#{@tweet.id}"
        end
      end
    
      
        post '/tweets/:id/delete' do
          if logged_in?
            @tweet = Tweet.find(params[:id])
            if @tweet && @tweet.user_id == session[:user_id]
              @tweet.delete
            
              redirect :'/tweets'
            else
            
              redirect :'/tweets'
            end
          else
        
            redirect :'users/login'
          end
        end

end