ActiveAdmin.register Show do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :name, :channel_id, :logo, :date, :startTime, :endTime, :description
  #
  # or
  #
  # permit_params do
  #   permitted = [:name, :channel_id, :logo, :date, :startTime, :endTime, :description]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
 

  index do
    selectable_column
    id_column
    column :name
    column :channel
    column :logo do |item|
              image_tag(item.logo.url(:thumb)) 
            end
    column :startTime
    column :endTime
    column :created_at
    actions
  end

  form do |f|
    f.inputs do
      f.input :name  
      f.input :channel
      f.input :logo
      f.input :startTime, as: :datetime_picker
      f.input :endTime, as: :datetime_picker
      f.input :description
    end
    f.actions
  end
  
end
