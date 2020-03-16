ActiveAdmin.register Account do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  # permit_params :user_id, :creation_date, :handle, :profile_image_url, :followers, :tweet_count
  #
  # or
  #
  # permit_params do
  #   permitted = [:user_id, :creation_date, :handle, :profile_image_url, :followers, :tweet_count]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end


  index do
    column "id", :id
    column "Profile Image" do |prof|
      link_to image_tag(prof.profile_image_url, size: "50x50"), "https://twitter.com/#{prof.handle}", target: :_blank
    end

    column "Handle", :handle
    column "Followers", :followers

    column "User ID", :user_id
    column "Account Creation Date", :creation_date
    column "Created At", :created_at


  end


end
