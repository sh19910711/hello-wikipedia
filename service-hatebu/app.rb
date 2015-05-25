class App < Padrino::Application

  register Padrino::Helpers
  set :public_folder, "public/"

  get :index do
    render :main
  end

end
