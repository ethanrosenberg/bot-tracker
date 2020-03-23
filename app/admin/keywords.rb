ActiveAdmin.register Keyword do
  menu priority: 3

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  # permit_params :term
  #
  # or
  #
  # permit_params do
  #   permitted = [:term]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end

  controller do
    def create

      @keyword = Keyword.new(term: params[:keyword][:term])

      respond_to do |format|
        if @keyword.save
          format.html { redirect_to '/admin/keywords', notice: 'Keyword was added.' }
        else
          STDERR.puts @keyword.errors.to_yaml
          format.html { render action: "new" }
        end
      end
    end

  end


end
