class AdminAccess
  attr_writer :group_admin, :model
  ACCESS = {
      0 => [],
      1 => [:index, :show],
      2 => [:index, :show, :new, :create, :edit, :update],
      3 => [:index, :show, :new, :create, :edit, :update, :destroy],
  }
  def initialize(model_name, user_id)
    @group_admin = Admin.find_by_user_id(user_id).group_admin
    @model = model_name.underscore
  end

  def access?
    @group_admin.send(@model) > 0
  end

  def access_method?(method)
    ACCESS[@group_admin.send(@model)].include? method.to_sym
  end

  def access_model?(model = nil)
    if model.nil?
      @group_admin.send(@model) > 0
    else
      @group_admin.send(model.underscore) > 0
    end

  end
end