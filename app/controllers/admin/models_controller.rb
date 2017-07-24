class Admin::ModelsController < Admin::BaseController

  before_action :get_object_model

  def index
    @visible_columns = visible_columns @model
    @index = @model.all
  end

  def show
    @visible_columns = visible_columns @model
    @row = @model.find(params[:id])
  end

  def edit
    unless check_existence_model_form
      flash[:danger] = "#{I18n.t 'admin.models.not_created_form'} #{@model.name}"
      redirect_to admin_root_path
    end
    @row = @model.find(params[:id])
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

  def get_object_model
    @model = Kernel.const_get(name_model params[:model])
  end

  def visible_columns(model)
    return model.column_names unless defined? model::VISIBLE_COLUMNS
    model::VISIBLE_COLUMNS
  end

  def check_existence_model_form
    lookup_context.find_all("/admin/model/_form_#{@model.name.downcase}").any?
  end

end
