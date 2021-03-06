class Admin::ModelsController < Admin::BaseController

  before_action :get_object_model, :guard

  def index
    @visible_columns = model_visible_columns
    @index = @model.all
  end

  def show
    @visible_columns = model_visible_columns
    @row = @model.find(params[:id])
  end

  def edit
    unless check_existence_model_form?
      flash[:danger] = "#{I18n.t 'admin.models.not_created_form'} #{@model.name}"
      redirect_to admin_model_rows_path(@model.name.underscore)
    end
    @row = @model.find(params[:id])
  end

  def new
    unless check_existence_model_form?
      flash[:danger] = "#{I18n.t 'admin.models.not_created_form'} #{@model.name}"
      redirect_to admin_model_rows_path(@model.name.underscore)
    end
    @row = @model.new
  end

  def update
    data_update = model_params

    unless data_update.present?
      redirect_to admin_edit_model_row_path(@model, params[:id])
      return
    end

    @row = @model.find(params[:id])
    if @row.update_attributes(data_update)
      flash[:info] = "#{I18n.t 'admin.models.success.update'} #{name_model @model.name}"
      redirect_to admin_model_row_path(@model.name.underscore, params[:id])
    else
      flash[:danger] = "#{I18n.t 'admin.models.errors.update'} #{name_model @model.name}"
      redirect_to admin_edit_model_row_path(@model.name.underscore, params[:id])
    end
  end

  def create
    data_create = model_params

    unless data_create.present?
      redirect_to admin_new_model_row_path(@model)
      return
    end

    @row = @model.new(data_create)

    if @row.save
      flash[:success] = "#{I18n.t 'admin.models.success.create'} #{name_model @model.name}"
      redirect_to admin_model_rows_path(@model.name.underscore)
    else
      flash.now[:danger] = "#{I18n.t 'admin.models.errors.create'} #{name_model @model.name}"
      render action: "new"
    end
  end

  def destroy
    row = @model.find(params[:id])
    row.destroy

    if row.destroyed
      flash[:success] = "#{I18n.t 'admin.models.success.destroy'} #{params[:id]}"
      redirect_to admin_model_rows_path(@model.name.underscore)
    else
      flash[:danger] = I18n.t 'admin.models.errors.destroy'
      redirect_to admin_model_rows_path(@model.name.underscore)
    end

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

  def model_visible_columns
    return @model::visible_columns if defined? @model::visible_columns
    flash[:danger] = "#{I18n.t 'admin.models.errors.defined_visible_columns'} #{name_model @model.name}"
    ['id']
  end

  def model_edible_columns
    unless defined? @model::edible_columns
      flash.now[:danger] = "#{I18n.t 'admin.models.errors.defined_edible_columns'} #{name_model @model.name}"
      return []
    end
    @model::edible_columns
  end

  def check_existence_model_form?
    lookup_context.find_all("/admin/models/_form_#{@model.name.underscore}").any?
  end

  def model_params
    params.require(@model.name.underscore.to_sym).permit(model_edible_columns)
  end

  def guard
    @guard = AdminAccess.new @model.name, current_user.id
    unless @guard.access_model?
      flash[:danger]= I18n.t 'admin.access_error'
      redirect_to admin_root_path and return
    end

    unless @guard.access_method? params[:action]
      flash[:danger]= I18n.t 'admin.access_error'
      redirect_to admin_model_rows_path(@model.name.underscore) and return
    end
  end

end
