ActiveAdmin.register Search do

  form do |f|
    f.inputs "Search" do
      f.input :keyword,  :as    => :string, :label => "Keyword", :hint => 'Enter keyword'
    end
    f.actions
  end

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  # permit_params :keyword
  #
  # or
  #
  # permit_params do
  #   permitted = [:keyword]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end

  controller do
    def create

      @search = Search.new(keyword: params[:search][:keyword], status: "started")

      respond_to do |format|
        if @search.save
          format.html { redirect_to '/admin/searches', notice: 'Scraping job was started.' }
        else
          STDERR.puts @search.errors.to_yaml
          format.html { render action: "new" }
        end
      end
    end

  end

end
