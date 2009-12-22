class Admin::NotesController < Admin::ResourceController

  only_allow_access_to :new, :create, :edit, :update, :remove, :destroy,
    :when => :admin,
    :denied_url => { :controller => 'pages', :action => 'index' },
    :denied_message => 'You must be an administrator to add or modify notes.'
  
  def new
    @note.reader_id = params[:reader_id]
  end
  
  def create
    @note = Note.new(params[:note])
    if @note.save
      redirect_to edit_admin_reader_url(@note.reader_id)
    else
      render :action => "new"
    end
  end
  
  def update
    @note = Note.find(params[:id])
    if @note.update_attributes(params[:note])
      redirect_to edit_admin_reader_url(@note.reader_id)
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @note = Note.find(params[:id]).destroy
    redirect_to edit_admin_reader_url(@note.reader_id)
  end
  
end