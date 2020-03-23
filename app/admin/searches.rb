
ActiveAdmin.register Search do


  member_action :stop, method: :get do
    #byebug
    #Resque::Job.destroy(:scrape, Scrape)
    #byebug
    #byebug
    Timber.with_context(app: {name: "bot-tracker", env: Rails.env}) do
      Rails.logger.info "Stopping Search ID: #{params[:id]}"
      #Rails.logger.info "Params Dump: #{params}"
    end

    Search.stop_jobs(params[:id])

    redirect_to '/admin/searches', notice: 'Scraping job was stopped.'
  end

  #member_action :send_push_notification_path do
    #code here
  #  puts "apples!"
    #redirect_to :action => :test
  #end
  config.remove_action_item(:new)

  action_item only: :new do |gift|
    button_to "Run Crawler", "/admin/searches/crawl", :method => :post, :confirm => "Are you sure?"
  end

  #sidebar :actions do
    #button_to "Run Crawler", "/admin/searches/crawl", :method => :post, :confirm => "Are you sure?"
  #end

  collection_action :crawl, :method => :post do
    system "rake scheduler:twitter"
    redirect_to '/admin/searches', :notice => "Crawler was started."
  end



  #form do |f|
    #f.inputs "Search" do
      #f.input :keyword,  :as    => :string, :label => "Keyword", :hint => 'Enter keyword'
    #end
    #f.actions
  #end


  #config.remove_action_item(:create)
  #action_item only: :create do

    #link_to 'Start Twitter Crawler', create_search_path, method: :get
  #end




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

      @search = Search.new(status: "working")

      respond_to do |format|
        if @search.save
          format.html { redirect_to '/admin/searches', notice: 'Scraping job was started.' }
        else
          STDERR.puts @search.errors.to_yaml
          format.html { render action: "new" }
        end
      end
    end

    def test
      byebug
    end






     #Search.stop_jobs(params[:id])
     #byebug
     #Scrape.stop_job(params[:job_id])

     #if self.status != 'finished'
       #STDERR.puts "Stopping job...
       #{}"
      #  Resque::Job.destroy(:harvest, Harvest::Twitter, self.id)
      #  self.status = 'finished'
      #  save
      #end


     #puts "Stopping job..."
     #search = Search.find(params[:id])
     #search.status = 'stopped'
     #search.save

     #Resque::Job.destroy("scrape", Scrape)
     #Resque.workers.each(&:unregister_worker)

     #Resque.workers.each(&:unregister_worker)


     #respond_to do |format|
        # format.html { redirect_to '/admin/searches', notice: 'Scraping job was stopped.' }
    # end






  end

  index do
    column "id", :id
    column "Keyword(s)" do |s|
      s.queries.map {|kw| kw.keyword}.join(", ")
    end
    column "Run Time" do |job|
      if job.status != 'finished'
        distance_of_time_in_words_to_now(job.created_at)
      else
        distance_of_time_in_words(job.created_at, job.updated_at)
      end
    end
   #column "Status", :status
   column "Status" do |res|
     render html: "<div id='status'>#{res.status}</div>".html_safe
    # render html: "<div id='accounts'>#{res.results}</div>".html_safe
   end
   column "Tweets Harvested" do |res|
     #render html: "<div id='messages'>#{res.results}</div>".html_safe
     render html: "<div id='messages'>#{res.results}</div>".html_safe
   end
   column "Progress" do |prog|
     if prog.status != 'finished'
     render html: "<div id='myProgress'>
                     <div id='myBar' style='--width: #{prog.percent_finished}%;'>#{prog.percent_finished}%</div>
                   </div>".html_safe
     else
       render html: "<div id='myProgress'>
                       <div id='myBar' style='--width: 100%;'>100%</div>
                     </div>".html_safe
     end
   end

   column "Stop Search" do |job|
      if job.status == 'finished' || job.status == 'stopped'
        'Done'
      else
        link_to "Stop", "/admin/searches/#{job.id}/stop/"
      end
    end
    column "Date Created", :created_at




  end


end
