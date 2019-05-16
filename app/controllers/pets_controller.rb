class PetsController < ApplicationController

  get '/pets' do
    @pets = Pet.all
    erb :'/pets/index'
  end

  get '/pets/new' do
    @owners = Owner.all
    erb :'/pets/new'
  end

  post '/pets' do
    # binding.pry
    if params[:owner_name] != ""
      @owner = Owner.create(name: params[:owner_name])
    else
      @owner = Owner.find(params[:owner_id])
    end

    @pet = Pet.create(name: params[:pet_name], owner_id: @owner.id)
    redirect to "pets/#{@pet.id}"
  end

  get '/pets/:id' do
    @pet = Pet.find(params[:id])
    erb :'/pets/show'
  end

  get '/pets/:id/edit' do
    @pet = Pet.find(params[:id])
    @owners = Owner.all
    erb :'/pets/edit'
  end

  patch '/pets/:id' do
    @pet = Pet.find(params[:id])
    @owners = Owner.all
    if params[:owner_name] != ""
      @owner = Owner.create(name: params[:owner_name])
    else
      @owner = Owner.find(params[:owner_id])
    end
    # binding.pry
    @pet = Pet.update(@pet.id, {name: params[:pet_name], owner_id: @owner.id})
    redirect to "pets/#{@pet.id}"
  end
end
