class LandmarksController < ApplicationController
  # add controller methods
  get '/landmarks/new' do
    erb :'landmarks/new'
  end

  post '/landmarks' do
    Landmark.create(name: params[:landmark][:name], year_completed: params[:landmark][:year_completed])
    redirect :'/landmarks'
  end

  get '/landmarks' do
    @landmarks = Landmark.all
    erb :'landmarks/index'
  end

  get '/landmarks/:id' do
    @landmark = Landmark.find_by(id: params[:id])
    erb :'landmarks/show'
  end

  get "/landmarks/:id/edit" do
    @landmark = Landmark.find_by(id: params[:id])
    erb :'landmarks/edit'
  end

  patch '/landmarks/:id' do
    landmark = Landmark.find_by(id: params[:id])
    landmark.update(name: params[:landmark][:name], year_completed: params[:landmark][:year_completed])
    redirect :"landmarks/#{landmark.id}"
  end
end
