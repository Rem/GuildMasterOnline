class CharactersController < ApplicationController

  get '/characters' do
    if logged_in?
      @characters = Character.all
      erb :'/characters/index'
    else
      redirect to '/login'
    end
  end

  get '/characters/new' do
    if logged_in?
      erb :'/characters/new'
    else
      redirect to '/login'
    end
  end

  post '/characters' do
    if logged_in?
      @character = current_user.characters.build(name: params[:name],race: params[:race], lore: params[:lore], power: params[:power])
      if @character.save
        redirect to "/characters/#{@character.id}"
      else
        redirect to '/characters/new'
      end
    else
      redirect to '/login'
    end
  end

    get '/characters/:id' do
     if logged_in?
       @character = Character.find_by_id(params[:id])
       erb :'/characters/show'
     else
       redirect to '/login'
     end
    end

end
