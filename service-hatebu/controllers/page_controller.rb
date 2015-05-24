App.controller :pages do

  get :index do
    Page.all.map(&:as_json).to_json
  end

end
