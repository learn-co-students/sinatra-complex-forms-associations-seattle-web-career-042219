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
    @pet = Pet.create(name: params[:pet][:name])
    if params.keys.include?('owner_id')
      if !params[:owner_id].empty?
        owner = Owner.find(params[:owner_id])
        @pet.update(owner_id: owner.id)
        owner.pets << @pet
      end
    elsif !params[:owner_name].empty?
        owner = Owner.create(name: params[:owner_name])
        @pet.update(owner_id: owner.id)
        owner.pets << @pet
      end
    redirect to "pets/#{@pet.id}"
  end

  get '/pets/:id' do
    @pet = Pet.find(params[:id])
    erb :'/pets/show'
  end


  patch '/pets/:id' do
    orig_owner = nil
    @pet = Pet.find(params[:id])
    if @pet.owner_id != nil
      orig_owner = @pet.owner
    end
    if !params[:owner][:name].empty?
      owner = Owner.create(params[:owner])
      @pet.update(owner_id: owner.id)
      owner.pets << @pet
      if orig_owner !=nil
        orig_owner.pets.delete(@pet)
      end
    elsif params.has_key?('owner_id')
      if !params[:owner_id].empty?
        owner = Owner.find(params[:owner_id])
        @pet.update(name: params[:pet_name], owner_id: params[:owner_id])
        owner.pets << @pet
        if orig_owner != nil
          orig_owner.pets.delete(@pet)
        end
      end
    end
    redirect "pets/#{@pet.id}"
  end

  get '/pets/:id/edit' do
  @owners = Owner.all
  @pet = Pet.find(params[:id])

  erb :'/pets/edit'
  end
end
