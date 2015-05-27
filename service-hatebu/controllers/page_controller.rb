App.controller :pages do

  get :index do
    @pages = Page.all.map(&:as_json)
    @pages.to_json
  end

  get :index, :with => [:page_id] do
    @page = Page.find_by(:page_id => params[:page_id])
    render :page
  end

end
