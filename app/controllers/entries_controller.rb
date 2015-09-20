class EntriesController < ApplicationController
  before_action :set_entry, only: [:show, :edit, :update, :destroy]

  # GET /entries/1
  # GET /entries/1.json
  def show
  end

  # GET /entries/new
  def new
    @blog = Blog.find(params[:blog_id])
    @entry = Entry.new
  end

  # GET /entries/1/edit
  def edit
  end

  # POST /entries
  # POST /entries.json
  def create
    @blog = Blog.find(params[:blog_id])
    @entry = Entry.new(entry_params)

   	@blog.entries << @entry

    respond_to do |format|
      if @entry.save
        format.html { redirect_to [@blog, @entry], notice: 'Entry was successfully created.' }
        format.json { render :show, status: :created, location: @entry }
      else
        format.html { render :new }
        format.json { render json: @entry.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /entries/1
  # PATCH/PUT /entries/1.json
  def update
    @blog = Blog.find(params[:blog_id])

    respond_to do |format|
      if @entry.update(entry_params)
        format.html { redirect_to [@blog, @entry], notice: 'Entry was successfully updated.' }
        format.json { render :show, status: :ok, location: [@blog, @entry] }
      else
        format.html { render :edit }
        format.json { render json: @entry.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /entries/1
  # DELETE /entries/1.json
  def destroy
    @entry.destroy
    respond_to do |format|
      format.html { redirect_to @blog, notice: 'Entry was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_entry
      @blog = Blog.find(params[:blog_id])
      @entry = Entry.find_by(blog_id: params[:blog_id], id: params[:id])
      @comment = Comment.new
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def entry_params
      params.require(:entry).permit(:title, :body)
    end
end
