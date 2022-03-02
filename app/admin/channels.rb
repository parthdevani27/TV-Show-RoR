ActiveAdmin.register Channel do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :name, :logo
  #
  # or
  #
  # permit_params do
  #   permitted = [:name, :logo]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
  index do
    selectable_column
    id_column
    column :name
    column :logo do |item|
              image_tag(item.logo.url(:thumb)) 
            end
    column :created_at
    column :updated_at
    actions
  end
end
