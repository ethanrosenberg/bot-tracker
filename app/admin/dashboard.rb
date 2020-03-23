ActiveAdmin.register_page "Dashboard" do
  menu priority: 1, label: proc { I18n.t("active_admin.dashboard") }

  content title: proc { I18n.t("active_admin.dashboard") } do
    div class: "blank_slate_container", id: "dashboard_default_message" do
      span class: "blank_slate" do
        span Tweet.all.count
        #small I18n.t("active_admin.dashboard_welcome.call_to_action")
        small "tweets harvested"
      end

      span class: "blank_slate" do
        #span I18n.t("active_admin.dashboard_welcome.welcome")
        span Account.all.count
        small "accounts harvested"#I18n.t("active_admin.dashboard_welcome.call_to_action")
      end
    end

      #columns do
      #  panel "Total No. of Contacts" do
      #    ol do
        #    Tweet.all.count
      #    end
      #  end
    #  end


    # Here is an example of a simple dashboard with columns and panels.
    #


    #   column do
    #     panel "Info" do
    #       para "Welcome to ActiveAdmin."
    #     end
    #   end
    # end
  end # content
end
