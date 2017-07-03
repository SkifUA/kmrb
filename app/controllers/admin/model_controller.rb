class Admin::ModelController < Admin::BaseController

  def index
    @model = object_model params[:model]
    @index = @model.all
  end

  def show
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private
  def name_model(param)
    param
        .singularize
        .camelize
  end

  def object_model(param)
    Kernel.const_get(name_model param)
  end

end
