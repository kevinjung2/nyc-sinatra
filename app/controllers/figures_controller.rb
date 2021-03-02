class FiguresController < ApplicationController
  # add controller methods
  get '/figures/new' do
    @titles = Title.all
    @landmarks = Landmark.all
    erb :'/figures/index'
  end

  post '/figures' do
    figure = Figure.create(name: params[:figure][:name])
    if params[:figure][:title_ids]
      params[:figure][:title_ids].each do |id|
        figure.titles << Title.find_by(id: id)
      end
    end
    if params[:figure][:landmark_ids]
      params[:figure][:landmark_ids].each do |id|
        figure.landmarks << Landmark.find_by(id: id)
      end
    end
    figure.landmarks << Landmark.create(name: params[:landmark][:name]) unless params[:landmark][:name] == ""
    figure.titles << Title.create(name: params[:title][:name]) unless params[:title][:name] == ""
    redirect :'/figures'
  end

  get '/figures' do
    @figures = Figure.all
    erb :'/figures/all'
  end

  get "/figures/:id" do
    @figure = Figure.find_by(id: params[:id])
    erb :'/figures/show'
  end

  get "/figures/:id/edit" do
    @figure = Figure.find_by(id: params[:id])
    erb :'/figures/edit'
  end

  patch "/figures/:id" do
    figure = Figure.find_by(id: params[:id])
    figure.landmarks << Landmark.create(name: params[:figure][:landmark][:name])
    figure.update(name: params[:figure][:name])
    redirect :"/figures/#{figure.id}"
  end
end
