ActiveAdmin.register Setting do
  #menu priority: 3
    #menu label: "My Posts"
    #index :title => "Harvester Settings" do

  #end


  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
   permit_params :sleep, :tweets_per_keyword, :tweets_per_timeline

   #actions :index, :show, :new, :create, :edit, :update, :destroy
   config.remove_action_item(:new)

   action_item only: :new  do
    if Setting.all.count === 0
      #link_to I18n.t('active_admin.new'), new_resource_path(resource)
      link_to 'Add New Setting', new_admin_setting_path
    end
  end

  action_item :view_site do
        #link_to I18n.t('active_admin.new'), new_resource_path(resource)
     link_to 'Admin Users', '/admin/admin_users'


  end
  action_item :view_site do
     link_to 'Workers', '/resque_web'
  end

  controller do

    before_action { @page_title = "Harvester Settings" }
  end

  #
  # or
  #
  # permit_params do
  #   permitted = [:sleep, :tweets_per_keyword, :tweets_per_timeline]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end



end
