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
      flash[:error] = "You must be logged in to create a character!"
      redirect to '/login'
    end
  end

  post '/characters' do
    if logged_in?
      @character = current_user.characters.build(name: params[:name],race: params[:race], lore: params[:lore], power: params[:power])
      if @character.save
        flash[:message] = "Character succesfully created!"
        redirect to "/characters/#{@character.id}"
      else
        flash[:error] = "Character creation failure: #{@character.errors.full_messages.to_sentence}"
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

    get '/characters/:id/edit' do
      if logged_in?
        @character = Character.find_by_id(params[:id])
        if @character && @character.user == current_user
          erb :'characters/edit'
        else
          redirect to '/characters'
        end
      else
        redirect to '/login'
      end
    end

    patch '/characters/:id' do
      if logged_in?
        @character = Character.find_by_id(params[:id])
        if @character && @character.user == current_user
          if @character.update(params)
            flash[:message] = "Character succesfully updated!"
            redirect to "/characters/#{@character.id}"
          else
            flash[:error] = "Character update failure: #{@character.errors.full_messages.to_sentence}"
            redirect to "/characters/#{@character.id}/edit"
          end
        else
          redirect to "/characters/#{@character.id}"
        end
      else
        redirect to '/login'
      end
    end

  delete '/characters/:id/delete' do
    if logged_in?
      @character = Character.find_by_id(params[:id])
      if @character && @character.user == current_user
        @character.delete
        redirect to '/characters'
      end
    else
      redirect to '/login'
    end
  end

end
