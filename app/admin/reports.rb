ActiveAdmin.register Report do

menu priority: 6
  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  # permit_params :tweets_per_day, :default_profile_pic, :score, :account_id
  #
  # or
  #
  # permit_params do
  #   permitted = [:tweets_per_day, :default_profile_pic, :score, :account_id]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end

  index do
    column "id", :id
    column "Profile Image" do |prof|
      link_to image_tag(prof.account.profile_image_url, size: "50x50"), "https://twitter.com/#{prof.account.handle}", target: :_blank
    end
    column "Average Tweets Per Day", :tweets_per_day
    column "Languages Found", :languages_found
    column "Post Data" do |post_data|
      post_data.account.rt_percentage
    end
    column "Default Profile Picture?", :default_profile_pic
    column "Handle" do |prof|
      prof.account.handle
    end
    column "Account Creation Date" do |date|
      date.account.creation_date
    end
    column "Report Created" do |report|
      #local_time()
      report.created_at
      #report.created_at.in_time_zone('Pacific Time (US & Canada)').strftime("%B %d, %Y %l:%M %p")

    end
    #column "Report Created", time.:created_at


  end


end
