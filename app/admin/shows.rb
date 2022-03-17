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
  scope :all, default: true 

  scope :Upcomming ,group: :time, default: true do |show|
    show.where(startTime:  Time.now.utc..Float::INFINITY)
    # show.where(startTime:  Time.now.utc..Float::INFINITY).Where(startTime:  1.days.ago..-Float::INFINITY)
  end 

  scope :Yesterday ,group: :time, default: true do |show|
    today = Date.today - 1
    show.where(:startTime => today.all_day)
  end 

  scope :Today ,group: :time, default: true do |show|
    today = Date.today 
    show.where(:startTime => today.all_day)
  end 

  scope :Tomorrow ,group: :time, default: true do |show|
    today = Date.today + 1
    show.where(:startTime => today.all_day)
  end 

  # Channel.all.each do |item|
  #   scope item.name ,group: :channel,default: true do |show|
  #       show.where(:channel => item)
  #   end
  # end

  filter :startTime ,as: :date_time_picker_filter

  filter :id, as: :numeric_range_filter

  filter :channel, as: :search_select_filter

    filter :name_or_description_cont

  # filter :startTime, as: :select, collection: -> { Show.pluck( :startTime) }

  filter :get_filter, :as => :string, label: "Search All Text Fields"



  filter :channel,:as => :select
  index do
    selectable_column
    id_column
    column :name
    column :channel
    column :logo do |item|
        if item.logo.url(:thumb)
          image_tag(item.logo.url(:thumb)) if item.logo!= nil
        end 
      end
    # image_column :logo , style: :thumb
    # state_column :name
    column :startTime
    column :endTime
    column :created_at
    actions
  end



  form do |f|
    f.inputs do
      # f.semantic_errors *f.object.errors.keys
      f.input :name  
      # f.input :name  , as: :tags, collection: ['Julio', 'Emilio', 'Leandro']
      # f.input :name  , as: :color_picker
      f.input :channel
      f.input :logo
      f.input :startTime,as: :date_time_picker
      f.input :endTime, as: :date_time_picker
      # f.time_select :endTime
      f.input :description
    end
    f.actions
  end
  
end
