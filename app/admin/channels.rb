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

  # 
  config.per_page = [10, 50, 100]
  index download_links: [:csv]
  # 

  preserve_default_filters!
  remove_filter :name
    # filter :name, as: :check_boxes #filter for name is true of false
    # filter :name, as: :select  #dropdown for all name options
    # filter :name, as: :numeric #A drop down for selecting “Equal To”, “Greater Than” or “Less Than”
    # filter :name, as: :string #drop down for selecting “Contains”, “Equals”, “Starts with”, “Ends with” 
    # filter :name, as: :select , collection: proc { Channel.where(name:'AA') }
    # filter :name, filters: [:starts_with, :ends_with]
    # filter :name_equals
    # filter :name_contains, label: 'NAME like %%'
    # filter :created_at, as: :date_range 
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
