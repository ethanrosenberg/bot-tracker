ActiveAdmin.register Tweet do
menu priority: 4

index do
  column "id", :id
  column "Tweet Id", :tweet_id
  column "Text", :text
  column "Handle", :profile_handle
  column "Profile Created At", :profile_created_at
  column "Followers", :followers
  column "Default Profile Pic?", :default_profile_pic
  column "Created At", :created_at
end


  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  # permit_params :tweet_id, :text, :user_id, :profile_created_at, :profile_handle, :profile_image_url, :followers
  #
  # or
  #
  # permit_params do
  #   permitted = [:tweet_id, :text, :user_id, :profile_created_at, :profile_handle, :profile_image_url, :followers]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end

end
