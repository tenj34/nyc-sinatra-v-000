class ApplicationController < Sinatra::Base
  set :views, proc { File.join(root, '../views/') }
  register Sinatra::Twitter::Bootstrap::Assets

  get '/' do
    erb :"application/index"
  end

  patch '/figures/:id' do
    @figure = Figure.find_by_id(params[:id])
    @figure.update(name: params[:figure][:name])
    if params["landmark"]["name"] != nil
      landmark = Landmark.create(name: params["landmark"]["name"])
      landmark.figure_id = @figure.id
      @figure.landmarks << landmark
    end
    redirect to "/figures/#{@figure.id}"
  end

  patch '/landmarks/:id' do
    @landmark = Landmark.find_by_id(params[:id])
    @landmark.update(name: params[:landmark][:name], year_completed: params[:landmark][:year_completed])

    redirect to "/landmarks/#{@landmark.id}"
  end
end
