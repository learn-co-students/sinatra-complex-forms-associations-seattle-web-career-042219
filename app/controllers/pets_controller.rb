class PetsController < ApplicationController

  get '/pets' do
    @pets = Pet.all
    erb :'/pets/index'
  end

  get '/pets/new' do
    erb :'/pets/new'
  end

  post '/pets' do
    @pet = nil
    if !params[:owner_name].empty?
      @owner = Owner.create(name: params[:owner_name])
      @pet = Pet.create(name: params[:pet_name], owner_id: @owner.id)
    else
      @pet = Pet.create(name: params[:pet_name], owner_id: params[:pet][:owner_id])
    end
    #binding.pry
    redirect to "/pets/#{@pet.id}"
  end

  get '/pets/:id' do
    @pet = Pet.find(params[:id])
    erb :'/pets/show'
  end

  get '/pets/:id/edit' do
    @pet = Pet.find(params[:id])
    erb :'/pets/edit'
  end

  patch '/pets/:id' do
    #binding.pry
    @pet = Pet.find(params[:id])
    #@owner = nil
    if !params[:owner_name].empty?
      @owner = Owner.create(name: params[:owner_name])
      @pet.update(name: params[:pet_name], owner_id: @owner.id)
    else
      @pet.update(name: params[:pet_name], owner_id: params[:owner][:name])
    end
    #binding.pry
    #if !params[]
    redirect to "/pets/#{@pet.id}"
  end
end
