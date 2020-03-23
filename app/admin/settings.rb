ActiveAdmin.register Setting do
menu label: "My Posts"
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

  #
  # or
  #
  # permit_params do
  #   permitted = [:sleep, :tweets_per_keyword, :tweets_per_timeline]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end



end
