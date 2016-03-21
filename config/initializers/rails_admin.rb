RailsAdmin.config do |config|

  config.authenticate_with do
    unless session[:member_id].blank?
      m = Member.find(session[:member_id])
      unless m.blank?
        if m.admin
          # good to go, no redirects
          true
        else
          redirect_to '/'
        end
      else
        redirect_to '/'
      end
    else
      redirect_to '/'
    end
  end

  config.actions do
    dashboard                     # mandatory
    index                         # mandatory
    new
    export
    # bulk_delete
    show
    edit
    delete
    show_in_app

    ## With an audit adapter, you can add:
    # history_index
    # history_show
  end
end
