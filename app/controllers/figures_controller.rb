class FiguresController < ApplicationController
  # add controller methods
  get '/figures' do
    @figures = Figure.all
    erb :'figures/index'
  end

  get '/figures/new' do
    erb :'figures/new'
  end

  post '/figures' do
    figure = Figure.create(name: params["figure"]["name"])
    if params["figure"]["title_ids"] != nil
      figure.title_ids += params["figure"]["title_ids"]
    elsif params["figure"]["landmark_ids"] != nil
      figure.landmark_ids += params["figure"]["landmark_ids"]
    elsif params["title"]["name"] != ""
      title = Title.create(name: params["title"]["name"])
      figure.titles << title
    else params["landmark"]["name"] != nil
      landmark = Landmark.create(name: params["landmark"]["name"])
      landmark.figure_id = figure.id
      figure.landmarks << landmark
    end
    figure.save
     redirect to "/figures/:id"
  end

  get '/figures/:id' do
    @figure = Figure.find_by_id(params[:id])
    erb :'figures/show'
  end
  
   get '/figures/:id/edit' do
    @figure = Figure.find_by_id(params[:id])
    erb :'figures/edit'
  end

end
